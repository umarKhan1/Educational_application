import 'package:test/model/book_model.dart';
class BookSearchState {
  BookSearchState({required this.query, required this.suggestions});
  final String query;
  final List<BookModel> suggestions;
}
