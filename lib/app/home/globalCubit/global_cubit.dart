import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  final String title;
  final int currentIndex;

  GlobalCubit(
    this.currentIndex, {
    required this.title,
  }) : super(InitialState());

  void getTitle(String page,int index) {
    emit(GlobalLoadedState(page,index));
  }

  void refresh() {
    emit(InitialState());
  }
}
