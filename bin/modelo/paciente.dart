class Paciente{
  late int numHistoria;
  late String dni;
  late String nombre;
  late String apellidos;
  late String sintomas;

  Paciente(this.numHistoria,this.dni,this.nombre,this.apellidos,this.sintomas);

  Paciente.noPaciente(){
    numHistoria = 0;
    dni='0';
    nombre='No';
    apellidos='hay paciente';
    sintomas='Sin sintomas';
  }

  @override
  String toString() {
    return '''
    ****** Datos del paciente ******
    Nombre del paciente: $nombre $apellidos
    Historia del paciente: $numHistoria
    Sintomas del paciente: $sintomas
''';
  }
}