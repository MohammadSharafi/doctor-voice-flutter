import 'dart:io';

import 'package:aimedic/app/record/controller/audio_player_controller.dart';
import 'package:aimedic/app/record/models/recording.dart';
import 'package:aimedic/app/record/models/recording_group.dart';
import 'package:aimedic/core/constants/paths.dart';
import 'package:bloc/bloc.dart';
import 'package:permission_handler/permission_handler.dart';
part 'files_state.dart';

class FilesCubit extends Cubit<FilesState> {
  FilesCubit() : super(FilesInitial()) {
    getFiles();
  }

  Future<void> getFiles() async {
    List<Recording> recordings = [];
    emit(FilesLoading());
    PermissionStatus permissionGranted = await Permission.storage.request();
    if (permissionGranted == PermissionStatus.granted) {
      final List<FileSystemEntity> files =
          Directory(Paths.recording).listSync();

      for (final file in files) {
        AudioPlayerController controller = AudioPlayerController();

        /// Used controller her just to get the duration on file using [setPath()]
        Duration? fileDuration = await controller.setPath(filePath: file.path);
        if (fileDuration != null) {
          recordings.add(Recording(file: file, fileDuration: fileDuration));
        }
      }

      emit(FilesLoaded(recordings: recordings));
    } else {
      emit(FilesPermisionNotGranted());
    }
  }

  removeRecording(Recording recording) {
    final recordings = (state as FilesLoaded)
        .recordings
        .where((element) => element != recording)
        .toList();
    emit(FilesLoaded(recordings: recordings));
  }
}
