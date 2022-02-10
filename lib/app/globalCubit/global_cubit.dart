import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  final String title;

  GlobalCubit({
    required this.title,
  }) : super(InitialState());

  void getTitle(String page) {
    emit(GlobalLoadedState(page));
  }

  void refresh() {
    emit(InitialState());
  }
}
