import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../Core/utils/enums/role.dart';
import '../../../../../Core/utils/role_selection_helper.dart';

part 'select_role_state.dart';

class SelectRoleCubit extends Cubit<SelectRoleState> {
  final RoleSelectionHelper _roleSelectionHelper;
  SelectRoleCubit(this._roleSelectionHelper) : super(const SelectRoleState());

  void selectRole(Role role) {
    _roleSelectionHelper.setRole(role);
    emit(state.copyWith(role: role));
  }
}
