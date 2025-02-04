import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'history_info_state.dart';

class HistoryInfoCubit extends Cubit<HistoryInfoState> {
  HistoryInfoCubit() : super(HistoryInfoInitial());
}
