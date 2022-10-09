import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:books/api/repository.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final ht = APIRepository();

  BookBloc() : super(BookInitial()) {
    on<BookEventSearch>(_searchBook);
  }

  FutureOr<void> _searchBook(BookEventSearch event, Emitter<BookState> emit) async {
    try {
      emit(BookLoadingState());
      List<dynamic> booksList = [];
      try {
        var books = await ht.getBooks(event.request);
        if (books is String) {
          emit(BookErrorState(error: books));
        } else {
          for (var book in books) {
            var _image;
            try {
              _image = book['volumeInfo']['imageLinks']['thumbnail'];
            } catch (e) {
              _image = "https://static.cambridge.org/content/id/urn%3Acambridge.org%3Aid%3Aarticle%3AS026138750000739X/resource/name/firstPage-S026138750000739Xa.jpg";
            }
            Map<String, dynamic> bookMap = {
              "image": _image,
              "title": book["volumeInfo"]["title"],
              "publishedDate": book["volumeInfo"]["publishedDate"],
              "description": book["volumeInfo"]["description"] ?? " – ",
              "pageCount": book["volumeInfo"]["pageCount"],
            };
            //print(bookMap);
            booksList.add(bookMap);
          }
        }
      } catch (e) {
        emit(BookErrorState(error: e.toString()));
      }
      print(booksList);
      emit(BookLoadedState(books: booksList));
    } catch (e) {
      emit(BookErrorState(error: e.toString()));
    }
  }
}
