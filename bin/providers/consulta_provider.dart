import 'dart:convert';

import 'package:http/http.dart';

import '../modelo/consulta.dart';
import '../modelo/medico.dart';
import '../modelo/paciente.dart';

class ConsultaProvider{

  ConsultaProvider();

  final urlBase =
      'https://consulta-3682d-default-rtdb.europe-west1.firebasedatabase.app/';
  final consultas = 'consultas.json';
  final pacientes = 'pacientes.json';
  final curados = 'curados.json';


  Future<List<Consulta>> getConsultas() async {
    List<Consulta> listaConsultas = [];
    Map<String,dynamic> consultasMap = jsonDecode((await get(Uri.parse(urlBase+consultas))).body);
    consultasMap.forEach((clave, consulta) {
        listaConsultas.add(Consulta(medico: Medico.fromJson(consulta['medico']), paciente: (consulta['paciente']==null?null:Paciente.fromJson(consulta['paciente'])), libre: consulta['libre'],id: consulta['id']));
     });
    return listaConsultas;
  }

  Future<List<Paciente>> getPacientes() async{
    List<Paciente> listaPacientes =[];
    Map<String,dynamic> pacientesMap= jsonDecode((await get(Uri.parse(urlBase+pacientes))).body);
    pacientesMap.forEach((clave, paciente) {
        listaPacientes.add(Paciente(clave,paciente['numhistoria'], paciente['dni'], 
        paciente['nombre'], paciente['apellidos'], paciente['sintomas'],
         paciente['fecha']));
     });
    return listaPacientes;
  }
  void eliminaPaciente(Paciente paciente){
    delete(Uri.parse('$urlBase/pacientes/${paciente.id}.json'));
    post(Uri.parse('$urlBase$curados'),body: jsonEncode(paciente.toJson()));
  }
  Future<String> insertaPacienteCola(Paciente paciente)async{
    Response r =await post(Uri.parse('$urlBase$pacientes'),body: jsonEncode(paciente.toJson()));
    return jsonDecode(r.body)['name'];
  }

  Medico getMedicoId(int id,List<Medico> medicos)=> medicos.firstWhere((medico) => medico.id==id);

  void limpiaConsulta(Consulta c) {
    delete(Uri.parse('$urlBase/consultas/Consulta${c.id}/paciente.json'));
  }

  void insertaPacienteConsulta(Consulta c, Paciente p) {
    put(Uri.parse('$urlBase/consultas/Consulta${c.id}/paciente.json'),body: jsonEncode(p.toJson()));
  }

  Future<List<Paciente>> getPacientesCurados() async{
     List<Paciente> listaPacientes =[];
    Map<String,dynamic> pacientesMap= jsonDecode((await get(Uri.parse(urlBase+curados))).body);
    pacientesMap.forEach((clave, paciente) {
        listaPacientes.add(Paciente(clave,paciente['numhistoria'], paciente['dni'], 
        paciente['nombre'], paciente['apellidos'], paciente['sintomas'],
         paciente['fecha']));
     });
    return listaPacientes;
  }


}