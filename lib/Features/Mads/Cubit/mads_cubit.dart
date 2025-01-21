import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pro_icon/Core/cubits/user_state/user_state_cubit.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/data/repos/mads_repo.dart';

import '../../../data/models/mad.dart';
import 'mads_state.dart';

class MadsCubit extends Cubit<MadsState> {
  final MadRepository madRepository;
  MadsCubit({required this.madRepository}) : super(const MadsState());

  void setChangeStatus(MadsRequestStatus status) =>
      emit(state.copyWith(changeStatus: status));
  void setStatus(MadsRequestStatus status) =>
      emit(state.copyWith(status: status));
  void processMads() async {
    emit(state.copyWith(status: MadsRequestStatus.loading));
    final currentUserMads = getIt<UserStateCubit>().state.currentUser!.mads!;

    final result = await madRepository.processMads(currentUserMads);

    result.fold(
      (failure) => emit(state.copyWith(
          status: MadsRequestStatus.error, message: failure.message)),
      (mads) => emit(state.copyWith(
          madsList: mads, status: MadsRequestStatus.success, message: "")),
    );
  }

  void changeMadStatus({required int index, required bool status}) async {
    final result =
        await madRepository.changeMadStatus(index: index, status: status);
    result.fold(
        (failure) => emit(state.copyWith(
            changeStatus: MadsRequestStatus.error,
            message: failure.message)), (_) {
      List<Mad> mads = _updateMadsList(index, status);

      emit(state.copyWith(
          madsList: mads,
          status: MadsRequestStatus.success,
          changeStatus: MadsRequestStatus.success,
          message: "change.status.message".tr()));
    });
  }

  List<Mad> _updateMadsList(int index, bool status) {
    final mads = [...state.madsList!];

    mads[index] = mads[index].copyWith(isActive: status);
    return mads;
  }
}
