import 'medico.dart';
import 'paciente.dart';

class Consulta{
  bool libre;
  Medico medico;
  Paciente? paciente;

  Consulta({required this.medico,this.paciente,required this.libre});

  factory Consulta.fromJson(Map<String,dynamic> json) => 
  Consulta(
    medico: Medico.fromJson(json['medico']), 
    libre: json['libre'],
    paciente: (json['paciente']==null?null:Paciente.fromJson(json['paciente'])));
 
  @override
  String toString() {
   if(paciente!=null){
     return '''
    ***** Consulta: ************
    Nombre del médico: ${medico.nobmre}
    Especialidad: ${medico.especialidad}
    Paciente: ${paciente!.nombre} ${paciente!.apellidos}
    Numero historia: ${paciente!.numHistoria}
''';
   }
   return '''
    ***** Consulta: ************
    Nombre del médico: ${medico.nobmre}
    Especialidad: ${medico.especialidad}
''';
  }
}