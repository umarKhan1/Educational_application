import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);
 final PageController controller = PageController();
  void goToPage(int idx) {
    emit(idx);
    controller.animateToPage(
      idx,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
 void pageChanged(int idx) {
    emit(idx);
  }
  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
