import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/user_dashboard_model.dart';
import '../service/dashboard_service.dart';
part 'dashboard_state.dart';

class DashBoardCubit extends Cubit<DashBoardState> {
  final DashBoardService repository;

  DashBoardCubit({required this.repository,}) : super(InitialState()){
    getDash();
  }


  void getDash() {

    emit(LoadingState());
    Timer(Duration(seconds: 1), ()  async {
      final res = await repository.getDashBoard();
      emit(LoadedState(res!));

    });

  }
  void refresh( ) {


    emit(InitialState());


  }
}