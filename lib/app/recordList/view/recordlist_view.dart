import 'package:aimedic/app/recordList/cubit/voice_refactor_cubit.dart';
import 'package:aimedic/app/recordList/view/mediaPlayer.dart';
import 'package:aimedic/app/recordList/viewModel/recordlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordListView extends RecordListViewModel {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoiceListCubit, VoiceListState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ErrorState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedState) {
          final voices = state.voiceList;

          return ListView.builder(
            itemCount: voices.length,
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: [
                    MediaWidget(
                      url: voices[index].url,
                      key: ValueKey(index),
                      text:voices[index].text?.text ,
                      //TODO: change
                      title:'Text ${index}'.padLeft(3,'0') ,
                      status: voices[index].status,
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
