import 'medico.dart';
import 'paciente.dart';

class Consulta{
  int id;
  Medico medico;
  Paciente? paciente;

  Consulta({required this.medico,required this.paciente,required this.id});

  @override
  String toString() {
    return '''
    ***** Consulta: $id ************
    Nombre del médico: ${medico.nobmre}
    Especialidad: ${medico.especialidad}
    Paciente: ${paciente!.nombre} ${paciente!.apellidos}
    Numero historia: ${paciente!.numHistoria}
''';
  }
}