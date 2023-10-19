import 'dart:math';

import '../modelo/consulta.dart';
import '../modelo/medico.dart';
import '../modelo/paciente.dart';
import '../providers/consulta_provider.dart';
Future<Controller> nuevoController() async{
  return Controller(await ConsultaProvider().getConsultas(),
  await ConsultaProvider().getPacientes(),
  await ConsultaProvider().getPacientesCurados());
}

class Controller {
  late List<Consulta> consultas;
  late List<Paciente> pacientesCola;
  late List<Paciente> pacientesCurados;

  Controller(this.consultas,this.pacientesCola,this.pacientesCurados);

  

  Future<int> insertaPaciente(String dni,String nombre,String apellidos,String sintomas) async{
    Paciente p = Paciente("", generaNumHistoria(), dni, nombre, apellidos, sintomas, DateTime.now().toString());
    //mira si hay consultas vacías
    if(consultasLibres()!=0){
      Consulta c = firstConsultaLibre();
      ConsultaProvider().insertaPacienteConsulta(c, p);
      return c.id;
    }else{
    //sino
    String id=await ConsultaProvider().insertaPacienteCola(p);
    p.id = id;
    return -1;
    }
  }

  void saleConsulta(Consulta c) {
    //sino
    //eliminamos el paciente de la consulta

    if (pacientesCola.isEmpty) {
      c.paciente = null;
      ConsultaProvider().limpiaConsulta(c);
      c.libre=true;
    } else {
      pacientesCola.sort(
          (paciente1, paciente2) => paciente1.fecha.compareTo(paciente2.fecha));
      Paciente p = pacientesCola.removeAt(0);
      c.paciente = p;
      ConsultaProvider().insertaPacienteConsulta(c, p);
      ConsultaProvider().eliminaPaciente(p);
    }

    //si hay alguien en cola
    //guardar el primero de la cola

    //sustituir el de la consulta
  }
  int generaNumHistoria(){
    bool correcto=false;
    int id=-1;
    while(!correcto){
      id= Random().nextInt(10000);
    if(pacientesCola.any((paciente)=>paciente.numHistoria!=id) &&
     consultas.any((consulta) => (consulta.paciente!=null && consulta.paciente!.numHistoria!=id))){
        correcto=true;
    }
    
    }
    return id;
  }

  List<Paciente> getCola() {
    return pacientesCola;
  }

  List<Consulta> getConsulta() {
    return consultas;
  }
  int consultasLibres(){
    int resultado= 0;
    consultas.forEach((consulta)=>{if(consulta.libre)resultado++});
    return resultado;
  }
  Consulta firstConsultaLibre()=> consultas.firstWhere((consulta) => consulta.libre);
  
}
