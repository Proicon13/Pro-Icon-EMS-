import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../Core/utils/enums/role.dart';

part 'select_role_state.dart';

class SelectRoleCubit extends Cubit<SelectRoleState> {
  SelectRoleCubit() : super(const SelectRoleState());

  void selectRole(Role role) => emit(state.copyWith(role: role));
}
