part of 'error_cubit.dart';

abstract class ErrorState {}


class InitialState extends ErrorState {
  @override
  List<Object> get props => [];
}


class ErrorErrorState extends ErrorState {
  final String ? error;

  ErrorErrorState({this.error});
  @override
  List<Object> get props => [];
}