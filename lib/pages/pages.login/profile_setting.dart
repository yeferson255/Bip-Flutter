import 'dart:io';
import 'package:bip/controller/auth_controller.dart';
import 'package:bip/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;



class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController identificacionController = TextEditingController();
  TextEditingController shopController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  AuthController authController = Get.find<AuthController>();

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  getImage(ImageSource source)async{
    final XFile? image = await _picker.pickImage(source: source);
    if(image!= null){
      selectedImage = File(image.path);
      setState(() {

      });

    }

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
                      child: selectedImage == null? Container(
                        width: 120,
                        height: 120,
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
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
                            image: DecorationImage(
                              image: FileImage(selectedImage!)
                            ),
                              shape: BoxShape.circle,
                              color: Colors.blueGrey
                          ),

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
                    TextFieldWidget('Nombre',Icons.person_outlined,nameController,(String? input){
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

                    TextFieldWidget('Apellido',Icons.person_outline,apellidoController,(String? input){
                      if(input!.isEmpty){
                        return 'Por favor ingresa tu apellido';
                      }

                      if(input.length<3){
                        return 'Por favor ingrese un apellido valido';
                      }

                      if(input.length>10){
                        return 'Por favor ingrese un apellido valido';
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
                    Obx(() => authController.isProfileUploading.value
                        ? Center(child: CircularProgressIndicator(),
                    )
                        :blueButton('Enviar', (){

                          if(!formKey.currentState!.validate()){
                            return;
                          }

                      if(selectedImage == null){
                        Get.snackbar('Error', 'Por favor selecciona una imagen');
                        return;

                      }
                      authController.isProfileUploading(true);
                      authController.storeUserInfo(selectedImage!, nameController.text, apellidoController.text,identificacionController.text,shopController.text,identificacionController.text);
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

  TextFieldWidget(String title,IconData iconData, TextEditingController controller,Function validator) {
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
            validator: (input)=> validator(input),
            controller: controller,

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
