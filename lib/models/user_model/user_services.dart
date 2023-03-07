import 'package:firebase_database/firebase_database.dart';


class UserServices {

  Future<bool> saveTravel(String recogida, String destination, String tarifa,
      String comentario) async{
    try {
      await FirebaseDatabase.instance
          .ref()
          .child('travel')
          .push()
          .set(
          {
            'origen': recogida,
            'destino': destination,
            'tarifa': tarifa,
            'comentarios': comentario,


          });
      return true;
    } catch (e){
      print(e);
      return false;
    }
  }

}