import 'package:bloc/bloc.dart';

import 'languges_state.dart';

class LanguageCubit extends Cubit<LanguagesState> {
  LanguageCubit() : super(const LanguagesState());

  void selectLanguage(String language) {
    emit(LanguagesState(selectedLanguage: language));
  }
}
