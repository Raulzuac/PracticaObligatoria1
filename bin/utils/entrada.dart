import 'dart:io';
String introduceString(String mensaje){
  String cadena="";
  do {
    print(mensaje!=""?mensaje:'Inserta una cadena:');
    cadena= stdin.readLineSync()??'';
    // final List<String> caracteresEspeciales = ['"','{','}','.', '\$', '[', ']', '#', '/', '*', '|', '\\', '%', '^', '`', '@'];
    // for (var element in caracteresEspeciales) {
    //   cadena=cadena.replaceAll(element, "");
    // }
    if(cadena.isEmpty)print('La cadena no puede estar vacía');
  } while (cadena.isEmpty);
  return cadena;
}
// int pideEntero(String mensaje){
//   print(mensaje!=""?mensaje:'Inserta un número:');
//   int numero;
//   bool esNumero=true;
//   do{
//     try{
//       numero=int.parse(stdin.readLineSync()??"");
//     }ca
//   }while(!esNumero);
// }