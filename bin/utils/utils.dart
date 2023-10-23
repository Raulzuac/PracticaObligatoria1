import 'dart:async';
import 'dart:io';

class Utils {
  static Future<void> mensajeDeEspera(String mensaje) async {
    stdout.write(mensaje);
    for (var i = 0; i < 3; i++) {
      await Future.delayed(Duration(milliseconds: 500));
      stdout.write(".");
    }
    stdout.write("\n\n");
  }

  static void pulseEnterContinuar() {
    stdout.writeln("Pulse enter para continuar...");
    stdin.readLineSync();
  }

  static introduceString(String mensaje){
  String cadena="";
  do {
    stdout.write(mensaje!=""?mensaje:'Inserta una cadena: ');
    cadena= stdin.readLineSync()??'';
    final List<String> caracteresEspeciales = ['"','{','}','.', '\$', '[', ']', '#', '/', '*', '|', '\\', '%', '^', '`', '@'];
    for (var element in caracteresEspeciales) {
      cadena=cadena.replaceAll(element, "");
    }
    if(cadena.isEmpty)print('La cadena no puede estar vacía.');
  } while (cadena.isEmpty);
  return cadena;
}
}
