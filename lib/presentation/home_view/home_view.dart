import 'package:flutter/material.dart';
import 'package:test/presentation/home_view/widget/search_widget.dart';
import 'package:test/presentation/home_view/widget/vertical_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [SearchWidget(), SizedBox(height: 10), HomeVerticalList()],
        ),
      ),
    );
  }
}
