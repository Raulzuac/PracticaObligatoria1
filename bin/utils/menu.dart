import 'package:intl/intl.dart';
//Utilidades para los menús
class Menus {
  ///Gestiona el menú principal
  static String menuPrincipal(
      int consultasLibres, int pacientesCola, int pacientesCurados) {
    String fecha = DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now());
    String mensajeConsultas = pacientesCola == 0
        ? _alignLeft('no hay consultas libres', 23)
        : _alignLeft('hay $consultasLibres consultas libres', 23);
    return '''
                                                             ╔═════════════════╗
                            ╔════════════════════════════════╣ Centro de Salud ╠════════════════════════════════╗
                            ║░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░╚═════════════════╝░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░║ 
                            ║  Bienvenido al sistema de gestión del centro de salud                             ║ 
                            ║  Actualmente $mensajeConsultas                                              ║ 
                            ║  Los pacientes en cola son: ${_alignLeft(pacientesCola.toString(), 4)}                                                  ║ 
                            ║  Los pacientes curados son: ${_alignLeft(pacientesCurados.toString(), 4)}                                                  ║ 
                            ╠═══════════════════════════════════════════════════════════════════════════════════╣
                            ║ -------------------------------------------------------------------------------   ║
                            ║   La fecha actual es: $fecha                                         ║
                            ║ -------------------------------------------------------------------------------   ║
                            ╠═══════════════════════════════════════════════════════════════════════════════════╣
                            ║  -------------------------------------------------------------------------------  ║  
                            ║  [1] Admision de un paciente                                                      ║
                            ║  -------------------------------------------------------------------------------  ║  
                            ║  [2] Liberar una consulta                                                         ║
                            ║  -------------------------------------------------------------------------------  ║ 
                            ║  [3] Ver la cola de espera                                                        ║
                            ║  -------------------------------------------------------------------------------  ║ 
                            ║  [4] Ver el estado actual de las consultas                                        ║
                            ║  -------------------------------------------------------------------------------  ║ 
                            ║  [5] Salir                                                                        ║
                            ║  -------------------------------------------------------------------------------  ║ 
                            ╚═══════════════════════════════════════════════════════════════════════════════════╝
''';
  }

  ///establecer formato para printear
  static String _alignLeft(String text, int espacios) {
    if (text.length >= espacios) {
      return text; // La cadena ya es lo suficientemente larga.
    } else {
      return text.padRight(espacios);
    }
  }
}
