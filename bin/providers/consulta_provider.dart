import 'dart:convert';

import 'package:http/http.dart';

import '../modelo/consulta.dart';
import '../modelo/medico.dart';
import '../modelo/medico.dart';
import '../modelo/paciente.dart';

class Consulta_provider{

  Consulta_provider(){}

  final urlBase =
      'https://consulta-3682d-default-rtdb.europe-west1.firebasedatabase.app/consulta';
  final consultas = '/consultas.json';
  final medicos = '/medicos.json';
  final pacientes = '/pacientes.json';


  Future<List<Consulta>> getConsultas() async {
    List<Consulta> listaConsultas = [];
    Map<String,dynamic> consultasMap = jsonDecode((await get(Uri.parse(urlBase+consultas))).body);
    consultasMap.forEach((clave, consulta) {
        listaConsultas.add(Consulta(medico: Medico.fromJson(consulta['medico']), paciente: (consulta['paciente']==null?null:Paciente.fromJson(consulta['paciente'])), libre: consulta['libre']));
     });
    return listaConsultas;
  }

  Future<List<Paciente>> getPacientes() async{
    List<Paciente> listaPacientes =[];
    Map<String,dynamic> pacientesMap= jsonDecode((await get(Uri.parse(urlBase+pacientes))).body);
    pacientesMap.forEach((clave, paciente) {
        listaPacientes.add(Paciente(paciente['numhistoria'], paciente['dni'], 
        paciente['nonbmre'], paciente['apellidos'], paciente['sintomas'],
         paciente['pos']));
     });
    return listaPacientes;
  }

  Medico getMedicoId(int id,List<Medico> medicos)=> medicos.firstWhere((medico) => medico.id==id);
}