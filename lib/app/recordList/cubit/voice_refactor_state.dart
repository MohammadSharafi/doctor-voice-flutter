part of 'voice_refactor_cubit.dart';
abstract class VoiceListState extends Equatable {}

class InitialState extends VoiceListState {
  @override
  List<Object> get props => [];
}

class LoadingState extends VoiceListState {
  @override
  List<Object> get props => [];
}

class LoadedState extends VoiceListState {
  LoadedState(this.voiceList);

  final List<VoiceListItem> voiceList;

  @override
  List<Object> get props => [voiceList];
}

class ErrorState extends VoiceListState {
  @override
  List<Object> get props => [];
}