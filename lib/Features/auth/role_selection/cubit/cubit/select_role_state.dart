part of 'select_role_cubit.dart';

@immutable
class SelectRoleState extends Equatable {
  final Role? role;
  const SelectRoleState({this.role});

  SelectRoleState copyWith({Role? role}) =>
      SelectRoleState(role: role ?? this.role);

  @override
  List<Object?> get props => [role];
}
