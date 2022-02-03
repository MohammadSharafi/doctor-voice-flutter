import 'package:aimedic/app/titlePages/titlePages.dart';
import 'package:aimedic/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:aimedic/app/dashBoard/dashboard.dart';
import 'package:aimedic/app/home/viewModel/home_view_model.dart';
import 'package:aimedic/app/profile/profile.dart';
import 'package:aimedic/core/widgets/home_page_widgets.dart/appBar.dart';
import 'package:aimedic/core/widgets/home_page_widgets.dart/drawer.dart';

class HomeView extends HomeViewModel {
  @override
  void initState() {
    super.initState();
  //  homeViewModel.fetchUserDevicesList();
  }

  //HomeService get homeViewModel => context.read<HomeService>();
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    DashBoard(),
    TitlePages(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
   // final homeViewModel = Provider.of<HomeService>(context);
    return Scaffold(
      drawer: AppDrawer(
        onSignUpTap: (){},
        onAboutUsTap: (){},
        onContactUsTap: (){},
      ),
      backgroundColor: AppColors.darkBG,
      appBar: AppBarWidget(
        title: 'title', context: context,
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                  onTap: () => _onItemTapped(0),
                  child: SvgPicture.asset(
                    _selectedIndex==0?'assets/images/Iconly-Bold-Category.svg':'assets/images/Category.svg',
                    height: 26,
                  )),
            ),

            Expanded(
              flex: 1,
              child: GestureDetector(
                  onTap: () => _onItemTapped(1),
                  child: SvgPicture.asset(
                    _selectedIndex==1?'assets/images/Iconly-Bold-Home.svg':'assets/images/Iconly-Light-outline-Home.svg',
                    height: 26,
                  )),
            ),

            Expanded(
              flex: 1,
              child: GestureDetector(
                  onTap: () => _onItemTapped(2),
                  child: SvgPicture.asset(
                    'assets/images/Iconly-Light-outline-Profile.svg',
                    height: 26,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

//  ListView.builder(
//               itemCount: homeViewModel.model1!.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   onTap: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => Detail(homeViewModel.model1?[index].cihaz_no)));
//                   },
//                   title: Text(
//                     homeViewModel.model1?[index].ad_soyad ?? "null",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 );
//               }),
