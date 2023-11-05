import 'package:bloc/bloc.dart';

class PageViewCubit extends Cubit<int> {
  PageViewCubit() : super(0);
  int pageIndex = 0;
  void nextCategoryPage() {
    pageIndex++;
    emit(pageIndex);
  }

  void backToStartPage() {
    pageIndex = 0;
    emit(pageIndex);
  }

  void popCategoryPage() {
    pageIndex--;
    emit(pageIndex);
  }
}
