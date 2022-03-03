

import 'package:aimedic/app/record/controller/audio_player_controller.dart';
import 'package:aimedic/app/record/cubit/uploadVoice/uploadvoice_cubit.dart';
import 'package:aimedic/app/titlePages/model/ScreenArguments.dart';
import 'package:aimedic/core/constants/app_colors.dart';
import 'package:aimedic/core/widgets/login_background.dart';
import 'package:bottom_sheet_bar/bottom_sheet_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:microphone/microphone.dart';
import '../../../core/constants/loading.dart';
import '../../../core/network/network_service.dart';
import '../../home/globalCubit/global_cubit.dart';
import '../service/record_services.dart';


class RecordViewWeb extends StatefulWidget {
  final ScreenArguments ? args;
  const RecordViewWeb({Key? key, required this.args}) : super(key: key);

  @override
  _RecordViewWeb createState() => _RecordViewWeb();
}

class _RecordViewWeb extends State<RecordViewWeb> {
  final EdgeInsets paddingLow = EdgeInsets.all(8.0);
  bool _isLocked = false;
  bool _isCollapsed = true;
  bool _isExpanded = false;
  final _bsbController = BottomSheetBarController();
  late MicrophoneRecorder ? _recorder=MicrophoneRecorder();
  late AudioPlayer ? _audioPlayer=AudioPlayer();
  late RecordService ? recordService;
  final Dio ? dio = NetworkService.instance.dio;
  final AudioPlayerController controller = AudioPlayerController();

  @override
  void dispose() {
    _bsbController.removeListener(_onBsbChanged);
    _recorder!.dispose();
    _audioPlayer!.dispose();
    super.dispose();
  }
  void _initRecorder() {
    // Dispose the previous recorder.
    _recorder = MicrophoneRecorder()
      ..init()
      ..addListener(() {
        setState(() {});
      });
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
    recordService = RecordService(dio!);
    _initRecorder();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoiceUploadCubit, VoiceUploadState>(
      builder: (context, _state) {
        return Stack(
          children: [
            Background(
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
                      child: Column(
                        children: [
                          //  playingIndicator(),
                          Spacer(),
                          Stack(
                            children: [
                              Positioned(
                                child: GestureDetector(
                                  onTap: () async {

                                    /*     BlocProvider.of<VoiceUploadCubit>(
                                              context)
                                          .VoiceUpload(
                                              File('$_mPath'), args.id);*/
                                  },
                                  child: SvgPicture.asset(
                                    'assets/images/send.svg',
                                    color: (_recorder!.value.stopped && _recorder!.value.started)
                                        ? Colors.white
                                        :Colors.white.withOpacity(0.2) ,
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
                                  GestureDetector(
                                    onTap: (){
                                      if(!_recorder!.value.started)
                                        _recorder!.start();
                                      if(_recorder!.value.started)
                                        _recorder!.stop();

                                    },
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          padding: EdgeInsets.all(
                                              (_recorder!.value.started)
                                                  ? 10
                                                  : 2),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.white),
                                              shape: BoxShape.circle),
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                shape:
                                                (_recorder!.value.started)
                                                    ? BoxShape.rectangle
                                                    : BoxShape.circle),
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                child: GestureDetector(
                                    onTap:() async {
                                      _audioPlayer!.dispose();

                                      _audioPlayer = AudioPlayer();
                                      print(_recorder!.value.recording!.url);

                                      await _audioPlayer!.setUrl(_recorder!.value.recording!.url);
                                      await _audioPlayer!.play();
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
                                onTap: () async {
                                  /*        if (value.stopped && value.started)
                                    BlocProvider.of<VoiceUploadCubit>(context)
                                        .VoiceUpload( File('$_mPath'), args.id);*/
                                },
                                child: SvgPicture.asset(
                                  'assets/images/send.svg',
                                  color: (_recorder!.value.stopped && _recorder!.value.started)
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.2),
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
                                GestureDetector(
                                  onTap: (){
                                    if(!_recorder!.value.started)
                                      _recorder!.start();
                                    if(_recorder!.value.started)
                                      _recorder!.stop();
                                  },
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        padding: EdgeInsets.all(
                                            (_recorder!.value.started && !_recorder!.value.stopped) ? 10 : 2),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.white),
                                            shape: BoxShape.circle),
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              shape: (_recorder!.value.started &&! _recorder!.value.stopped)
                                                  ? BoxShape.rectangle
                                                  : BoxShape.circle),
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              child: GestureDetector(
                                onTap:() async {
                                  _audioPlayer!.dispose();

                                  _audioPlayer = AudioPlayer();
                                  print(_recorder!.value.recording!.url);

                                  await _audioPlayer!.setUrl(_recorder!.value.recording!.url);
                                  await _audioPlayer!.play();
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
                        "Text ${widget.args!.index}",
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
                          widget.args!.title,
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
  }

  Widget playingIcon() {
    return (_audioPlayer!.playing)
        ? Icon(
      Icons.pause_rounded,
      size: 28,
      color: Colors.white,
    )
        : SvgPicture.asset(
      'assets/images/Polygon 5.svg',
      color: (_recorder!.value.stopped && _recorder!.value.started)? Colors.white : Colors.white.withOpacity(0.2),
      height: 28,
    );
  }
}



