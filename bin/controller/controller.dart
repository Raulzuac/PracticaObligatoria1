import 'dart:math';

import '../models/consulta.dart';
import '../models/paciente.dart';
import '../providers/consulta_provider.dart';


///Método que crea el controlador con los datos de firebase
Future<Controller> nuevoController() async {
  return Controller(
      await ConsultaProvider().getConsultas(),
      await ConsultaProvider().getPacientes(),
      await ConsultaProvider().getPacientesCurados());
}

///Clase controlador
///Controla el funcionamiento de la aplicación
class Controller {
  late List<Consulta> consultas;
  late List<Paciente> pacientesCola;
  late List<Paciente> pacientesCurados;

  ///Constructor de dart
  Controller(this.consultas, this.pacientesCola, this.pacientesCurados);

  ///Método que crea e inserta el paciente para despues insertarlo en firebase
  Future<int> insertaPaciente(
      String dni, String nombre, String apellidos, String sintomas) async {
    Paciente p = Paciente("", generaNumHistoria(), dni, nombre, apellidos,
        sintomas, DateTime.now().toString());
    //mira si hay consultas vacías
    if (consultasLibres() != 0) {
      Consulta c = firstConsultaLibre();
      c.libre = false;
      c.paciente = p;
      await ConsultaProvider().insertaPacienteConsulta(c);

      return c.id;
    } else {
      //sino
      String id = await ConsultaProvider().insertaPacienteCola(p);
      p.id = id;
      pacientesCola.add(p);
      return -1;
    }
  }
  ///Devuelve la cola de pacientes
  List<Paciente> getCola() {
    return pacientesCola;
  }
  ///Devuelve la lista de consultas
  List<Consulta> getConsulta() {
    return consultas;
  }
  ///Método que genera el número de historia del paciente
  int generaNumHistoria() {
    int id = -1;
    bool correcto = false;

    while (!correcto) {
      id = generarNumeroAleatorio();//Generamos el número aleatorio
      if (esNumHistoriaUnico(id)) {//Comprobamos que no esté repetido
        correcto = true;
      }
    }

    return id;
  }
  ///Método que genera un número aleatorio
  int generarNumeroAleatorio() {
    return Random().nextInt(10000);
  }
  ///Método que comprueba si el numero que se le pasa esta ya usado por alguno 
  ///de los pacientes del sistema esté donde esté
  bool esNumHistoriaUnico(int id) {
    return ((pacientesCola.isEmpty ||
            pacientesCola.any((paciente) => paciente.numHistoria != id)) &&
        (pacientesCurados.isEmpty ||
            pacientesCurados.any((paciente) => paciente.numHistoria != id)) &&
        consultas.any((consulta) => (consulta.paciente != null &&
            consulta.paciente!.numHistoria != id)));
  }


  // Antigüo método de generación del número de historia
  // int generaNumHistoria() {
  //   bool correcto = false;
  //   int id = -1;
  //   while (!correcto) {
  //     id = Random().nextInt(10000);
  //     if ((pacientesCola.isEmpty ||
  //             pacientesCola.any((paciente) => paciente.numHistoria != id)) &&
  //         (pacientesCurados.isEmpty ||
  //             pacientesCurados.any((paciente) => paciente.numHistoria != id)) &&
  //         consultas.any((consulta) => (consulta.paciente != null &&
  //             consulta.paciente!.numHistoria != id))) {
  //       correcto = true;
  //     }
  //   }
  //   return id;
  // }

  ///Devuelve el número de consultas libres
  int consultasLibres() {
    int resultado = 0;
    consultas.forEach((consulta) => {if (consulta.libre) resultado++});
    return resultado;
  }

  ///Devuelve la primera consulta que esté libre
  Consulta firstConsultaLibre() =>
      consultas.firstWhere((consulta) => consulta.libre);

  /// Antigüo método que gestiona como se libera la consulta
  // Future<bool> liberaConsulta(int idConsulta) async {
  //   Consulta c = buscaConsulta(idConsulta);
  //   if (c.libre) return false;///Comprobamos que la consutla que le hemos dado esta libre
  //   c.libre = true;
  //   if (pacientesCola.isEmpty) {//Si no hay ningun paciente
  //     await ConsultaProvider().limpiaConsulta(c);
  //     c.paciente = null;
  //   } else {//Si hay algún paciente
  //     await ConsultaProvider().eliminaPaciente(c, pacientesCola.first);
  //     c.paciente = pacientesCola.first;
  //     pacientesCola.removeAt(0);
  //     await ConsultaProvider().insertaPacienteConsulta(c);
  //   }
  //   return true;
  // }

  ///Método que gestiona la salida de un paciente de la consulta
  Future<bool> saleConsulta(int idConsulta) async {
    Consulta c = buscaConsulta(idConsulta);
    if (c.libre) return false;
    c.libre = true;
    if (pacientesCola.isEmpty) {
      await ConsultaProvider().insertaPacienteCurado(c.paciente!);
      pacientesCurados.add(c.paciente!);
      c.paciente = null;
      await ConsultaProvider().limpiaConsulta(c);
    } else {
      pacientesCola.sort(
          (paciente1, paciente2) => paciente1.fecha.compareTo(paciente2.fecha));
      Paciente p = pacientesCola.removeAt(0);
      //Añadimos el paciente de la consulta a curados
      pacientesCurados.add(c.paciente!);
      //El paciente de la consulta será el de pacientes
      c.paciente = p;
      c.libre = false;
      await ConsultaProvider().insertaPacienteConsulta(c);
      await ConsultaProvider().eliminaPaciente(c, p);
    }

    return true;
  }
  ///Devuelve la consulta con el id que se le pasa
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
