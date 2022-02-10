import 'package:aimedic/app/profile/model/profile_model.dart';
import 'package:aimedic/app/profile/service/profile_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.repository}) : super(InitialState()) {
    getTrendingMovies();
  }

  final ProfileService repository;

  void getTrendingMovies() async {
    try {
      emit(LoadingState());
      final profile = await repository.getProfile();
      emit(LoadedState(profile!));
    } catch (e) {
      emit(ErrorState());
    }
  }
}
