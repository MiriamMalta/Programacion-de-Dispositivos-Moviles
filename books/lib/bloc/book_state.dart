part of 'book_bloc.dart';

@immutable
abstract class BookState {
  const BookState();

  @override
  List<Object?> get props => [];
}

class BookInitial extends BookState {}

class BookLoadingState extends BookState {
}

class BookLoadedState extends BookState {
  final List<dynamic> books;

  BookLoadedState({required this.books});

  @override
  List<Object?> get props => books;
}

class BookErrorState extends BookState {
  final String error;

  BookErrorState({required this.error});
}


