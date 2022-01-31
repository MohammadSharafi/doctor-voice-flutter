import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aimedic/app/home/home.dart';
import 'package:aimedic/app/login/viewModel/login_view_model.dart';
import 'package:aimedic/core/widgets/login_background.dart';
import 'package:aimedic/core/widgets/rounded_button.dart';
import 'package:aimedic/core/widgets/rounded_input.dart';

import '../login.dart';

class LoginView extends LoginViewModel {
  final EdgeInsets paddingLow = EdgeInsets.all(8.0);

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController controllerPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Background(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 65,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/dv.png',
                        height: 60,
                        width: 60,
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Login to Doctor Voice",
                      style: GoogleFonts.yantramanav(
                        textStyle: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Neuro-Linguistic Programming",
                      style: GoogleFonts.yantramanav(
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white54,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 54,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Enter your mobile number",
                      style: GoogleFonts.yantramanav(
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.8),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  RoundedInputField(
                    onChanged: (String value) {
                      if (value.length == 11 &&
                          value.substring(0, 2).contains('09')) {}
                    },
                    controller: controllerPhone,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RoundedButton(
                    text: "Login",
                    press: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        fetchUserLogin(
                            controllerPhone.text,' controllerPassword.text');
                      }
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
