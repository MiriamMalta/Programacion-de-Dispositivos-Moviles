part of 'song_bloc.dart';

@immutable
abstract class SongEvent extends Equatable{
  const SongEvent();

  @override
  List<Object?> get props => [];
}

class SongEventHear extends SongEvent {}
