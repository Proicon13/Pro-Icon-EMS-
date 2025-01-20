import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'languges_state.dart';



class LanguageCubit extends Cubit<LanguagesState> {
  LanguageCubit() : super(LanguagesState());

  void selectLanguage(String language) {
    emit(LanguagesState(selectedLanguage: language));
  }
}