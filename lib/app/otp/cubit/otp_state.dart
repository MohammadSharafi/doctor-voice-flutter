part of 'otp_cubit.dart';


abstract class OTPState {}


class InitialState extends OTPState {
  @override
  List<Object> get props => [];
}

class LoadingState extends OTPState {
  @override
  List<Object> get props => [];
}

class LoadedState extends OTPState {
  LoadedState(this.response);

  OTPResponseModel response;

  @override
  List<Object> get props => [response];
}

class ErrorState extends OTPState {
  final String ? error;

  ErrorState({this.error});
  @override
  List<Object> get props => [];
}