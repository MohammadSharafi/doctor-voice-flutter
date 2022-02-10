import 'dart:async';

import 'package:aimedic/app/OTP/service/OTP_services.dart';
import 'package:aimedic/app/otp/model/otp_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/otp_response_model.dart';

part 'otp_state.dart';

class OTPCubit extends Cubit<OTPState> {
  final OTPService repository;

  OTPCubit({required this.repository,}) : super(InitialState());
  void OTP(String ? code,String ? otp_token) {

    try{
    emit(LoadingState());
    Timer(Duration(seconds: 1), ()  {
       repository.getOTP(OTPRequestModel(otp_token:otp_token ,code:code )).then((response) {
        emit(LoadedState(response!));

      });
    });
    emit(ErrorState());

    }
    catch(e){
      emit(ErrorState());

    }


  }
  void refresh( ) {

    emit(InitialState());

  }
}