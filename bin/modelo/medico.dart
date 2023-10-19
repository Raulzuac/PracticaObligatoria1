
import 'dart:convert';

Medico medicoFromJson(String string) => Medico.fromJson(jsonDecode(string));

class Medico{
  int id;
  String nombre;
  String especialidad;

  Medico(this.id,this.nombre,this.especialidad);

  factory Medico.fromJson(Map<String,dynamic> json) => 
  Medico(json['id'], json['nombre'], json['especialidad']);

  @override
  String toString() {
    return '''
id: $id
Nombre: $nombre
Especialidad: $especialidad
''';
  }
}