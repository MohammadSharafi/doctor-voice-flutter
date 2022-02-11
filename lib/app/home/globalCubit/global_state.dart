part of 'global_cubit.dart';


abstract class GlobalState {}


class InitialState extends GlobalState {
  @override
  List<Object> get props => [];
}

class GlobalLoadingState extends GlobalState {
  @override
  List<Object> get props => [];
}

class GlobalLoadedState extends GlobalState {
  GlobalLoadedState(this.title,this.index);

  final title;
  int index;

  @override
  List<Object> get props => [title,index];
}

class GlobalErrorState extends GlobalState {
  final String ? error;

  GlobalErrorState({this.error});
  @override
  List<Object> get props => [];
}