import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  void nextPage() => emit(state + 1);
  void previousPage() => emit(state - 1);
  void skipToEnd() => emit(2); 
  void goToPage(int index) => emit(index);
}
