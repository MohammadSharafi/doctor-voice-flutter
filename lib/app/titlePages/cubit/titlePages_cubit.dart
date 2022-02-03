import 'dart:async';
import 'dart:io';
import 'package:aimedic/core/constants/paths.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
part 'titlePages_state.dart';

class TitlePagesCubit extends Cubit<TitlePagesState> {
  TitlePagesCubit() : super(TitlePagesInitial());

}
