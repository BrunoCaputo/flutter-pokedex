import 'package:mobx/mobx.dart';

part 'platform_store.g.dart';

class PlatformStore = _PlatformStore with _$PlatformStore;

abstract class _PlatformStore with Store {
  @observable
  bool isFetchingPokemons = false;

  @action
  void setIsFetchingPokemons(bool isFetching) => isFetchingPokemons = isFetching;
}
