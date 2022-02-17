part of 'open_close_cubit.dart';


abstract class openCloseState extends Equatable {}

class LoadedState extends openCloseState {
  LoadedState(this.index,this.preIndex);

  final int index;
  final int preIndex;

  @override
  List<Object> get props => [index,];
}
