import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../Core/entities/automatic_session_entity.dart';
import 'main_auto_session_cubit.dart';

part 'custom_auto_session_state.dart';

class CustomAutoSessionCubit extends Cubit<CustomAutoSessionState> {
  CustomAutoSessionCubit() : super(const CustomAutoSessionState());
}
