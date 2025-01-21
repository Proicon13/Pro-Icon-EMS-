import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auto_sessions_state.dart';

class AutoSessionsCubit extends Cubit<AutoSessionsState> {
  AutoSessionsCubit() : super(const AutoSessionsState());

  void changeSessionSection(AutoSession session) {
    emit(state.copyWith(currentSessionSection: session));
  }

  // void changeCanChangeSection(Bool canChange) {
  //   emit(state.copyWith(canChangeSection: canChange));
  // }
}
