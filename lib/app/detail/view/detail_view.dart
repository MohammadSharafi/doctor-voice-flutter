import 'package:flutter/material.dart';
import 'package:aimedic/app/detail/viewModel/detail_view_model.dart';

class DetailView extends DetailViewModel {
  @override
  void initState() {
    super.initState();
    fetchUserDevicesListLog();
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          //  Text(widget.cihaz_no.toString())
            
          ],
        ),
      ),
    );
  }
}
