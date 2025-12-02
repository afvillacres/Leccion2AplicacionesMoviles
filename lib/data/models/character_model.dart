import '../../domain/entities/character.dart';

class CharacterModel extends CharacterEntity {

  CharacterModel({
    required String id,
    required String name,
    required String origin,
    required String temperament,
    required String image,
  }): super(
    id: id,
    name: name,
    origin: origin,
    temperament: temperament,
    image: image,
  );

  factory CharacterModel.fromJson(Map<String, dynamic> json){
    // Extraer imagen con mejor validación
    String imageUrl = "";
    
    if(json.containsKey("image") && json["image"] != null){
      final image = json["image"];
      if(image is Map && image.containsKey("url")){
        imageUrl = image["url"] ?? "";
      }
    }


    return CharacterModel(
      id: json["id"]?.toString() ?? "0",
      name: json["name"] ?? "Raza desconocida",
      origin: json["origin"] ?? "Desconocido",
      temperament: json["temperament"] ?? "No especificado",
      image: imageUrl,
    );
  }
}