import 'dart:async';
import 'package:aimedic/app/login/model/user_request_model.dart';
import 'package:aimedic/app/login/service/login_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginService repository;

  LoginCubit({required this.repository,}) : super(InitialState());
  void login(String mobile) {

    if (mobile.isEmpty) {
      emit(ErrorState(error: "please enter your PhoneNumber"));
      return;
    }

    emit(LoadingState());
    Timer(Duration(microseconds: 100), ()  {
       repository.getLogin(UserRequestModel(phone_number: mobile)).then((response) {
        emit(LoadedState(response));

      });
    });

  }
  void refresh( ) {


    emit(InitialState());


  }
}