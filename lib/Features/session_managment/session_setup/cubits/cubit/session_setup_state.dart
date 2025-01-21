part of 'session_setup_cubit.dart';

enum SessionMode { program, auto }

class SessionSetupState extends Equatable {
  final SessionMode? currentSessionMode;

  const SessionSetupState({this.currentSessionMode = SessionMode.program});

  @override
  List<Object> get props => [currentSessionMode!];
}
