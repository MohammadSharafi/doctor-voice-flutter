import 'package:aimedic/app/record/record.dart';
import 'package:aimedic/app/titlePages/viewModel/titlePages_view_model.dart';
import 'package:flutter/material.dart';
import 'package:aimedic/core/widgets/home_page_widgets.dart/TaskWidget.dart';

class TitlePagesView extends TitlePagesViewModel {
  List<String> list = [
    'Lorem ipsum dolor sit amet, conurus congue mauris rhoncus aenean vel elit scelerisque.',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Egestas purus viverra accumsan in nisl nisi. Arcu cursus vitae congue mauris rhoncus aenean vel elit scelerisque.',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Egestas purus viverra accumsan in nisl nisi. Arcu cursus vitae congue mauris rhoncus aenean vel elit scelerisque.',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Egestas purus viverra accumsan in nisl nisi. Arcu cursus vitae congue mauris rhoncus aenean vel elit scelerisque.'
  ];

  @override
  void initState() {
    super.initState();
  }

  bool navigate=false;
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(Record.routeName);
            },
            child: Task(
              text: list[index],
              index: index,
              status: index % 2 == 0 ? Status.Done : Status.NotDone,
              key: ValueKey<int>(index),
            ),
          );
        },
      ),
    );
  }
}
