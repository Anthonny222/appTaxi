class Conductores {

    String nombres;
    String celular;
    String placa;
    String tiempo;
    String cedula;

    Conductores({
        required this.nombres,
        required this.celular,
        required this.placa,
        required this.tiempo,
        required this.cedula,
    });

    

    factory Conductores.fromJson(Map json) {
      return Conductores(
        nombres: json["nombres"],
        celular: json["celular"],
        placa: json["placa"],
        tiempo: json["tiempo"],
        cedula: json["cedula"],
      );

    }
    Map<String, dynamic> toJson() => {
      "nombres": nombres,
      "celular": celular,
      "placa": placa,
      "tiempo": tiempo,
      "cedula": cedula,
    };

    



}
