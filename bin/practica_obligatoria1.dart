import 'dart:io';

import 'controller/controller.dart';
import 'modelo/consulta.dart';
import 'modelo/medico.dart';
import 'modelo/paciente.dart';
import 'providers/consulta_provider.dart';
import 'utils/entrada.dart';

void main(List<String> args) async {
  String opt = "";
  Controller c = await nuevoController();
  do {
    // mensaje de dial
    print('''\n
            Bienvenido al centro de salud de Martos
      ========================================================
      El numero actual de medicos pasando consulta es : 3
      Consultas libres: ${c.consultasLibres()}
      Actualmente, tenemos ${c.pacientesCola.length} en cola
      Hoy hemos curado a ${c.pacientesCurados.length} pacientes
      ========================================================
      Introduzca una opcion:
      
      1.- Admision de un paciente
      2.-Liberar una consulta
      3.-Ver la cola de espera
      4.-Ver el estado actual de las consultas
      5.-Salir

      Pulse la Opcion:
    ''');
    opt = stdin.readLineSync() ?? '';
    switch (opt) {
      case "1":
        {
          admitirPaciente(c);
          break;
        }
      case "2":
        {
          break;
        }
      case "3":
        {
          break;
        }
      case "4":
        {
          break;
        }
      default:
        {
          print('Introduce una opción válida');
          break;
        }
    }
  } while (opt == "5");
}

void admitirPaciente(Controller c) async {
  String dni = introduceString('Inserta el dni: ');
  String nombre = introduceString('Inserta el nombre: ');
  String apellidos = introduceString('Inserta los apellidos: ');
  String sintomas = introduceString('Inserta los sintomas: ');
  int i = await c.insertaPaciente(dni, nombre, apellidos, sintomas);
  print(i == -1
      ? 'No hay ninguna consulta libre, deberá esperar su turno, su posición en la cola es ${c.pacientesCola.length}'
      : 'Se le ha asignado la consulta $i ya puede pasar.Le atenderá ${c.consultas[i].medico.nombre}');
}
