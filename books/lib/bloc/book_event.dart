part of 'book_bloc.dart';

@immutable
abstract class BookEvent {
  const BookEvent();

  @override
  String get props => "";
}

class BookEventSearch extends BookEvent {
  final String request;

  BookEventSearch({required this.request});

  @override
  String get props => "$request";
}

