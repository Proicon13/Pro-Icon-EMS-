import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mads_state.dart';

class MadsCubit extends Cubit<MadsState> {
  MadsCubit() : super(MadsInitial());
}
