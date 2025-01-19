import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/Core/cubits/user_state/user_state_cubit.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/data/repos/mads_repo.dart';

import '../../../data/models/mad.dart';

part 'mads_state.dart';

class MadsCubit extends Cubit<MadsState> {
  final MadRepository madRepository;
  MadsCubit({required this.madRepository}) : super(const MadsState());

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

  void changeMadStatus({required int id, required bool status}) async {
    emit(state.copyWith(status: MadsRequestStatus.loading));
    final result = await madRepository.changeMadStatus(id: id, status: status);
    result.fold(
        (failure) => emit(state.copyWith(
            status: MadsRequestStatus.error, message: failure.message)), (_) {
      List<Mad> mads = _updateMadsList(id, status);

      emit(state.copyWith(
          madsList: mads,
          status: MadsRequestStatus.success,
          message: "changed status successfully"));
    });
  }

  List<Mad> _updateMadsList(int id, bool status) {
    final mads = [...state.madsList!];

    final index = mads.indexWhere((element) => element.id == id);

    mads[index] = mads[index].copyWith(isActive: status);
    return mads;
  }
}
