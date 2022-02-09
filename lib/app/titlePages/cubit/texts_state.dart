part of 'texts_cubit.dart';
abstract class TextState extends Equatable {}

class InitialState extends TextState {
  @override
  List<Object> get props => [];
}

class LoadingState extends TextState {
  @override
  List<Object> get props => [];
}

class LoadedState extends TextState {
  LoadedState(this.titleList);

  final List<TextListModel> titleList;

  @override
  List<Object> get props => [titleList];
}

class ErrorState extends TextState {
  @override
  List<Object> get props => [];
}