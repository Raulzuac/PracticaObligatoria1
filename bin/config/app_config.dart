import 'dart:convert';
import 'dart:io';

class AppConfig {
  ///Ruta donde esta el archivo de configuracion
  final file = File('bin/resources/config.json');

  ///Metodos que devuelven las rutas del archivo de configuracion
  String getRutaFirabase() =>
      (jsonDecode(file.readAsStringSync())['endPoint']).toString();

  String getRutaPacientes() =>
      (jsonDecode(file.readAsStringSync())['pacientes']).toString();

  String getRutaMedicos() =>
      (jsonDecode(file.readAsStringSync())['medicos']).toString();

  String getRutaPacientesCurados() =>
      (jsonDecode(file.readAsStringSync())['curados']).toString();

  String getRutaConsultas() =>
      (jsonDecode(file.readAsStringSync())['consultas']).toString();
}
