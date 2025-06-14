import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/logic/book_cubit/book_cubit.dart';
import 'package:test/logic/book_cubit/book_state.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: BlocBuilder<BookSearchCubit, BookSearchState>(
        builder: (context, state) {
          return TextField(
            onChanged: (query) =>
                context.read<BookSearchCubit>().updateQuery(query),
            decoration: InputDecoration(
              hintText: 'Search books...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          );
        },
      ),
    );
  }
}
