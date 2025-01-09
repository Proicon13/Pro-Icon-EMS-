import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/Features/Settings/Screens/settings_view.dart';
import 'package:pro_icon/Features/home/screens/home_view.dart';
import 'package:pro_icon/Features/users/screens/users_screen.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  void onInit(MainSections section) {
    changeSection(section);
  }

  void changeSection(MainSections section) {
    emit(state.copyWith(currentSection: section));
  }
}
