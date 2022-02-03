import 'package:flutter_bloc/flutter_bloc.dart';
part 'otp_state.dart';

class OTPCubit extends Cubit<OTPState> {
  OTPCubit() : super(OTPInitial());

}
