import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/logic/book_cubit/book_cubit.dart';
import 'package:test/logic/book_cubit/book_state.dart';

class HomeVerticalList extends StatelessWidget {
  const HomeVerticalList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<BookSearchCubit, BookSearchState>(
        builder: (context, state) {
          final suggestions = state.query.isEmpty
              ? context.read<BookSearchCubit>().allBooks
              : state.suggestions;
          if (suggestions.isEmpty && state.query.isNotEmpty) {
            return const Center(
              child: Text(
                'No Books Founds',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final book = suggestions[index];
              return Card(
                child: ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  onTap: () {
                    FocusScope.of(context).unfocus(); // hide keyboard
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(book.description)));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
