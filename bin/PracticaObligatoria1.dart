import 'dart:convert';

import 'package:http/http.dart';

import 'modelo/consulta.dart';
import 'modelo/paciente.dart';
import 'controller/controller.dart';
import 'providers/consulta_provider.dart';
void main(List<String> args)async {
  
 print(await Consulta_provider().getConsultas());

//   post(Uri.parse('https://consulta-3682d-default-rtdb.europe-west1.firebasedatabase.app/consulta/pacientes.json')
//   ,body: jsonEncode({
//     "nonbmre": "fernando",
//     "numhistoria": 2745,
//     "sintomas": "caca",
//     "apellidos": "diaz",
//     "dni":"36259748A",
//     "pos":0
// }));
}