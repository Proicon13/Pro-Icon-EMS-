import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pro_icon/data/models/programming_request.dart';
import 'package:pro_icon/data/services/programmer_request.dart';

part 'programmer_request_state.dart';

class ProgrammerRequestCubit extends Cubit<ProgrammerRequestState> {
  
  final ProgrammerRequestService programmerRequestService;
  
  ProgrammerRequestCubit({required this.programmerRequestService}) : super(ProgrammerRequestInitial());
  
  
  void getProgrammingRequests () async
  {
    final result = await programmerRequestService.getProgrammingRequest();

    result.fold((error) => {emit(ProgrammerRequestError( error.message))},
            (ProgrammingRequest) => {emit(ProgrammerRequestLoaded(ProgrammingRequest))});
    
  }
  
}
