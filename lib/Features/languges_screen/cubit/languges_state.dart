import 'package:equatable/equatable.dart';

class LanguagesState extends Equatable {
  final String? selectedLanguage;

  const LanguagesState({this.selectedLanguage});

  @override
  List<Object?> get props => [selectedLanguage];
}
