import 'package:aimedic/app/recordList/cubit/voice_refactor_cubit.dart';
import 'package:aimedic/app/recordList/view/mediaPlayer.dart';
import 'package:aimedic/app/recordList/viewModel/recordlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/loading.dart';
import '../../home/globalCubit/global_cubit.dart';

class RecordListView extends RecordListViewModel {
  @override
  void dispose() {
    super.dispose();
  }
  @override
  void initstate() {
    BlocProvider.of<GlobalCubit>(context).getTitle('List',1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoiceListCubit, VoiceListState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(
            child: Container(
                color: AppColors.loadingBg,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Loading.loading),
          );
        } else if (state is ErrorState) {
          return Center(
            child: Container(
                color: AppColors.loadingBg,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Loading.loading),
          );
        } else if (state is LoadedState) {
          final voices = state.voiceList;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: voices.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: MediaWidget(
                        url: voices[index].url,
                        key: ValueKey(index),
                        text:voices[index].text?.text ,
                        date: voices[index].created_at?.split('T').first,
                        title:'Text '+'${index+1}'.padLeft(3,'0') ,
                        status: voices[index].status,
                        index:index
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
