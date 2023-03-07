import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserModel {

  String? name;
  String? identificacion;
  String? image;
  String? hAddress;
  String? bAddress;



  UserModel({this.name,this.identificacion,this.image});

  UserModel.fromJson(Map<String,dynamic> json){
    bAddress = json['business_address'];
    hAddress = json['home_address'];
    name = json['name'];
    identificacion = json['identificacion'];
    image = json['image'];

  }

}