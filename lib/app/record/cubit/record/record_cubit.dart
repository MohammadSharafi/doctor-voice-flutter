import 'dart:async';
import 'dart:io';

import 'package:aimedic/core/constants/paths.dart';
import 'package:aimedic/core/constants/recorder_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
part 'record_state.dart';

class RecordCubit extends Cubit<RecordState> {
  RecordCubit() : super(RecordInitial());

  Record _audioRecorder = Record();

  void startRecording() async {
    Map<Permission, PermissionStatus> permissions = await [
      Permission.storage,
      Permission.microphone,
      Permission.accessMediaLocation,
      Permission.manageExternalStorage,
    ].request();

    bool permissionsGranted = permissions[Permission.storage]!.isGranted &&
        permissions[Permission.microphone]!.isGranted;

    if (permissionsGranted) {
      Directory appDocDirectory = await getApplicationDocumentsDirectory();
      var filepath ='';
      Directory appFolder = Directory(appDocDirectory.path);
      bool appFolderExists = await appFolder.exists();
      if (!appFolderExists) {
        final created = await appFolder.create(recursive: true);
        print(created.path);
      }

      Directory(appDocDirectory.path)
          .create(recursive: true)
          .then((Directory directory) async {
        filepath =directory.path+'/'+DateTime.now().millisecondsSinceEpoch.toString() + RecorderConstants.fileExtention ;
        print('Path of New Dir: '+directory.path);
        await _audioRecorder.start(path: filepath);
        emit(RecordOn());
      });




    } else {
      print('Permissions not granted');
    }
  }

  Future<String>  stopRecording() async {
    String? path = await _audioRecorder.stop();
    emit(RecordStopped());
    print('Output path $path');
    return '$path';
  }

  Future<Amplitude> getAmplitude() async {
    final amplitude = await _audioRecorder.getAmplitude();
    return amplitude;
  }

  Stream<double> aplitudeStream() async* {
    while (true) {
      await Future.delayed(Duration(
          milliseconds: RecorderConstants.amplitudeCaptureRateInMilliSeconds));
      final ap = await _audioRecorder.getAmplitude();
      yield ap.current;
    }
  }
}
