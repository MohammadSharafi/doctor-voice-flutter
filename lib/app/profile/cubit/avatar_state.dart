part of 'avatar_cubit.dart';

abstract class AvatarState {}


class InitialState extends AvatarState {
  @override
  List<Object> get props => [];
}


class UpLoadLoadingState extends AvatarState {
  @override
  List<Object> get props => [];
}

class UploadLoadedState extends AvatarState {
  UploadLoadedState(this.uploadModel);

  final FileUploadModelRes uploadModel;

  @override
  List<Object> get props => [uploadModel];
}

class AvatarErrorState extends AvatarState {
  @override
  List<Object> get props => [];
}