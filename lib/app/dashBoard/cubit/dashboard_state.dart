part of 'dashboard_cubit.dart';


abstract class DashBoardState {}


class InitialState extends DashBoardState {
  @override
  List<Object> get props => [];
}

class LoadingState extends DashBoardState {
  @override
  List<Object> get props => [];
}

class LoadedState extends DashBoardState {
  LoadedState(this.response);

  Dashboard response;

  @override
  List<Object> get props => [response];
}

class ErrorState extends DashBoardState {
  final String ? error;

  ErrorState({this.error});
  @override
  List<Object> get props => [];
}