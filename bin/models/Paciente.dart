class Paciente {
  int numHistoria;
  String dni;
  String nombre;
  String apellidos;
  String sintomas;

  Paciente(
      {required this.numHistoria,
      required this.dni,
      required this.nombre,
      required this.apellidos,
      required this.sintomas});

  factory Paciente.fromJson(Map<String, dynamic> json) => Paciente(
      numHistoria: json['numHistoria'],
      dni: json['dni'],
      nombre: json['nombre'],
      apellidos: json['apellidos'],
      sintomas: json['sintomas']);

  @override
  String toString() {
    return '''
                    	╔══════════════════════════════╣ Paciente ╠═══════════════════════════════╗  
                    	  -----------------------------------------------------------------------
                    	  Nombre : $nombre $apellidos                             
                    	  ----------------------------------------------------------------------- 
                    	  DNI: $dni                                      
                    	  -----------------------------------------------------------------------
                        Número Historia: $numHistoria
                    	  -----------------------------------------------------------------------
                        Síntomas: $sintomas
                    	  -----------------------------------------------------------------------
                    	╚═════════════════════════════════════════════════════════════════════════╝


''';
  }
}
