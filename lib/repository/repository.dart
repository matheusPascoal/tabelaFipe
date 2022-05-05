import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tabela_fipe/model/api_imagem.dart';
import 'package:tabela_fipe/model/brand_model.dart';
import 'package:tabela_fipe/model/cars_model.dart';
import 'package:tabela_fipe/service/constant.dart';

class FipeRepository {
  var dio = Dio();
  Future<List<BrandModel>> getBrand() async {
    var result = await Dio().get(apiUrl + 'carros/marcas');
    if (result.statusCode == 200) {
      return result.data
          .map<BrandModel>((e) => BrandModel.fromJson(e))
          .toList();
    }
    return <BrandModel>[];
  }

  Future<List<BrandModel>> getModelCar(String codeBrand) async {
    var result = await Dio().get(apiUrl + 'carros/marcas/$codeBrand/modelos');
    if (result.statusCode == 200) {
      return result.data['modelos']
          .map<BrandModel>((e) => BrandModel.fromJson(e))
          .toList();
    }
    return <BrandModel>[];
  }

//  carros/marcas/$codigo/modelos/$age/anos
  Future<List<BrandModel>> getYears(
      String codeModelCar, String codeBrand) async {
    var result = await Dio()
        .get(apiUrl + 'carros/marcas/$codeBrand/modelos/$codeModelCar/anos');
    if (result.statusCode == 200) {
      return result.data
          .map<BrandModel>((e) => BrandModel.fromJson(e))
          .toList();
    }
    return <BrandModel>[];
  }

  Future<CarsModel> getCar(
      codeModelCar, String codeBrand, String codeYear) async {
    var result = await Dio().get(apiUrl +
        'carros/marcas/$codeBrand/modelos/$codeModelCar/anos/$codeYear');
    if (result.statusCode == 200) {
      return CarsModel.fromJson(result.data);
    }
    return CarsModel();
  }

  Future<ApiImage> getImage(
      String nameBrand, String nameModelCar, String nameYear) async {
    try {
      var result = await Dio().get(
          "https://tabela-fipe-flipggs.vercel.app/api/image?q=$nameBrand $nameModelCar $nameYear");
      if (result.statusCode == 200) {
        return ApiImage.fromJson(result.data);
      }
    } on Exception catch (error) {
      print(error);
    }

    return ApiImage();
  }
}
