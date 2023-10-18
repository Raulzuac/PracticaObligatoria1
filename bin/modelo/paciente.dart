import 'dart:convert';

Paciente pacienteFromJson(String string)=>Paciente.fromJson(jsonDecode(string));

class Paciente{
  late int numHistoria;
  late String dni;
  late String nombre;
  late String apellidos;
  late String sintomas;
  late int pos;
  
  
  
  Paciente(this.numHistoria,this.dni,this.nombre,this.apellidos,this.sintomas,this.pos);
  
  factory Paciente.fromJson(Map<String,dynamic> json)=>
  Paciente(json['numhistoria'],
   json['dni'], 
   json['nombre'], 
   json['apellidos'], 
   json['sintomas'],
   json['pos']);
  
  @override
  String toString() {
    return '''
    ****** Datos del paciente ******
    Nombre del paciente: $nombre $apellidos
    Historia del paciente: $numHistoria
    Sintomas del paciente: $sintomas
''';
  }
}