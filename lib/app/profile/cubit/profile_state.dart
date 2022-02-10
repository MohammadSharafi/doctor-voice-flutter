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

class LoadedState extends ProfileState {
  LoadedState(this.profileModel);

  final ProfileModel profileModel;

  @override
  List<Object> get props => [profileModel];
}

class ErrorState extends ProfileState {
  @override
  List<Object> get props => [];
}