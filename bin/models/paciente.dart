import 'dart:convert';

Paciente pacienteFromJson(String string) =>
    Paciente.fromJson(jsonDecode(string));

///Clase paciente
class Paciente {
  late String id;
  late int numHistoria;
  late String dni;
  late String nombre;
  late String apellidos;
  late String sintomas;
  late String fecha;

  //Constructor del paciente
  Paciente(this.id, this.numHistoria, this.dni, this.nombre, this.apellidos,
      this.sintomas, this.fecha);
  
  //Constructor factoría del paciente desde un json
  factory Paciente.fromJson(Map<String, dynamic> json) => Paciente(
      json.keys.first,
      json['numhistoria'],
      json['dni'],
      json['nombre'],
      json['apellidos'],
      json['sintomas'],
      json['fecha']);

  //Método toJson, crea un json a partir del objeto
  Map<String, dynamic> toJson() => {
        "apellidos": apellidos,
        "dni": dni,
        "nombre": nombre,
        "numhistoria": numHistoria,
        "fecha": fecha,
        "sintomas": sintomas
      };

  ///Método que utilizamos para pintar el paciente de la cola
  String pintaPacienteCola(int pos) {
    String pintadoBajo = '═';
    if (pos.toString().length == 2) pintadoBajo = '══';
    if (pos.toString().length == 3) pintadoBajo = '═══';
    return '''
                    	╔══════════════════════════════╣ Paciente en la posición $pos ╠═══════════════════════════════╗  
                    	  -----------------------------------------------------------------------------------------
                    	  - Nombre : $nombre $apellidos                             
                    	  ----------------------------------------------------------------------------------------- 
                    	  - DNI: $dni                                      
                    	  -----------------------------------------------------------------------------------------
                          - Número Historia: $numHistoria
                    	  -----------------------------------------------------------------------------------------
                          - Síntomas: $sintomas
                    	  -----------------------------------------------------------------------------------------
                    	╚═════════════════════════════════════════════════════$pintadoBajo════════════════════════════════════╝


''';
  }
  
}
