import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

Widget loginOneWidget(){
  return Container(
    width: Get.width,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/img/background.jpg'),
            fit: BoxFit.cover
        )
    ),
    height: Get.height*0.6,

    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Image.asset(
            'assets/img/logo_bip.png',
          width: 300,
          height: 250,
        ),



      ],
    )
  );
}
