import 'package:equatable/equatable.dart';

import '../../data/enums/poke_types.dart';

class PokemonEntity extends Equatable {
  final int id;
  final List<String> moves;
  final int height;
  final String name;
  final List<PokeType> types;
  final int weight;
  final List<Map<String, int>> stats;

  const PokemonEntity({
    required this.id,
    this.moves = const [],
    required this.height,
    required this.name,
    required this.types,
    required this.weight,
    required this.stats,
  });

  @override
  List<Object?> get props => [id, moves, height, name, types, weight, stats];

  @override
  String toString() {
    return 'PokemonEntity{id: $id, moves: $moves, height: $height, name: $name, types: $types, weight: $weight, stats: $stats}';
  }
}
