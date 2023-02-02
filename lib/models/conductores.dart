class Conductores {

    String nombres;
    String celular;
    String placa;
    String tiempoDeLlegada;
    String cedula;

    Conductores({
        required this.nombres,
        required this.celular,
        required this.placa,
        required this.tiempoDeLlegada,
        required this.cedula,
    });

    

    factory Conductores.fromJson(Map json) {
      return Conductores(
        nombres: json["nombres"],
        celular: json["celular"],
        placa: json["placa"],
        tiempoDeLlegada: json["tiempo_de_llegada"],
        cedula: json["cedula"],
      );

    }

}
