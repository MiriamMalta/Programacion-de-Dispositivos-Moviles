part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent extends Equatable{
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class FavoritesEventAddTo extends FavoritesEvent {}

class FavoritesEventAddFrom extends FavoritesEvent {
  final String title;
  final String artist;
  final String release_date;
  final String apple;
  final String spotify;
  final String album;
  final String image;
  final String song_link;

  FavoritesEventAddFrom(this.title, this.artist, this.release_date, this.apple, this.spotify, this.album, this.image, this.song_link);

  @override
  List<Object?> get props => [title, artist, release_date, apple, spotify, album, image, song_link];
}

class FavoritesDeleteFrom extends FavoritesEvent {
  final String title;
  final String artist;
  final String release_date;
  final String apple;
  final String spotify;
  final String album;
  final String image;
  final String song_link;

  FavoritesDeleteFrom(this.title, this.artist, this.release_date, this.apple, this.spotify, this.album, this.image, this.song_link);

  @override
  List<Object?> get props => [title, artist, release_date, apple, spotify, album, image, song_link];
}
