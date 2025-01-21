part of 'auto_sessions_cubit.dart';

enum AutoSession { main, custom }

class AutoSessionsState extends Equatable {
  final AutoSession? currentSessionSection;

  const AutoSessionsState({
    this.currentSessionSection = AutoSession.main,
  });

  AutoSessionsState copyWith({
    AutoSession? currentSessionSection,
    Bool? canChangeSection,
  }) {
    return AutoSessionsState(
      currentSessionSection:
          currentSessionSection ?? this.currentSessionSection,
    );
  }

  @override
  List<Object> get props => [
        currentSessionSection!,
      ];
}
