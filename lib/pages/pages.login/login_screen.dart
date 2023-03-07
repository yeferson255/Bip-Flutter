import 'package:bip/pages/pages.login/verification_screen.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/login_one_widget.dart';
import '../../widgets/login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final countryPicker = const  FlCountryCodePicker();
  CountryCode countryCode = CountryCode(name: 'Colombia', code: "CO", dialCode: "+57");

  onSubmit(String? input){
    Get.to(()=>VerificationScreen(countryCode.dialCode+input!));


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,

        child: SingleChildScrollView(
          child: Column(
            children: [

              loginOneWidget(),

              const SizedBox(height: 50,),

              loginWidget(countryCode,()async{
                final code = await countryPicker.showPicker(context: context);
                if (code != null) countryCode = code;
                setState(() {

                });
              }, onSubmit
              ),

            ],
          ),
        ),
      ),
    );
  }
}