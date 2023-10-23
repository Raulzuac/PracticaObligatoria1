import 'medico.dart';
import 'paciente.dart';


///Clase consulta
class Consulta {
  int id;
  bool libre;
  Medico medico;
  Paciente? paciente;

  ///Constructor de la clase
  Consulta(
      {required this.medico,
      this.paciente,
      required this.libre,
      required this.id});

  ///Constructor nombrado que recibe un json y lo convierte en un objeto
  factory Consulta.fromJson(Map<String, dynamic> json) => Consulta(
      medico: Medico.fromJson(json['medico']),
      libre: json['libre'],
      paciente: (json['paciente'] == null
          ? null
          : Paciente.fromJson(json['paciente'])),
      id: json['id']);

  ///Método toJson, convcierte el objeto en un Json
  Map<String, dynamic> toJson() {
    return paciente == null
        ? {"id": id, "libre": libre, "medico": medico.toJson()}
        : {
            "id": id,
            "libre": libre,
            "medico": medico.toJson(),
            "paciente": paciente!.toJson(),
          };
  }
  ///Tostring para pintar la consulta
  @override
  String toString() {
    if (paciente != null) {
      return '''
                    	╔══════════════════════════════╣ Consulta $id ╠═══════════════════════════════╗  
                    	  --------------------------------------------------------------------------  
                    	  - Nombre del médico: ${medico.nombre}                              
                    	  --------------------------------------------------------------------------   
                    	  - Especialidad: ${medico.especialidad}    
                    	  --------------------------------------------------------------------------  
                    	  - Paciente: ${paciente!.nombre} ${paciente!.apellidos}                                         
                    	  --------------------------------------------------------------------------  
                    	  - Número historia: ${paciente!.numHistoria}                                        
                    	  --------------------------------------------------------------------------   
                    	╚════════════════════════════════════════════════════════════════════════════╝
''';
    } else {
      return '''
                    	╔══════════════════════════════╣ Consulta $id ╠═══════════════════════════════╗  
                    	  --------------------------------------------------------------------------  
                    	  Nombre del médico: ${medico.nombre}                              
                    	  --------------------------------------------------------------------------   
                    	  Especialidad: ${medico.especialidad}                             
                    	  --------------------------------------------------------------------------   
                    	╚════════════════════════════════════════════════════════════════════════════╝
''';
    }
  }
}
