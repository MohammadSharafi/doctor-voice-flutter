import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aimedic/app/mainPage/service/mainPage_service.dart';
import 'package:aimedic/app/mainPage/viewModel/mainPage_view_model.dart';
import 'package:aimedic/core/widgets/home_page_widgets.dart/TaskWidget.dart';

class MainPageView extends MainPageViewModel {
  List<String> list = [
    'Lorem ipsum dolor sit amet, conurus congue mauris rhoncus aenean vel elit scelerisque.',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Egestas purus viverra accumsan in nisl nisi. Arcu cursus vitae congue mauris rhoncus aenean vel elit scelerisque.',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Egestas purus viverra accumsan in nisl nisi. Arcu cursus vitae congue mauris rhoncus aenean vel elit scelerisque.',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Egestas purus viverra accumsan in nisl nisi. Arcu cursus vitae congue mauris rhoncus aenean vel elit scelerisque.'
  ];

  @override
  void initState() {
    super.initState();
    homeViewModel.fetchUserDevicesList();
  }

  MainPageService get homeViewModel => context.read<MainPageService>();

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<MainPageService>(context);
    return Container(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Task(
            text: list[index],
            index: index,
            status: index % 2 == 0 ? Status.Done : Status.NotDone,
            key: ValueKey<int>(index),
          );
        },
      ),
    );
  }
}
