part of 'login_cubit.dart';


abstract class LoginState {}


class InitialState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadedState extends LoginState {
  LoadedState(this.response);

  final response;

  @override
  List<Object> get props => [response];
}

class ErrorState extends LoginState {
  final String ? error;

  ErrorState({this.error});
  @override
  List<Object> get props => [];
}