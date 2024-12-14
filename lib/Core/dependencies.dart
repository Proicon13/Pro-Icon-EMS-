import 'package:get_it/get_it.dart';
import 'package:pro_icon/Features/auth/role_selection/cubit/cubit/select_role_cubit.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerFactory(() => SelectRoleCubit());
}
