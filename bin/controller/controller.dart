
import '../modelo/consulta.dart';
import '../modelo/medico.dart';
import '../modelo/paciente.dart';
import '../providers/consulta_provider.dart';

class Controller {
  
  List<Consulta> consultas;
  List<Paciente> pacientes;

  Controller(this.consultas,this.pacientes);
  

}
