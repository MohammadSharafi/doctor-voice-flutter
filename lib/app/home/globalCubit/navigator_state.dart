part of 'navigator_cubit.dart';


abstract class NavigationState {}


class InitialStateNav extends NavigationState {

  @override
  List<Object> get props => [];
}

class NavigationLoadingState extends NavigationState {
  @override
  List<Object> get props => [];
}

class NavigationLoadedState extends NavigationState {
  NavigationLoadedState(this.page,this.screenArguments);

  final page;
  final screenArguments;

  @override
  List<Object> get props => [page,screenArguments];
}

class NavigationErrorState extends NavigationState {
  final String ? error;

  NavigationErrorState({this.error});
  @override
  List<Object> get props => [];
}