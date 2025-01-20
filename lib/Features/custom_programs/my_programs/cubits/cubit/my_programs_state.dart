part of 'my_programs_cubit.dart';

enum MyProgramsStatus { initial, loading, success, error }

class MyProgramsState extends Equatable {
  final MyProgramsStatus? deleteRequestStatus;
  final String? message;
  const MyProgramsState(
      {this.deleteRequestStatus = MyProgramsStatus.initial, this.message = ""});

  MyProgramsState copyWith({
    MyProgramsStatus? deleteRequestStatus,
    String? message,
  }) {
    return MyProgramsState(
      deleteRequestStatus: deleteRequestStatus ?? this.deleteRequestStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [deleteRequestStatus!, message!];
}

final class MyProgramsInitial extends MyProgramsState {}
