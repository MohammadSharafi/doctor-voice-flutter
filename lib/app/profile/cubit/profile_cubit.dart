import 'dart:io';

import 'package:aimedic/app/profile/model/profile_model.dart';
import 'package:aimedic/app/profile/service/profile_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../record/models/fileUploadModelResponse.dart';
import '../model/profile_update_response.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.repository}) : super(InitialState()) {
    getProfile();
  }

  final ProfileService repository;

  void getProfile() async {
    try {
      emit(LoadingState());
      final profile = await repository.getProfile();
      emit(LoadedState(profile!));
    } catch (e) {
      emit(ErrorState());
    }
  }
  void updateProfile(ProfileUploadResponse model) async {
    try {
      emit(UpdateLoadingState());
      final profile = await repository.setProfile(model);
      emit(UpdateLoadedState(profile!));
    } catch (e) {
      emit(ErrorState());
    }
  }



}
