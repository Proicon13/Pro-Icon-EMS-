import 'package:bloc/bloc.dart';

import 'mads_state.dart';



class MadsCubit extends Cubit<MadsState> {

  MadsCubit() : super(MadsInitial());
}
