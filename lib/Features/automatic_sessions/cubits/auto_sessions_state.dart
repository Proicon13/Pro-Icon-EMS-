part of 'auto_sessions_cubit.dart';

enum AutoSession { main, custom }

class AutoSessionsState extends Equatable {
  final AutoSession? currentSessionSection;
  final Bool? canChangeSection;
  const AutoSessionsState({this.currentSessionSection, this.canChangeSection});

  AutoSessionsState copyWith({
    AutoSession? currentSessionSection,
    Bool? canChangeSection,
  }) {
    return AutoSessionsState(
      currentSessionSection:
          currentSessionSection ?? this.currentSessionSection,
      canChangeSection: canChangeSection ?? this.canChangeSection,
    );
  }

  @override
  List<Object> get props => [
        currentSessionSection!,
        canChangeSection!,
      ];
}
