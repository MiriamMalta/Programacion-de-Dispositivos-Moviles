part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesState extends Equatable{
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesErrorState extends FavoritesState {
  final String error;

  FavoritesErrorState({required this.error});
}

class FavoritesPutState extends FavoritesState {
  final List<dynamic> favorites;

  FavoritesPutState({required this.favorites});

  @override
  List<Object?> get props => [favorites];
}

class FavoritesHeartState extends FavoritesState {
  final String heart;

  FavoritesHeartState({required this.heart});
}