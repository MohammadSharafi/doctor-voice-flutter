import 'package:aimedic/app/titlePages/model/text_list_model.dart';
import 'package:aimedic/app/titlePages/service/titlePage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'texts_state.dart';


class TitlePagesCubit extends Cubit<TextState> {
  TitlePagesCubit({required this.repository}) : super(InitialState()) {
    getList();
  }

  final HomeService repository;

  void getList() async {
    try {
      emit(LoadingState());
      final text = await repository.getUserTexts();
      emit(LoadedState(text!));
    } catch (e) {
      emit(ErrorState());
    }
  }
}