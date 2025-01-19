import 'package:bloc/bloc.dart';

part 'mads_state.dart';

class MadsCubit extends Cubit<MadsState> {
  MadsCubit() : super(MadsInitial());
}
