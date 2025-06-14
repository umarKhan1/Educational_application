class BookModel {
  BookModel({
    required this.title,
    required this.author,
    required this.description,
  });
  final String title;
  final String author;
  final String description;

  static  List<BookModel> books = [
    BookModel(
      title: 'Clean Code',
      author: 'Robert C. Martin',
      description: 'A book about writing cleaner code.',
    ),
    BookModel(
      title: 'Flutter in Action',
      author: 'Eric Windmill',
      description: 'A guide to Flutter framework.',
    ),
    BookModel(
      title: 'The Pragmatic Programmer',
      author: 'Andrew Hunt',
      description: 'Classic book on programming philosophy.',
    ),
  ];
}
