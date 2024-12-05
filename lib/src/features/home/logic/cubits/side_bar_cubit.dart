import 'package:flutter_bloc/flutter_bloc.dart';

class SideBarCubit extends Cubit<bool> {
  SideBarCubit() : super(true);

  void showSideBar() {
    emit(true);
  }

  void hideSideBar() {
    emit(false);
  }
}
