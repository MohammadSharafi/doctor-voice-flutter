part of 'profile_cubit.dart';

abstract class ProfileState {}


class InitialState extends ProfileState {
  @override
  List<Object> get props => [];
}

class LoadingState extends ProfileState {
  @override
  List<Object> get props => [];
}

class UpdateLoadingState extends ProfileState {
  @override
  List<Object> get props => [];
}

class LoadedState extends ProfileState {
  LoadedState(this.profileModel);

  final ProfileModel profileModel;

  @override
  List<Object> get props => [profileModel];
}

class UpdateLoadedState extends ProfileState {
  UpdateLoadedState(this.profileModel);

  final ProfileModel profileModel;

  @override
  List<Object> get props => [profileModel];
}

class ErrorState extends ProfileState {
  final String ? error;

  ErrorState({this.error});
  @override
  List<Object> get props => [];
}
