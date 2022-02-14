import 'dart:io';

import 'package:aimedic/app/record/controller/audio_player_controller.dart';
import 'package:aimedic/app/record/cubit/record/record_cubit.dart';
import 'package:aimedic/app/record/cubit/uploadVoice/uploadvoice_cubit.dart';
import 'package:aimedic/app/record/view/widgets/mic.dart';
import 'package:aimedic/app/record/view/widgets/playing_icons.dart';
import 'package:aimedic/app/record/viewModel/record_view_model.dart';
import 'package:aimedic/app/titlePages/model/ScreenArguments.dart';
import 'package:aimedic/core/constants/app_colors.dart';
import 'package:aimedic/core/widgets/login_background.dart';
import 'package:bottom_sheet_bar/bottom_sheet_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';

import 'package:toggle_switch/toggle_switch.dart';

import '../../../core/constants/loading.dart';
import '../../home/globalCubit/global_cubit.dart';

class RecordView extends RecordViewModel {
  final EdgeInsets paddingLow = EdgeInsets.all(8.0);
  bool _isLocked = false;
  bool _isCollapsed = true;
  bool _isExpanded = false;
  final _bsbController = BottomSheetBarController();
  final ScreenArguments args;
  late String audPath = '';
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController controllerPhone = TextEditingController();

  RecordView(this.args);

  @override
  void dispose() {
    _bsbController.removeListener(_onBsbChanged);
    super.dispose();
  }

  void _onBsbChanged() {
    if (_bsbController.isCollapsed && !_isCollapsed) {
      setState(() {
        _isCollapsed = true;
        _isExpanded = false;
        controller.stop();
      });
    } else if (_bsbController.isExpanded && !_isExpanded) {
      setState(() {
        _isCollapsed = false;
        _isExpanded = true;
      });
    }
  }

  @override
  void initState() {
    BlocProvider.of<GlobalCubit>(context).getTitle('Record', 1);
    _bsbController.addListener(_onBsbChanged);
    super.initState();
  }

  final AudioPlayerController controller = AudioPlayerController();
  bool is_record = false;

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return BlocBuilder<VoiceUploadCubit, VoiceUploadState>(
      builder: (context, _state) {
        return BlocBuilder<RecordCubit, RecordState>(
          builder: (context, state) {
            return Stack(
              children: [
                Background(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: BottomSheetBar(
                      locked: _isLocked,
                      height: 100,
                      color: Colors.transparent,
                      controller: _bsbController,
                      expandedBuilder: (scrollController) {
                        return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(18),
                                  topLeft: Radius.circular(18)),
                              color: Colors.black,
                            ),
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              child: Column(
                                children: [
                                  playingIndicator(),
                                  Spacer(),
                                  Stack(
                                    children: [
                                      Positioned(
                                        child: GestureDetector(
                                          onTap: () {
                                            if (audPath != '')
                                              BlocProvider.of<VoiceUploadCubit>(
                                                      context)
                                                  .VoiceUpload(
                                                      File(audPath), args.id);
                                          },
                                          child: SvgPicture.asset(
                                            'assets/images/send.svg',
                                            color: Colors.white,
                                            height: 28,
                                          ),
                                        ),
                                        right: 30,
                                        top: 0,
                                        bottom: 0,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          NeumorphicMic(onTap: () {
                                            if (state is RecordStopped ||
                                                state is RecordInitial) {
                                              if (!is_record) {
                                                is_record = true;
                                                context
                                                    .read<RecordCubit>()
                                                    .startRecording();
                                              }
                                            } else if (state is RecordOn) {
                                              context
                                                  .read<RecordCubit>()
                                                  .stopRecording()
                                                  .then((value) =>
                                                      {audPath = value});
                                            }
                                          }),
                                        ],
                                      ),
                                      Positioned(
                                        child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _isCollapsed = false;
                                                _isExpanded = true;
                                                _bsbController.expand();
                                              });
                                            },
                                            child: playingIcon()),
                                        left: 30,
                                        top: 0,
                                        bottom: 0,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ));
                      },
                      collapsed: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(18),
                              topLeft: Radius.circular(18)),
                          color: Colors.black,
                        ),
                        child: SizedBox(
                          height: 200,
                          child: Column(
                            children: [
                              Spacer(),
                              Stack(
                                children: [
                                  Positioned(
                                    child: GestureDetector(
                                      onTap: () {
                                        if (audPath != '')
                                          BlocProvider.of<VoiceUploadCubit>(
                                                  context)
                                              .VoiceUpload(
                                                  File(audPath), args.id);
                                      },
                                      child: SvgPicture.asset(
                                        'assets/images/send.svg',
                                        color: audPath == ''
                                            ? Colors.grey
                                            : Colors.white,
                                        height: 28,
                                      ),
                                    ),
                                    right: 30,
                                    top: 0,
                                    bottom: 0,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      NeumorphicMic(onTap: () {
                                        print(
                                            'path ================>' + audPath);

                                        if (state is RecordStopped ||
                                            state is RecordInitial) {
                                          if (!is_record) {
                                            is_record = true;
                                            context
                                                .read<RecordCubit>()
                                                .startRecording();
                                          }
                                        } else if (state is RecordOn) {
                                          context
                                              .read<RecordCubit>()
                                              .stopRecording()
                                              .then(
                                                  (value) => {audPath = value});
                                        }
                                      }),
                                    ],
                                  ),
                                  Positioned(
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (audPath != '') {
                                          setState(() {
                                            _isCollapsed = false;
                                            _isExpanded = true;
                                            _bsbController.expand();
                                          });
                                          await controller.stop();
                                          await controller.setPath(
                                              filePath: audPath);
                                          await controller.play();
                                          await controller.stop();
                                        }
                                      },
                                      child: playingIcon(),
                                    ),
                                    left: 30,
                                    top: 0,
                                    bottom: 0,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Text ${args.index}",
                              style: GoogleFonts.yantramanav(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                args.title,
                                style: GoogleFonts.yantramanav(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                (_state is LoadingState)
                    ? Container(
                        color: AppColors.loadingBg,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Loading.loading)
                    : Container(),
              ],
            );
          },
        );
      },
    );
  }

  Widget playingIndicator() {
    final double borderRadius = 40;
    return GestureDetector(
      onTap: () {
        controller.stop();
      },
      child: Container(
        alignment: Alignment.center,
        height: 80,
        child: StreamBuilder<PlayerState>(
          stream: controller.playerState,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.playing) {
                return PlayingIcon();
              } else {
                return PlayingIcon.idle();
              }
            } else {
              return Text('Stopped');
            }
          },
        ),
      ),
    );
  }

  Widget playingIcon() {
    return StreamBuilder<PlayerState>(
      stream: controller.playerState,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.playing) {
            return Icon(
              Icons.pause_rounded,
              size: 28,
              color: Colors.white,
            );
          } else {
            return SvgPicture.asset(
              'assets/images/Polygon 5.svg',
              color: audPath == '' ? Colors.grey : Colors.white,
              height: 28,
            );
          }
        } else {
          return Text('Stopped');
        }
      },
    );
  }
}
