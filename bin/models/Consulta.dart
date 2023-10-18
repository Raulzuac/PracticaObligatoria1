import 'Medico.dart';
import 'Paciente.dart';

class Consulta {
  int id;
  Medico medico;
  Paciente? paciente;
  bool libre;

  Consulta({required this.id, required this.medico, this.paciente, required this.libre});
  
  factory Consulta.fromJson(Map<String, dynamic> json) => Consulta(
    id: json['id'],
    medico: Medico.fromJson(json['medico']),
    paciente: Paciente.fromJson(json['paciente']),
    libre: json['libre'],
  );

  @override
  String toString() {
    if(paciente!=null){
      return '''
                    	╔══════════════════════════════╣ Consulta $id ╠═══════════════════════════════╗  
                    	  --------------------------------------------------------------------------  
                    	  Nombre del médico: ${medico.nombre}                              
                    	  --------------------------------------------------------------------------   
                    	  Especialidad: ${medico.especialidad}    
                    	  --------------------------------------------------------------------------  
                    	  Paciente: ${paciente!.nombre} ${paciente!.apellidos}                                         
                    	  --------------------------------------------------------------------------  
                    	  Número historia: ${paciente!.numHistoria}                                        
                    	  --------------------------------------------------------------------------   
                    	╚════════════════════════════════════════════════════════════════════════════╝
''';
    }else{
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
