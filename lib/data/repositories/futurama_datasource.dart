import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';
import '../datasources/base_datasource.dart';

class FuturamaDataSource extends BaseDataSource<CharacterModel> {
  final String URL = "https://api.thecatapi.com/v1/breeds";

  //Hacer un GET
  Future<List<CharacterModel>> fetchData() async{
    final uri = Uri.parse(URL);
    final resp = await http.get(uri);
    //Hacer una Validación
    if(resp.statusCode != 200){
      throw Exception("Error de conexión API");
    }

    //Decodificar un JSON (jsonDecode)
    final List data = jsonDecode(resp.body);

    //Resultados (lista)
    return data.map((json) => CharacterModel.fromJson(json)).toList();
  }
}