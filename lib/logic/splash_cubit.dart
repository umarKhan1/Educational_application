import 'package:flutter_bloc/flutter_bloc.dart';



class SplashCubit extends Cubit<bool> {
  SplashCubit() : super(false);

  Future<void> initializeApp() async {
    // ignore: inference_failure_on_instance_creation
    await Future.delayed(const Duration(seconds: 3));
    
    // Emit true when initialization is complete
    emit(true);
  }
}
class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);

  void changePage(int index) {
    emit(index); // Update the current index
  }
}
