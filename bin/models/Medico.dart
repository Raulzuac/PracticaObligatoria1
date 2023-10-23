import 'dart:convert';

Medico medicoFromJson(String string) => Medico.fromJson(jsonDecode(string));

class Medico {
  int id;
  String nombre;
  String especialidad;

  ///Constructor de la clase
  Medico(this.id, this.nombre, this.especialidad);

  ///Constructor nombrado que recibe un json y lo convierte en un objeto
  factory Medico.fromJson(Map<String, dynamic> json) =>
      Medico(json['id'], json['nombre'], json['especialidad']);

  Map<String, dynamic> toJson() => {
        "especialidad": especialidad,
        "id": id,
        "nombre": nombre,
      };

  @override
  String toString() {
    return '''
                    	╔══════════════════════════════╣ Médico ╠═══════════════════════════════╗  
                    	  ---------------------------------------------------------------------
                    	  Nombre : $nombre                             
                    	  ---------------------------------------------------------------------   
                    	  Especialidad: $especialidad
                    	  ---------------------------------------------------------------------  
                    	╚════════════════════════════════════════════════════════════════════════╝

''';
  }
}
