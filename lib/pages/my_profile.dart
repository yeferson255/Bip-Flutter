import 'dart:io';
import 'package:bip/controller/auth_controller.dart';
import 'package:bip/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:bip/pages/home.dart';
import '../pages/home.dart';


class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController identificacionController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthController authController = Get.find<AuthController>();

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  getImage(ImageSource source)async{
    final XFile? image = await _picker.pickImage(source: source);
    if(image != null){
      selectedImage = File(image.path);
      setState(() {});
    }
  }

  late LatLng homeAddress;
  late LatLng businessAddress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = authController.myUser.value.name??"";
    identificacionController.text = authController.myUser.value.identificacion??"";
    homeController.text = authController.myUser.value.hAddress??"";
    businessController.text = authController.myUser.value.bAddress??"";


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Get.height*0.4,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: (){
                        getImage(ImageSource.camera);
                      },
                      child: selectedImage == null
                          ? authController.myUser.value.image!=null?
                      Container(
                        width: 120,
                        height: 120,
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(authController.myUser.value.image!),
                            fit: BoxFit.fill),
                            shape: BoxShape.circle,
                            color: Colors.blueGrey
                        ),
                        child: Center(child: Icon(Icons.camera_alt_outlined,size: 40, color: Colors.white,),
                        ),
                      ): Container(
                        width: 120,
                        height: 120,
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blueGrey,
                        ),
                        child: Center(
                          child: Icon(
                          Icons.camera_alt_outlined,
                            size: 40,
                            color: Colors.white,
                            ),
                        ),
                      )
                          :Container(
                        width: 120,
                        height: 120,
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(selectedImage!),
                            fit: BoxFit.fill
                          ),
                          shape: BoxShape.circle,
                          color: Colors.blue.shade900),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFieldWidget(
                        'Nombre',Icons.person_outlined,nameController,(String? input){

                      if(input!.isEmpty){
                        return 'Por favor ingresa tu nombre';
                      }

                      if(input.length<3){
                        return 'Por favor ingrese un nombre valido';
                      }

                      if(input.length>10){
                        return 'Por favor ingrese un nombre valido';
                      }

                      return null;

                    }),

                    const SizedBox(
                      height: 10,
                    ),

                    TextFieldWidget('Identificación',Icons.person_outlined,identificacionController,(String? input){
                      if(input!.isEmpty){
                        return 'Por favor ingresa tu numero de identificación';
                      }

                      if(input.length<5){
                        return 'Por favor ingrese un numero de identificación valido';
                      }

                      if(input.length>12){
                        return 'Por favor ingrese un numero de identificación valido';
                      }

                      return null;

                    }),
                    const SizedBox(
                      height: 10,
                    ),

                    TextFieldWidget(
                      'Ingresa una dirección favorita', Icons.home_outlined, homeController,(String? input){

                        if(input!.isEmpty){
                          return 'Ingresa una dirección';
                        }
                        return null;
                    },
                      onTap: ()async{
                        Prediction? p = await  authController.showGoogleAutoComplete(context);
                        homeAddress = await authController.buildLatLngFromAddress(p!.description!);
                        homeController.text = p.description!;


                      },readOnly: true),
                      const SizedBox(
                        height: 10,
                      ),

                      TextFieldWidget('Business Address', Icons.card_travel,
                          businessController,(String? input){
                            if(input!.isEmpty){
                              return 'Se requiere una dirección';
                            }

                            return null;
                          },onTap: ()async{
                            Prediction? p = await  authController.showGoogleAutoComplete(context);

                            businessAddress = await authController.buildLatLngFromAddress(p!.description!);
                            businessController.text = p.description!;

                          },readOnly: true),

                      const SizedBox(
                        height: 30,
                      ),

                    Obx(() => authController.isProfileUploading.value
                        ? Center(

                          child: CircularProgressIndicator(),
                    )
                        :blueButton('Actualizar', (){

                      if(!formKey.currentState!.validate()){
                        return;
                      }

                      authController.isProfileUploading(true);
                      authController.storeUserInfo(
                          selectedImage!,
                          nameController.text,
                          homeController.text,
                          businessController.text,
                          identificacionController.text,
                          identificacionController.text,


                      );
                    })),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFieldWidget(
      String title,IconData iconData, TextEditingController controller,Function validator, {Function? onTap,bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.blueGrey),),
        const SizedBox(
          height: 6,
        ),
        Container(
          width: Get.width,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                )
              ],
              borderRadius: BorderRadius.circular(8)
          ),
          child:  TextFormField(
            readOnly: readOnly,
            onTap: ()=> onTap!(),
            validator: (input)=> validator(input),
            controller: controller,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade900
            ),
            decoration: InputDecoration (
              prefixIcon: Padding (
                padding: const EdgeInsets.only(left: 10),
                child: Icon(iconData,color: Colors.blue,),
              ),
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  Widget blueButton(String title, Function onPressed) {
    return MaterialButton(
      minWidth: Get.width,
      height: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      color: Colors.blue,
      onPressed: ()=>onPressed(),
      child: Text(title,style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
    );
  }


}

