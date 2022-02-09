part of 'uploadvoice_cubit.dart';


abstract class VoiceUploadState {}


class InitialState extends VoiceUploadState {
  @override
  List<Object> get props => [];
}

class LoadingState extends VoiceUploadState {
  @override
  List<Object> get props => [];
}

class LoadedState extends VoiceUploadState {
  LoadedState(this.response);

  final response;

  @override
  List<Object> get props => [response];
}

class ErrorState extends VoiceUploadState {
  final String ? error;

  ErrorState({this.error});
  @override
  List<Object> get props => [];
}