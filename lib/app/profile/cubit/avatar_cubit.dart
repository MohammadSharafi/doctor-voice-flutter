import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../record/models/fileUploadModelResponse.dart';
import '../service/profile_service.dart';
part 'avatar_state.dart';

class AvatarCubit extends Cubit<AvatarState> {
  AvatarCubit({required this.repository}) : super(InitialState());

  final ProfileService repository;

  
  void uploadAvatar(File file) async {
    try {
      emit(UpLoadLoadingState());
      final Avatar = await repository.setIMAGE(file);
      emit(UploadLoadedState(Avatar!));
    } catch (e) {
      emit(AvatarErrorState(error: 'Failed to update profile.'));

    }
  }


}
