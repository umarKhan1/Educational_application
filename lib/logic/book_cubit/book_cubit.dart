import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/logic/book_cubit/book_state.dart';
import 'package:test/model/book_model.dart';

class BookSearchCubit extends Cubit<BookSearchState> {

  BookSearchCubit(this.allBooks)
      : super(BookSearchState(query: '', suggestions: allBooks));
  final List<BookModel> allBooks;

  void updateQuery(String query) {
    final filtered = allBooks
        .where((book) => book.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(BookSearchState(query: query, suggestions: filtered));
  }
}
