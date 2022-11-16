part of 'song_bloc.dart';

@immutable
abstract class SongState extends Equatable{
  const SongState();

  @override
  List<Object?> get props => [];
}

class SongInitial extends SongState {}

class SongLoadingState extends SongState {
  final String message;

  SongLoadingState({required this.message});
}

class SongSearchingState extends SongState {
  final String message;

  SongSearchingState({required this.message});
}

class SongLoadedState extends SongState {
  final Map<String, dynamic> musicInfo;

  SongLoadedState({required this.musicInfo});

  @override
  List<Object?> get props => [musicInfo];
}

class SongErrorState extends SongState {
  final String error;

  SongErrorState({required this.error});
}

class SongHearSuccessState extends SongState {}
