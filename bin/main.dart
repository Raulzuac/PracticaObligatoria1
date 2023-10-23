import 'dart:io';

import 'controller/controller.dart';
import 'utils/menu.dart';
import 'utils/utils.dart';

void main(List<String> args) async {
  String opt = "";
  Controller c = await nuevoController();
  do {
    //Menu de la app
    print(Menus.menuPrincipal(c.consultasLibres(), c.pacientesCola.length,
        c.pacientesCurados.length));
    stdout.write('Introduce una opción: ');
    opt = stdin.readLineSync() ?? '';
    switch (opt) {
      case "1":
        await admitirPaciente(c);
        break;
      case "2":
        await liberarConsulta(c);
        break;
      case "3":
        verLaColaEspera(c);
        break;
      case "4":
        verEstadoActualConsultas(c);
        break;
      case "5":
        Utils.mensajeDeEspera('Cerrando sesión');
        break;

      default:
        stdout.write('Introduce una opción válida: ');
    }
  } while (opt != "5");
}

void verEstadoActualConsultas(Controller c) {
  print('Los datos de las consultas son: ');
  for (var consulta in c.consultas) {
    print(consulta);
  }
  Utils.pulseEnterContinuar();
}

void verLaColaEspera(Controller c) {
  if (c.getCola().isEmpty) {
    print('Actualmente no hay pacientes en cola.');
  } else {
    print('');
    print('');
    print('Actualmente hay ${c.getCola().length} pacientes en cola. Son:');
    print('');
    for (var i = 0; i < c.getCola().length; i++) {
      print(c.getCola()[i].pintaPacienteCola(i + 1));
    }
  }
  Utils.pulseEnterContinuar();
}

Future<void> liberarConsulta(Controller c) async {
  stdout.write('Introduce el id de la consulta a liberar: ');
  String id = stdin.readLineSync() ?? '';
  if (id != '1' && id != '2' && id != '3' && id != '4') {
    print('Esa consulta no existe, intentalo de nuevo.');
  } else {
    await Utils.mensajeDeEspera('Espere un momento');
    if (await c.saleConsulta(int.parse(id))) {
      print('Se ha liberado la consulta $id');
    }else{
      print('La consulta $id ya estaba liberada.');
    }
  }
  Utils.pulseEnterContinuar();
}

Future<void> admitirPaciente(Controller c) async {
  String dni = Utils.introduceString('Inserta el dni: ');
  String nombre = Utils.introduceString('Inserta el nombre: ');
  String apellidos = Utils.introduceString('Inserta los apellidos: ');
  String sintomas = Utils.introduceString('Inserta los sintomas: ');
  int i = await (c.insertaPaciente(dni, nombre, apellidos, sintomas));

  await Utils.mensajeDeEspera('Espere un momento');
  print('');
  print(i == -1
      ? 'No hay ninguna consulta libre, deberá esperar su turno, su posición en la cola es ${c.pacientesCola.length}.'
      : 'Se le ha asignado la consulta $i ya puede pasar.Le atenderá ${c.consultas[i - 1].medico.nombre}.');
  Utils.pulseEnterContinuar();
}
