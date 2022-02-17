import 'package:aimedic/app/recordList/model/voice_list_model.dart';
import 'package:aimedic/app/recordList/service/voicelist_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'voice_refactor_state.dart';


class VoiceListCubit extends Cubit<VoiceListState> {
  VoiceListCubit({required this.repository}) : super(InitialState()) {
    getVoices();
  }

  final VoiceListService repository;

  void getVoices() async {
    try {
      emit(LoadingState());
      final text = await repository.getUserVoices();
      emit(LoadedState(text!));
    } catch (e) {
      emit(ErrorState());
    }
  }
}