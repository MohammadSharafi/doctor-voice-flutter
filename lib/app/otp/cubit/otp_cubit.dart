import 'dart:async';

import 'package:aimedic/app/OTP/service/OTP_services.dart';
import 'package:aimedic/app/otp/model/otp_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/otp_response_model.dart';

part 'otp_state.dart';

class OTPCubit extends Cubit<OTPState> {
  final OTPService repository;

  OTPCubit({required this.repository,}) : super(InitialState());
  Future<void> OTP(String ? code,String ? otp_token) async {
    try {
      emit(LoadingState());

       var response = await  repository.getOTP(OTPRequestModel(otp_token:otp_token ,code:code )).timeout(const Duration(seconds: 12));
       emit(LoadedState(response!));

    } on TimeoutException catch (e) {
      emit(ErrorState());
    } on Error catch (e) {
      emit(ErrorState());
    }






  }
  void refresh( ) {

    emit(InitialState());

  }
}