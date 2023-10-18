
import 'dart:convert';

Medico medicoFromJson(String string) => Medico.fromJson(jsonDecode(string));

class Medico{
  int id;
  String nobmre;
  String especialidad;

  Medico(this.id,this.nobmre,this.especialidad);

  factory Medico.fromJson(Map<String,dynamic> json) => 
  Medico(json['id'], json['nombre'], json['especialidad']);

  @override
  String toString() {
    return '''
id: $id
Nombre: $nobmre
Especialidad: $especialidad
''';
  }
}