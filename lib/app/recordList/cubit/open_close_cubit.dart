import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'open_close_state.dart';

class openCloseCubit extends Cubit<openCloseState> {
  openCloseCubit() : super(LoadedState(0, 0));


  void open_close(int index,int preIndex) async {
    try {
      emit(LoadedState(index,preIndex));
    } catch (e) {
    }
  }
}