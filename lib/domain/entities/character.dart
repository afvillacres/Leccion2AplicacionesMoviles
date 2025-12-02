import 'base_entity.dart';

class CharacterEntity extends BaseEntity{
  final String id;
  final String name;
  final String origin;
  final String temperament;
  final String image;

  CharacterEntity({
    required this.id,
    required this.name,
    required this.origin,
    required this.temperament,
    required this.image,
  });

}