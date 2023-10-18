class Medico {
  int id;
  String nombre;
  String especialidad;

  Medico({required this.id, required this.nombre, required this.especialidad});

  factory Medico.fromJson(Map<String, dynamic> json) => Medico(
        id: json['id'],
        nombre: json['nombre'],
        especialidad: json['especialidad'],
      );

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
