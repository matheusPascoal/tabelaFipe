class CarsModel {
  String? valor;
  String? marca;
  String? modelo;
  int? anoModelo;
  String? combustivel;
  String? codigoFipe;
  String? mesReferencia;
  int? tipoVeiculo;
  String? siglaCombustivel;

  CarsModel(
      {this.valor,
      this.marca,
      this.modelo,
      this.anoModelo,
      this.combustivel,
      this.codigoFipe,
      this.mesReferencia,
      this.tipoVeiculo,
      this.siglaCombustivel});

  CarsModel.fromJson(Map<String, dynamic> json) {
    valor = json['Valor'];
    marca = json['Marca'];
    modelo = json['Modelo'];
    anoModelo = json['AnoModelo'];
    combustivel = json['Combustivel'];
    codigoFipe = json['CodigoFipe'];
    mesReferencia = json['MesReferencia'];
    tipoVeiculo = json['TipoVeiculo'];
    siglaCombustivel = json['SiglaCombustivel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Valor'] = this.valor;
    data['Marca'] = this.marca;
    data['Modelo'] = this.modelo;
    data['AnoModelo'] = this.anoModelo;
    data['Combustivel'] = this.combustivel;
    data['CodigoFipe'] = this.codigoFipe;
    data['MesReferencia'] = this.mesReferencia;
    data['TipoVeiculo'] = this.tipoVeiculo;
    data['SiglaCombustivel'] = this.siglaCombustivel;
    return data;
  }
}
