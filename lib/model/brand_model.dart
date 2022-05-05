class BrandModel {
  String? nome;
  String? codigo;

  BrandModel({this.nome, this.codigo});

  BrandModel.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    codigo = json['codigo'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['codigo'] = this.codigo;
    return data;
  }
}
