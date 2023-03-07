import 'package:bip/controller/auth_controller.dart';
import 'package:bip/widgets/login_one_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets/verification_screen_widget.dart';

class VerificationScreen extends StatefulWidget {

  String phoneNumber;
  VerificationScreen(this.phoneNumber);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {

  AuthController authController = Get.find<AuthController>();

  @override
  void initState(){
    super.initState();
    authController.phoneAuth(widget.phoneNumber);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            Stack(
              children: [
                loginOneWidget(),

                Positioned(
                  top: 60,
                  left: 30,

                  child: InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                )

              ],
            ),

            SizedBox(
              height: 50,
            ),

            VerificationScreenWidget(),



          ],
        ),
      )


    );


  }
}
