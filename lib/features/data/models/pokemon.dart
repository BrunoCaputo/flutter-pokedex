import '../enums/poke_types.dart';
import '../../domain/entities/pokemon.dart';

class PokemonModel extends PokemonEntity {
  const PokemonModel({
    required int id,
    required String name,
    required double height,
    required double weight,
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
        types: map['types'],
        stats: map['stats'],
        moves: map['moves'],
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
}
