import 'package:equatable/equatable.dart';

class LanguagesState extends Equatable {
  final String? selectedLanguage;

  LanguagesState({this.selectedLanguage});

  @override
  // TODO: implement props
  List<Object?> get props => [
    selectedLanguage
  ];
}