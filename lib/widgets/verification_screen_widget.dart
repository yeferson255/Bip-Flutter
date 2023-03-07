import 'package:bip/pages/pages.login/verification_screen.dart';
import 'package:bip/utils/app_constants.dart';
import 'package:bip/widgets/pinput_widget.dart';
import 'package:bip/widgets/text_widget.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

Widget VerificationScreenWidget(){

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,),
    child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        textWidget(text: AppConstants.CodigoDeVerificacion,fontSize: 22,fontWeight: FontWeight.bold, color: Colors.black),

        const SizedBox(
          height: 15,
        ),

        Container(
            width: Get.width,
            height: 70,
            child: RoundWithShadow()),

        const SizedBox(
          height: 30,
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 12),
                  children: [
                    TextSpan(
                        text: AppConstants.ReenviarCodigo,
                        style: TextStyle(color: Colors.black,fontSize: 15)
                    )
                  ]
              )
          ),
        )
      ],
    ),
  );
}