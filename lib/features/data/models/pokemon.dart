import '../enums/poke_types.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/utils/capitalize_first_letter.dart';

class PokemonModel extends PokemonEntity {
  const PokemonModel({
    required super.id,
    required super.name,
    required super.height,
    required super.weight,
    required super.types,
    required super.stats,
    required super.moves,
    required super.cry,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> map) => PokemonModel(
        id: map['id'],
        name: map['name'],
        height: map['height'],
        weight: map['weight'],
        types: List.from(map['types'])
            .map((type) => type['type']['name'])
            .map(
              (type) => PokeType.getPokeTypeByName(type),
            )
            .toList(),
        stats: List.from(map['stats'])
            .map((stat) => {stat['stat']['name'].toString(): (stat['base_stat']) as int})
            .toList(),
        moves: List.from(map['abilities'])
            .map(
              (move) => capitalizeFirstLetter(
                move['ability']['name'].toString(),
              ),
            )
            .toList(),
        cry: map['cries']['latest'],
      );

  factory PokemonModel.fromEntity(PokemonEntity entity) => PokemonModel(
        id: entity.id,
        name: entity.name,
        height: entity.height,
        weight: entity.weight,
        types: entity.types,
        stats: entity.stats,
        moves: entity.moves,
        cry: entity.cry,
      );

  @override
  String toString() {
    return 'PokemonModel{id: $id, moves: $moves, height: $height, name: $name, types: $types, weight: $weight, stats: $stats, cry: $cry}';
  }
}
