import 'dart:convert';

import 'package:http/http.dart';

import '../config/app_config.dart';
import '../models/consulta.dart';
import '../models/medico.dart';
import '../models/paciente.dart';

/// Clase que proporciona acceso a datos de consultas y pacientes desde firabase
class ConsultaProvider {
  /// Constructor de la clase
  ConsultaProvider();

  /// URL base de la base de datos Firebase
  final urlBase = AppConfig().getRutaFirabase();

  /// Ruta a la colección de consultas en la base de datos
  final consultas = AppConfig().getRutaConsultas();

  /// Ruta a la colección de pacientes en cola en la base de datos
  final pacientes = AppConfig().getRutaPacientes();

  /// Ruta a la colección de pacientes curados en la base de datos
  final curados = AppConfig().getRutaPacientesCurados();

  ///Obtiene la lista de consultas
  Future<List<Consulta>> getConsultas() async {
    //Inicializo las consultas  y despues las recupero de firebase
    List<Consulta> listaConsultas = [];
    Map<String, dynamic> consultasMap =
        jsonDecode((await get(Uri.parse(urlBase + consultas))).body);
    consultasMap.forEach((clave, consulta) {
      //Lo añado a la lista de consultas
      listaConsultas.add(Consulta(
          medico: Medico.fromJson(consulta['medico']),
          paciente: (consulta['paciente'] == null
              ? null
              : Paciente.fromJson(consulta['paciente'])),
          libre: consulta['libre'],
          id: consulta['id']));
    });
    return listaConsultas;
  }

  ///Obtiene la lista de pacientes
  Future<List<Paciente>> getPacientes() async {
    ///Inicializo las consultas  y despues las recupero de firebase
    List<Paciente> listaPacientes = [];
    Response r = await get(Uri.parse(urlBase + pacientes));

    if (r.body != 'null') {
      Map<String, dynamic> pacientesMap = jsonDecode(r.body);

      pacientesMap.forEach((clave, paciente) {
        listaPacientes.add(Paciente(
            clave,
            paciente['numhistoria'],
            paciente['dni'],
            paciente['nombre'],
            paciente['apellidos'],
            paciente['sintomas'],
            paciente['fecha']));
      });
    }
    return listaPacientes;
  }

  ///Elimino a un paciente determinado de la base de datos
  Future<void> eliminaPaciente(Consulta c, Paciente paciente) async {
    await delete(Uri.parse('${urlBase}pacientes/${paciente.id}.json'));
    await post(Uri.parse('$urlBase$curados'),
        body: jsonEncode(c.paciente!.toJson()));
  }

  ///Inserta un nuevo paciente en la base de datos
  Future<String> insertaPacienteCola(Paciente paciente) async {
    Response r = await post(Uri.parse('$urlBase$pacientes'),
        body: jsonEncode(paciente.toJson()));
    return jsonDecode(r.body)['name'];
  }

  ///Inserta una nueva consulta en la base de datos
  Medico getMedicoId(int id, List<Medico> medicos) =>
      medicos.firstWhere((medico) => medico.id == id);

  ///Inserta una nueva consulta en la base de datos
  Future<void> limpiaConsulta(Consulta c) async {
    await put(Uri.parse('$urlBase/consultas/Consulta${c.id}.json'),
        body: jsonEncode(c));
  }

  ///Inserta una nueva consulta en la base de datos
  Future<void> insertaPacienteConsulta(Consulta c) async {
    await put(Uri.parse('$urlBase/consultas/Consulta${c.id}.json'),
        body: jsonEncode(c.toJson()));
  }

  ///Inserta una nueva consulta en la base de datos
  Future<List<Paciente>> getPacientesCurados() async {
    List<Paciente> listaPacientes = [];
    Response r = await get(Uri.parse(urlBase + curados));
    if (r.body != 'null') {
      Map<String, dynamic> pacientesMap = jsonDecode(r.body);
      pacientesMap.forEach((clave, paciente) {
        listaPacientes.add(Paciente(
            clave,
            paciente['numhistoria'],
            paciente['dni'],
            paciente['nombre'],
            paciente['apellidos'],
            paciente['sintomas'],
            paciente['fecha']));
      });
    }
    return listaPacientes;
  }
  ///Inserta el paceinte que le pasas en la lista de pacientes curados
  Future<void> insertaPacienteCurado(Paciente paciente) async {
    await post(Uri.parse('$urlBase$curados'),
        body: jsonEncode(paciente.toJson()));
  }
}
