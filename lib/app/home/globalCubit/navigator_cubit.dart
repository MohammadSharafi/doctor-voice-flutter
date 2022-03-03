import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../titlePages/model/ScreenArguments.dart';

part 'navigator_state.dart';

enum PAGES { HOME, DASHBOARD, PROFILE, CONTACT_US, ABOUT_US ,VOICE}

class NavigationCubit extends Cubit<NavigationState> {
  final PAGES page;

  NavigationCubit(
    this.page,
  ) : super(InitialStateNav());

  void setPage(PAGES page,{ScreenArguments? arguments}) {
    emit(NavigationLoadedState(page,arguments));
  }

  void refresh() {
    emit(InitialStateNav());
  }
}
