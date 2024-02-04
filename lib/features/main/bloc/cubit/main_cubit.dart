import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  int currentPageIndex = 0;

  MainCubit() : super(MainInitial());

  void changePageIndexTo(int newPageIndex) {
    currentPageIndex = newPageIndex;
    emit(MainPageChanged());
  }
}
