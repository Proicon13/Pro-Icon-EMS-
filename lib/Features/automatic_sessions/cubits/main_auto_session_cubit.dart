import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../Core/entities/automatic_session_entity.dart';

part 'main_auto_session_state.dart';

class MainAutoSessionCubit extends Cubit<MainAutoSessionState> {
  MainAutoSessionCubit() : super(const MainAutoSessionState());
}
