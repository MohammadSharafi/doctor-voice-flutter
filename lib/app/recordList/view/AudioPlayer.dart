import 'package:aimedic/app/recordList/cubit/open_close_cubit.dart';
import 'package:aimedic/core/constants/app_colors.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AudioPlayerUrl extends StatefulWidget {
  final String url;
  String? title;
  String? date;
  String? text;
  String? status;
  int? index;

  AudioPlayerUrl(
      {Key? key,
      required this.url,
      required this.text,
      required this.title,
      required this.status,
      this.date,
      this.index})
      : super(key: key);

  @override
  _AudioPlayerUrlState createState() => _AudioPlayerUrlState();
}

class _AudioPlayerUrlState extends State<AudioPlayerUrl> {
  bool is_open = false;

  /// For clarity, I added the terms compulsory and optional to certain sections
  /// to maintain clarity as to what is really needed for a functioning audio player
  /// and what is added for further interaction.
  ///
  /// 'Compulsory': A functioning audio player with:
  ///             - Play/Pause button
  ///
  /// 'Optional': A functioning audio player with:
  ///             - Play/Pause button
  ///             - time stamps for progress and duration
  ///             - slider to jump within the audio file
  ///
  /// Compulsory

  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState audioPlayerState = PlayerState.PAUSED;

  /// Optional
  int timeProgress = 0;
  int audioDuration = 0;

  /// Optional
  Widget slider() {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: 2,
          thumbShape: RoundSliderThumbShape(
            disabledThumbRadius: 6,
            enabledThumbRadius: 6,
          ),
          overlayShape: RoundSliderOverlayShape(
            overlayRadius: 2,
          ),
          inactiveTrackColor: Colors.grey,
        ),
        child: Slider(
            activeColor:AppColors.redStatus,
            value: timeProgress.toDouble(),
            max: audioDuration.toDouble(),
            onChanged: (value) {
              seekToSec(value.toInt());
            }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    /// Compulsory
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        audioPlayerState = state;
      });
    });

    /// Optional
    audioPlayer.setUrl(widget
        .url); // Triggers the onDurationChanged listener and sets the max duration string
    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        audioDuration = duration.inSeconds;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((Duration position) async {
      setState(() {
        timeProgress = position.inSeconds;
      });
    });
  }

  /// Compulsory
  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    super.dispose();
  }

  /// Compulsory
  playMusic() async {
    // Add the parameter "isLocal: true" if you want to access a local file
    await audioPlayer.play(widget.url);
  }

  /// Compulsory
  pauseMusic() async {
    await audioPlayer.pause();
  }

  /// Optional
  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    audioPlayer
        .seek(newPos); // Jumps to the given position within the audio file
  }

  /// Optional
  String getTimeString(int seconds) {
    String minuteString =
        '${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
    String secondString = '${seconds % 60 < 10 ? 0 : ''}${seconds % 60}';
    return '$minuteString:$secondString'; // Returns a string with the format mm:ss
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<openCloseCubit, openCloseState>(
      builder: (context, state) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                if (state is LoadedState)
                  BlocProvider.of<openCloseCubit>(context)
                      .open_close(widget.index!, state.index);
              },
              child: Container(
                color:(widget.index! % 2==0)? Colors.white.withOpacity(0.01):Colors.transparent,
                child: Container(
                    margin: EdgeInsets.all(12),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: audioPlayerState == PlayerState.PLAYING
                                        ? Colors.black38
                                        : AppColors.primaryDarkBlue,
                                    border: Border.all(
                                      color:
                                          audioPlayerState == PlayerState.PLAYING
                                              ? Colors.white.withOpacity(0.6)
                                              : Colors.transparent,
                                    ),
                                  ),
                                  child: Center(
                                    child: IconButton(
                                        iconSize: 30,
                                        onPressed: () {
                                          audioPlayerState == PlayerState.PLAYING
                                              ? pauseMusic()
                                              : playMusic();
                                        },
                                        icon: Center(
                                          child: Icon(
                                            audioPlayerState ==
                                                    PlayerState.PLAYING
                                                ? Icons.pause_rounded
                                                : Icons.play_arrow_rounded,
                                            color: Colors.white.withOpacity(0.6),
                                            size: 20,
                                          ),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        widget.title ?? '',
                                        textAlign: TextAlign.left,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Container(
                                      width: 120,
                                      child: Text(
                                        (widget.date) ?? '',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                  width: 1,
                                  color: (widget.status ?? '')
                                          .toLowerCase()
                                          .contains('pending')
                                      ? AppColors.blueStatus
                                      : (widget.status ?? '')
                                              .toLowerCase()
                                              .contains('failed')
                                          ? AppColors.redStatus
                                          : AppColors.greenStatus,
                                ),
                                color: (widget.status ?? '')
                                        .toLowerCase()
                                        .contains('pending')
                                    ? AppColors.blueStatusBg
                                    : (widget.status ?? '')
                                            .toLowerCase()
                                            .contains('failed')
                                        ? AppColors.redStatusBg
                                        : AppColors.greenStatusBg,
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    (widget.status ?? '')
                                            .toLowerCase()
                                            .contains('pending')
                                        ? 'assets/images/load.svg'
                                        : (widget.status ?? '')
                                                .toLowerCase()
                                                .contains('failed')
                                            ? 'assets/images/Close Square.svg'
                                            : 'assets/images/Tick Square.svg',
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    widget.status ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: (widget.status ?? '')
                                              .toLowerCase()
                                              .contains('pending')
                                          ? AppColors.blueStatus
                                          : (widget.status ?? '')
                                                  .toLowerCase()
                                                  .contains('failed')
                                              ? AppColors.redStatus
                                              : AppColors.greenStatus,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        (state is LoadedState)
                            ? (state.index == widget.index)
                                ? Row(
                                    children: [
                                      SizedBox(
                                        width: 52,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                90,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              widget.text ?? '',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  width: 240, child: slider()),
                                              SizedBox(width: 4),
                                              Text(
                                                '- ' +
                                                    getTimeString(audioDuration -
                                                        timeProgress),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Container()
                            : Container(),
                      ],
                    )),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width ,
              height: 0.1,
              color: Colors.white.withOpacity(0.3),
            )
          ],
        );
      },
    );
  }
}
