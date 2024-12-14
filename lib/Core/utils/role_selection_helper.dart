import 'enums/role.dart';

class RoleSelectionHelper {
  Role? _selectedRole;
  Role get selectedRole => _selectedRole!;
  void setRole(Role role) => _selectedRole = role;
}
