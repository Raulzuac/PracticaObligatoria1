import 'medico.dart';
import 'paciente.dart';

class Consulta{
  int id;
  bool libre;
  Medico medico;
  Paciente? paciente;

  Consulta({required this.medico,this.paciente,required this.libre,required this.id});

  factory Consulta.fromJson(Map<String,dynamic> json) => 
  Consulta(
    medico: Medico.fromJson(json['medico']), 
    libre: json['libre'],
    paciente: (json['paciente']==null?null:Paciente.fromJson(json['paciente'])),
    id: json['id']);
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