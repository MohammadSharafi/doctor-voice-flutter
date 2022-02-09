import 'package:aimedic/app/recordPage/recordpage.dart';
import 'package:aimedic/app/titlePages/cubit/texts_cubit.dart';
import 'package:aimedic/app/titlePages/model/ScreenArguments.dart';
import 'package:aimedic/app/titlePages/viewModel/titlePages_view_model.dart';
import 'package:flutter/material.dart';
import 'package:aimedic/core/widgets/home_page_widgets.dart/TaskWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
class TitlePagesView extends TitlePagesViewModel {
  @override
  void initState() {
    super.initState();
  }

  bool navigate = false;

  int solved = 0;
  int total = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TitlePagesCubit, TextState>(
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
          final texts = state.titleList;
          solved = 0;
          total = 0;
          texts.forEach((item) {
            if(item.is_recorded!)
              solved++;
            total++;
          });

          return Column(
            children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Tasks given',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '$solved\\$total',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 4,),
                    LinearPercentIndicator( //leaner progress bar
                    animation: true,
                    animationDuration: 1000,
                    lineHeight: 4.0,
                    percent:(solved/total),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Colors.blue[400],
                    backgroundColor: Colors.grey[300],
          ),
                  ],
                ),
              ),
            ),

              Expanded(
                flex: 50,
                child: ListView.builder(
                  itemCount: texts.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(RecorderPage.routeName,
                            arguments: ScreenArguments(texts[index].text ?? '',
                                texts[index].id ?? '', index));
                      },
                      child: Task(
                        text: texts[index].text ?? '',
                        index: index,
                        status:
                            texts[index].is_recorded! ? Status.Done : Status.NotDone,
                        key: ValueKey<int>(index),
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
