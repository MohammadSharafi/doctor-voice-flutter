import 'package:aimedic/app/record/cubit/record/record_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MicState { Record, None }

class NeumorphicMic extends StatefulWidget {
  NeumorphicMic({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final Function onTap;

  @override
  _NeumorphicMicState createState() => _NeumorphicMicState();
}

class _NeumorphicMicState extends State<NeumorphicMic> {
  bool tapped = false;
  double neomorphicOffset = 5;
  double blurRadius = 3;
  MicState micState = MicState.None;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecordCubit, RecordState>(
      listener: (context, state) {
        if (state is RecordOn) {
          setState(() {
            micState = MicState.Record;
          });
        } else {
          setState(() {
            micState = MicState.None;
          });
        }
      },
      child: GestureDetector(
          onTapDown: (_) {
            setState(() {
              tapped = true;
            });
          },
          onTapUp: (_) {
            setState(() {
              tapped = false;
            });
            widget.onTap();
          },
          onTapCancel: () {
            setState(() {
              tapped = false;
            });
          },
          child: Row(
            children: [
              Spacer(),
              Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.all(micState == MicState.Record?10:2),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    shape: BoxShape.circle),


                child: Container(
                  width: 40,
                  height: 40,

                  decoration: BoxDecoration(
                      color: Colors.red,
                      shape: micState == MicState.Record
                          ? BoxShape.rectangle
                          : BoxShape.circle),
                ),
              ),
              Spacer(),
            ],
          )),
    );
  }
}
