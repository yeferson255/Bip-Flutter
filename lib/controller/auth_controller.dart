import 'dart:developer';
import 'dart:io';
import 'package:bip/pages/pages.login/profile_setting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;
import '../models/user_model/user_model.dart';
import '../pages/home.dart';
import 'package:path/path.dart' as Path;

class AuthController extends GetxController{

  String userUid = '';
  var verId = '';
  int? resendTokenId;
  bool phoneAuthCheck = false;
  dynamic credentials;

  var isProfileUploading = false.obs;
  var isTravelUploading = false.obs;

  phoneAuth(String phone) async {
    try {
      credentials = null;
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          log('Completed');
          credentials = credential;
          await FirebaseAuth.instance
              .signInWithCredential(credential);
        },
        forceResendingToken: resendTokenId,
        verificationFailed: (FirebaseAuthException e) {
          log('Failed');
          if (e.code == 'invalid-phone-number') {
            debugPrint('El numero telefonico no es valido');
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          log('Code sent');
          verId = verificationId;
          resendTokenId = resendToken;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      log("Error occured $e");
    }
  }

  verifyOtp(String otpNumber) async {
    log("Called");
    PhoneAuthCredential credential =
    PhoneAuthProvider.credential(
        verificationId: verId,
        smsCode: otpNumber);

    log("LogedIn");

    await FirebaseAuth.instance
        .signInWithCredential(credential).then((value) {
          decideRoute();
    });
  }

  decideRoute(){

    User? user = FirebaseAuth.instance.currentUser;

    if(user != null){

      FirebaseFirestore.instance.collection('users').doc(user.uid).get()
          .then((value) {
            if(value.exists){
              Get.to(()=> HomeScreen());
            }else {
              Get.to(()=> ProfileSettingScreen());

            }
      }
      );
    }
  }

  uploadImage(File image)async {

    String imageUrl = '';
    String fileName = Path.basename(image.path);
    var reference = FirebaseStorage.instance
        .ref()
        .child('users/$fileName');
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then(
          (value) {
        imageUrl = value;
        print("Download Url: $value");
      },
    );

    return imageUrl;
  }

  storeUserInfo(
      File selectedImage,
      String name,
      String home,
      String apellido,
      String business,
      String identificacion, {

        String url = '',

      })async{
      String url_new = url;
        if (selectedImage != null) {
      url_new = await uploadImage(selectedImage);
    }
      String uid = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance.collection('users').doc(uid).set({
        'image': url_new,
        'name': name,
        'identificacion': identificacion,
        'apellido': apellido,
        'home_address': home,
        'business_address': business,

          }).then((value) {
            isProfileUploading(false);
            Get.to(()=> HomeScreen());
          });

  }

  storeTravel(
      String recogida,
      String destination,
      String tarifa,
      String comentario,
       )async{

    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('travel').doc(uid).set({

      'origen': recogida,
      'destino': destination,
      'tarifa': tarifa,
      'comentario': comentario,

    }).then((value) {
      isTravelUploading(false);
      Get.to(()=> HomeScreen());
    });

  }


  var myUser = UserModel().obs;

  getUserInfo(){
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).snapshots().listen((event) {
      myUser.value = UserModel.fromJson(event.data()!);

    });
  }

  Future<Prediction?> showGoogleAutoComplete(BuildContext context)async{
    const kGoogleApiKey = "AIzaSyAcQXfRyeakBm9jip06h1obUD39nP_pMtk";

    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      offset: 0,
      radius: 10000,
      strictbounds: false,
      region: "co",
      language: "es",
      mode: Mode.fullscreen,
      apiKey: kGoogleApiKey,
      components: [Component(Component.country, "co")],
      types: [],
      hint: "Buscar",
    );

    return p;
  }

  Future<LatLng> buildLatLngFromAddress(String place) async {
    List<geoCoding.Location> locations =
        await geoCoding.locationFromAddress(place);
    return LatLng(locations.first.latitude, locations.first.longitude);
  }


}