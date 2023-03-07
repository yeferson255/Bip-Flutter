import 'package:bip/utils/app_constants.dart';
import 'package:bip/widgets/text_widget.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget loginWidget(CountryCode countryCode,Function onCountryChange,Function onSubmit){

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textWidget(text: AppConstants.HolaEnBipLlegamosPorTi, color: Colors.black),
            textWidget(text: AppConstants.IngresaTuNumeroTelefonico,fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black),

            const SizedBox(
              height: 30,
            ),

            Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 2,
                    )
                ],
                borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: ()=> onCountryChange(),
                      child: Container(
                        child: Row(
                          children: [

                            const SizedBox(width: 5,),

                            Expanded(
                                child: Container(
                                  child: countryCode.flagImage(),
                                ),
                            ),

                            textWidget(text: '+57', color: Colors.black),
                            const SizedBox(width: 10,),
                            Icon(Icons.keyboard_arrow_down_rounded)
                          ],
                        )
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 55,
                    color: Colors.black.withOpacity(0.2),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(

                        onSubmitted: (String? input)=> onSubmit(input),

                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.normal),
                          hintText: AppConstants.NumeroTelefonico,
                          border: InputBorder.none
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: AppConstants.TerminosYCondiciones,
                      style: TextStyle(color: Colors.black,fontSize: 10)
                    )
                    ]
                )
              ),
            )
          ],
        ),
  );
}