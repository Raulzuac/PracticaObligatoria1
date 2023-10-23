import 'dart:math';

import '../models/consulta.dart';
import '../models/paciente.dart';
import '../providers/consulta_provider.dart';

Future<Controller> nuevoController() async {
  return Controller(
      await ConsultaProvider().getConsultas(),
      await ConsultaProvider().getPacientes(),
      await ConsultaProvider().getPacientesCurados());
}

class Controller {
  late List<Consulta> consultas;
  late List<Paciente> pacientesCola;
  late List<Paciente> pacientesCurados;

  Controller(this.consultas, this.pacientesCola, this.pacientesCurados);

  Future<int> insertaPaciente(
      String dni, String nombre, String apellidos, String sintomas) async {
    Paciente p = Paciente("", generaNumHistoria(), dni, nombre, apellidos,
        sintomas, DateTime.now().toString());
    //mira si hay consultas vacías
    if (consultasLibres() != 0) {
      Consulta c = firstConsultaLibre();
      ConsultaProvider().insertaPacienteConsulta(c, p);
      return c.id;
    } else {
      //sino
      String id = await ConsultaProvider().insertaPacienteCola(p);
      p.id = id;
      return -1;
    }
  }

  void saleConsulta(Consulta c) {
    //sino
    //eliminamos el paciente de la consulta

    if (pacientesCola.isEmpty) {
      c.paciente = null;
      ConsultaProvider().limpiaConsulta(c);
      c.libre = true;
    } else {
      pacientesCola.sort(
          (paciente1, paciente2) => paciente1.fecha.compareTo(paciente2.fecha));
      Paciente p = pacientesCola.removeAt(0);
      c.paciente = p;
      ConsultaProvider().insertaPacienteConsulta(c, p);
      ConsultaProvider().eliminaPaciente(p);
    }

    //si hay alguien en cola
    //guardar el primero de la cola

    //sustituir el de la consulta
  }

  List<Paciente> getCola() {
    return pacientesCola;
  }

  List<Consulta> getConsulta() {
    return consultas;
  }

  int generaNumHistoria() {
    int id = -1;
    bool correcto = false;

    while (!correcto) {
      id = generarNumeroAleatorio();
      if (esNumHistoriaUnico(id)) {
        correcto = true;
      }
    }

    return id;
  }

  int generarNumeroAleatorio() {
    return Random().nextInt(10000);
  }

  bool esNumHistoriaUnico(int id) {
    return pacientesCola.every((paciente) => paciente.numHistoria != id) &&
        consultas.every((consulta) => (consulta.paciente != null &&
            consulta.paciente!.numHistoria != id));
  }

  int consultasLibres() {
    int resultado = 0;
    consultas.forEach((consulta) => {if (consulta.libre) resultado++});
    return resultado;
  }

  Consulta firstConsultaLibre() =>
      consultas.firstWhere((consulta) => consulta.libre);

  bool liberaConsulta(int idConsulta) {
    Consulta c = buscaConsulta(idConsulta);
    if (c.libre) return false;
    c.libre = true;
    c.paciente = null;
    ConsultaProvider().eliminaPaciente(c.paciente!);

    return true;
  }

  Consulta buscaConsulta(int idConsulta) {
    Consulta? consulta;
    for (var c in consultas) {
      if (c.id == idConsulta) {
        consulta = c;
      }
    }
    return consulta!;
  }
}
