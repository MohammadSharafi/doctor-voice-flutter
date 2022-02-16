import 'package:bloc/bloc.dart';
part 'error_state.dart';


class ErrorCubit extends Cubit<ErrorState> {
  final String error;

  ErrorCubit({required this.error,}) : super(InitialState());

  void setError(String err) {
    emit(ErrorErrorState(error: err));
  }

}

