import 'dart:async';
import 'dart:io';
import 'package:aimedic/app/record/models/filecreateModel.dart';
import 'package:aimedic/app/record/service/record_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'uploadvoice_state.dart';

class VoiceUploadCubit extends Cubit<VoiceUploadState> {
  final RecordService repository;

  VoiceUploadCubit({
    required this.repository,
  }) : super(InitialState());

  void VoiceUpload(File voice, String id) {
    if (voice == null) {
      emit(ErrorState(error: "please try again"));
      return;
    }

    emit(LoadingState());
    repository.sendFile(voice).then((_response) {
      repository.creatFile(createVoiceModel(
            url: _response!.fileName,
            textId: id,
          ))
          .then((value) => {
            emit(LoadedState(_response)
            )});
    });
  }

  void refresh() {
    emit(InitialState());
  }
}
