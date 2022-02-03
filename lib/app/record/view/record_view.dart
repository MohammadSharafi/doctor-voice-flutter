import 'package:aimedic/app/record/controller/audio_player_controller.dart';
import 'package:aimedic/app/record/cubit/record/record_cubit.dart';
import 'package:aimedic/app/record/view/widgets/audio_visualizer.dart';
import 'package:aimedic/app/record/view/widgets/mic.dart';
import 'package:aimedic/app/record/viewModel/record_view_model.dart';
import 'package:aimedic/core/constants/app_colors.dart';
import 'package:aimedic/core/constants/recorder_constants.dart';
import 'package:aimedic/core/widgets/login_background.dart';
import 'package:bottom_sheet_bar/bottom_sheet_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:toggle_switch/toggle_switch.dart';

class RecordView extends RecordViewModel {
  final EdgeInsets paddingLow = EdgeInsets.all(8.0);
  bool _isLocked = false;
  bool _isCollapsed = true;
  bool _isExpanded = false;
  int _listSize = 5;
  final _bsbController = BottomSheetBarController();
  final _listSizeController = TextEditingController(text: '5');

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController controllerPhone = TextEditingController();

  @override
  void dispose() {
    _bsbController.removeListener(_onBsbChanged);
    super.dispose();
  }

  void _onListSizeChanged() {
    _listSize = int.tryParse(_listSizeController.text) ?? 5;
  }

  void _onBsbChanged() {
    if (_bsbController.isCollapsed && !_isCollapsed) {
      setState(() {
        _isCollapsed = true;
        _isExpanded = false;
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
    _bsbController.addListener(_onBsbChanged);
    _listSizeController.addListener(_onListSizeChanged);
    super.initState();
  }
  final AudioPlayerController controller = AudioPlayerController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RecordCubit, RecordState>(
        builder: (context, state) {
          return Background(
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
                      child: Container());
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
                    child: Stack(
                      children: [
                        Positioned(child: SvgPicture.asset('assets/images/send.svg',color: Colors.white,height: 28,),right: 30,top: 0,bottom: 0,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            NeumorphicMic(
                                onTap: () {
                              if (state is RecordStopped || state is RecordInitial)
                                context.read<RecordCubit>().startRecording();
                              else if (state is RecordOn) {
                                context.read<RecordCubit>().stopRecording();
                              }
                            }),
                          ],
                        ),
                        Positioned(child: SvgPicture.asset('assets/images/Polygon 5.svg',color: Colors.white,height: 28,),left: 30,top: 0,bottom: 0,),

                      ],
                    ),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      ToggleSwitch(
                        minWidth: 120.0,
                        cornerRadius: 8.0,
                        activeBgColors: [
                          [Colors.grey],
                          [Colors.grey]
                        ],
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.black,
                        inactiveFgColor: Colors.white,
                        initialLabelIndex: 1,
                        totalSwitches: 2,
                        labels: ['Record', 'List'],
                        radiusStyle: true,
                        onToggle: (index) {
                          print('switched to: $index');
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Text 2",
                        style: GoogleFonts.yantramanav(
                          textStyle: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "(sometimewrittennotetaking or note taking) is the practice of recording information captured from another source. By taking notes, the writer records the essence of the information, freeing their mind from having to recall everything.[1] Notes are commonly drawn from a transient source, such as an oral discussion at a meeting, or a lecture (notes of a meeting are usually called minutes), in which case the notes may be the only record of the event.",
                              style: GoogleFonts.yantramanav(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
