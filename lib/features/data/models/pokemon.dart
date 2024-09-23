import 'package:flutter_pokedex/features/domain/utils/capitalize_first_letter.dart';

import '../enums/poke_types.dart';
import '../../domain/entities/pokemon.dart';

class PokemonModel extends PokemonEntity {
  const PokemonModel({
    required int id,
    required String name,
    required int height,
    required int weight,
    required List<PokeType> types,
    required List<Map<String, int>> stats,
    required List<String> moves,
  }) : super(
          id: id,
          name: name,
          height: height,
          weight: weight,
          types: types,
          stats: stats,
          moves: moves,
        );

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
      );

  factory PokemonModel.fromEntity(PokemonEntity entity) => PokemonModel(
        id: entity.id,
        name: entity.name,
        height: entity.height,
        weight: entity.weight,
        types: entity.types,
        stats: entity.stats,
        moves: entity.moves,
      );

  @override
  String toString() {
    return 'PokemonModel{id: $id, moves: $moves, height: $height, name: $name, types: $types, weight: $weight, stats: $stats}';
  }
}
