import 'package:bip/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'package:google_maps_webservice/places.dart';
import '../controller/auth_controller.dart';
import '../controller/polyline_handler.dart';
import '../models/user_model/user_services.dart';
import 'client/config_client.dart';
import 'client/history_travel.dart';
import 'client/services_client_page.dart';
import 'my_profile.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;


class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  String? _mapStyle;

  AuthController authController = Get.find<AuthController>();

  late LatLng destination;
  late LatLng source;
  final Set<Polyline> _polyline={};
  Set<Marker> markers = Set<Marker>();

  List<String> list = <String>[
    '**** **** **** 1234'
    '**** **** **** 5678'
    '**** **** **** 9101'
  ];

  final GlobalKey<FormState> formulariokey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();

    authController.getUserInfo();

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });

  }

  String dropdownValue = '**** **** **** 1234';

  final _kGooglePlex = CameraPosition(
    target: LatLng(2.443435694367104, -76.60654998802208),
    zoom: 14.4746,
  );

  GoogleMapController? myMapController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        drawer: buildDrawer(),
        body: Stack(
          children: [
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              bottom: 80,
              child: GoogleMap(
                markers: markers,
                polylines: _polyline,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  myMapController = controller;
                  myMapController!.setMapStyle(_mapStyle);
                },
                initialCameraPosition:_kGooglePlex,
              ),
            ),

            Positioned(
             child: buildServicios(),
            ),


            ///buildProfileTitle(),
            ///buildTextRecogida(),
            ///buildTextDestino(),
            ///buildCurrentLocationIcon(),
            ///buildNotificationIcon(),
            ///buildBottomSheet(),

          ],
        ),
      ),
    );
  }

  Widget buildServicios(){

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: Get.width,
        height: 400,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 10,
              )
            ],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12))
        ),

          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child: Row(
                  children: [

                  Container(
                    margin: EdgeInsets.only(right: 8,left: 8,top: 8,bottom: 2),
                    height: 80,
                    width: 120,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blue.shade900.withOpacity(0.2),
                              offset: Offset(0, 5),
                              blurRadius: 5,
                              spreadRadius: 1)
                        ],
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white
                    ),

                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 15, top: 55, bottom: 0, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textWidget(
                                  text: 'Viaje',
                                  color: Colors.blue.shade900,
                                  fontWeight: FontWeight.w700),
                            ],
                          ),
                        ),
                        Positioned(
                            right: 25,
                            top: 10,
                            bottom: 10,
                            child: Image.asset('assets/img/miniatura_carro.png')),

                      ],
                    ),

                  ),

                    Container(
                      margin: EdgeInsets.only(right: 8,left: 8,top: 1,bottom: 2),
                      height: 80,
                      width: 120,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blue.shade900.withOpacity(0.2),
                                offset: Offset(0, 5),
                                blurRadius: 5,
                                spreadRadius: 1)
                          ],
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white
                      ),

                      child: Stack(

                        children: [

                          Container(

                            padding: EdgeInsets.only(left: 15, top: 55, bottom: 0, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textWidget(
                                    text: 'Interurbano',
                                    color: Colors.blue.shade900,
                                    fontWeight: FontWeight.w700),
                              ],
                            ),
                          ),
                          Positioned(
                              right: 35,
                              top: 10,
                              bottom: 20,
                              child: Image.asset('assets/img/miniatura_interurbano.png')),
                        ],

                      ),


                    ),

                    Container(
                      margin: EdgeInsets.only(right: 8,left: 8,top: 1,bottom: 2),
                      height: 80,
                      width: 120,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blue.shade900.withOpacity(0.2),
                                offset: Offset(0, 5),
                                blurRadius: 5,
                                spreadRadius: 1)
                          ],
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white
                      ),

                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 45, top: 55, bottom: 0, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textWidget(
                                    text: 'Flete',
                                    color: Colors.blue.shade900,
                                    fontWeight: FontWeight.w700),
                              ],
                            ),
                          ),
                          Positioned(
                              right: 25,
                              top: 10,
                              bottom: 20,
                              child: Image.asset('assets/img/miniatura_camion.png')),

                        ],
                      ),

                    ),

                    Container(
                      margin: EdgeInsets.only(right: 8,left: 8,top: 1,bottom: 2),
                      height: 80,
                      width: 120,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blue.shade900.withOpacity(0.2),
                                offset: Offset(0, 5),
                                blurRadius: 5,
                                spreadRadius: 1)
                          ],
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white
                      ),

                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 15, top: 55, bottom: 0, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textWidget(
                                    text: 'Entregas',
                                    color: Colors.blue.shade900,
                                    fontWeight: FontWeight.w700),
                              ],
                            ),
                          ),
                          Positioned(
                              right: 35,
                              top: 10,
                              bottom: 20,
                              child: Image.asset('assets/img/miniatura_servicios.png')),
                        ],
                      ),
                    ),
                ],
        ),
        ),
              const SizedBox(
                height: 12,
              ),

            Positioned(
              child: Container(
                width: Get.width,
                height: 45,
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 0,
                  )
                ],
                borderRadius: BorderRadius.circular(0)
            ),
                child: TextFormField(
                  controller: recogidaController,
                  validator: (String? dato){
                    if (dato!.isEmpty) {
                      return 'Este campo es requerido';
                    }
                  },
                  readOnly: true,
                  onTap: ()async{
                    Prediction? p = await authController.showGoogleAutoComplete(context);

                  String selectedPlace = p!.description!;

                  recogidaController.text = selectedPlace;

                  List<geoCoding.Location> locations = await geoCoding.locationFromAddress(selectedPlace);

                  source = LatLng(locations.first.latitude, locations.first.longitude);

                  markers.add(Marker(markerId: MarkerId(selectedPlace),infoWindow: InfoWindow(title: 'Source $selectedPlace',),position: source ));

                  myMapController!.animateCamera(
                      CameraUpdate.newCameraPosition(
                          CameraPosition(target: source, zoom: 14)
                      )
                      );
                    setState(() {
                      showSourceField = true;

                    });
                  },


                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffA7A7A7),
                  ),
                  decoration: InputDecoration(

                    hintText: 'Lugar de recogida',
                    hintStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.normal),

                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.circle_outlined,
                        color: Colors.blue.shade900,),
                    ),

                    border: InputBorder.none,
                  ),
                ),
              ),
            ),


              const SizedBox(
                height: 12,
              ),


          Positioned(
            child: Container(
              key: formulariokey,
              width: Get.width,
              height: 45,
              padding: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 0,
                    )
                  ],
                  borderRadius: BorderRadius.circular(0)
              ),
              child: TextFormField(
                controller: destinationController,

                readOnly: true,
                onTap: ()async{

                  Prediction? p = await authController.showGoogleAutoComplete(context);

                  String place = p!.description!;

                  destinationController.text = place;

                  List<geoCoding.Location> locations = await geoCoding.locationFromAddress(place);

                  destination = LatLng(locations.first.latitude, locations.first.longitude);

                  if(markers.length >=2){
                    markers.remove(markers.last);
                  }

                  markers.add(Marker(markerId: MarkerId(place),infoWindow: InfoWindow(title: 'Destination: $place',),position: destination));

                  drawPolyline(place);

                  myMapController!.animateCamera(
                      CameraUpdate.newCameraPosition(
                          CameraPosition(target: destination, zoom: 14.3)
                      )
                  );
                  setState(() {
                    showSourceField = true;

                  });
                },


              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xffA7A7A7),
              ),
              decoration: InputDecoration(

                hintText: 'Destino',
                hintStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.normal),

                suffixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.blue.shade900,),
                ),

                border: InputBorder.none,
              ),
            ),
          ),
        ),



              const SizedBox(
                height: 12,
              ),



            Positioned(
          child: Container(
            width: Get.width,
            height: 45,
            padding: EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 0,
                  )
                ],
                borderRadius: BorderRadius.circular(0)
            ),
            child: TextFormField(
              controller: tarifaController,
              validator: (String? dato){
                if (dato!.isEmpty) {
                  return 'Este campo es requerido';
                }
              },

              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Color(0xffA7A7A7),
              ),
              decoration: InputDecoration(

                hintText: 'Tarifa',
                hintStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.normal),

                suffixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.paid_outlined,
                    color: Colors.blue.shade900,),
                ),

                border: InputBorder.none,
              ),
            ),
          ),
        ),





              const SizedBox(
                height: 12,
              ),




             Positioned(
              child: Container(

                width: Get.width,
                height: 45,
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 0,
                  )
                ],
                borderRadius: BorderRadius.circular(0)
            ),
                child: TextFormField(
                  controller: comentarioController,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(0xffA7A7A7),
                  ),
                  decoration: InputDecoration(

                  hintText: 'Comentarios',
                  hintStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.normal),

                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.comment,
                      color: Colors.blue.shade900,),
                  ),
                    border: InputBorder.none,
                ),
              ),
              ),
          ),


              const SizedBox(
                height: 15,
              ),

              Obx(() => authController.isTravelUploading.value
                  ? Center(
                    child: CircularProgressIndicator(),
                  )
                  :blueButton('Enviar', (){

                authController.isTravelUploading(true);
                authController.storeTravel(recogidaController.text, destinationController.text,tarifaController.text,comentarioController.text);
              })),
            ],
          )
      ),
    );
  }


  Widget buildProfileTitle() {
    return Positioned(
      top: 60,
      left: 20,
      right: 20,
      child: Obx(()=>authController.myUser.value.name == null? Center(child: CircularProgressIndicator() ,)
          :Container(
            width: Get.width,
            child: Row(
              children: [

              Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: authController.myUser.value.image == null? DecorationImage(
                      image: AssetImage('assets/img/usuario.png'),
                      fit: BoxFit.fill
                  ): DecorationImage(
                      image: NetworkImage(authController.myUser.value.image!),
                      fit: BoxFit.fill
                  )
              ),
            ),
              const SizedBox(
                width: 15,
            ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                RichText(
                  text: TextSpan(
                      children: [

                        TextSpan(
                            text: 'Hola, ',
                            style: TextStyle(color: Colors.black, fontSize: 14)
                        ),

                        TextSpan(
                            text: 'En Bip llegamos por ti!',
                            style: TextStyle(color: Colors.blue.shade900,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)
                        ),
                      ]
                  ),
                ),
                Text("A donde vamos hoy?", style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),)

              ],
            )
          ],
        ),
      )),
    );
  }

  TextEditingController destinationController = TextEditingController();
  TextEditingController recogidaController = TextEditingController();
  TextEditingController tarifaController = TextEditingController();
  TextEditingController comentarioController = TextEditingController();

  bool showSourceField = false;

  Widget buildButtonS (){

    return ElevatedButton(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text('Solicitar servicio')),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
                height: 50,
                child: Icon(Icons.arrow_forward_ios_rounded)),
          ),

        ],
      ),
      onPressed: () async {

        if (formulariokey.currentState!.validate()) {
          bool respuesta = await UserServices().saveTravel(
            recogidaController.text,
            destinationController.text,
            tarifaController.text,
            comentarioController.text,
          );
        }
      },
    );
  }



  Widget buildComent(){
    return Positioned(
      child: Container(

        width: Get.width,
        height: 45,
        padding: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 0,
              )
            ],
            borderRadius: BorderRadius.circular(0)
        ),
        child: TextFormField(
          controller: comentarioController,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Color(0xffA7A7A7),
          ),
          decoration: InputDecoration(

            hintText: 'Comentarios',
            hintStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.normal),

            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.comment,
                color: Colors.blue.shade900,),
            ),

            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget buildTextDestino() {

    return Positioned(
      child: Container(
        key: formulariokey,
        width: Get.width,
        height: 45,
        padding: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 0,
              )
            ],
            borderRadius: BorderRadius.circular(0)
        ),
        child: TextFormField(
          controller: destinationController,
          validator: (String? dato){
            if (dato!.isEmpty) {
              return 'Este campo es requerido';
            }
          },
          readOnly: true,
          onTap: ()async{

            Prediction? p = await authController.showGoogleAutoComplete(context);

            String place = p!.description!;

            destinationController.text = place;

            List<geoCoding.Location> locations = await geoCoding.locationFromAddress(place);

            destination = LatLng(locations.first.latitude, locations.first.longitude);

            if(markers.length >=2){
              markers.remove(markers.last);
            }

            markers.add(Marker(markerId: MarkerId(place),infoWindow: InfoWindow(title: 'Destination: $place',),position: destination));

            drawPolyline(place);

            myMapController!.animateCamera(
                CameraUpdate.newCameraPosition(
                    CameraPosition(target: destination, zoom: 14.3)
                )
            );
            setState(() {
              showSourceField = true;

            });
          },


          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xffA7A7A7),
          ),
          decoration: InputDecoration(

            hintText: 'Destino',
            hintStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.normal),

            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.check_circle,
                color: Colors.blue.shade900,),
            ),

            border: InputBorder.none,
          ),
        ),
      ),
    );

  }


  Widget buildTextRecogida() {
    return Positioned(
      child: Container(
        width: Get.width,
        height: 45,
        padding: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 0,
              )
            ],
            borderRadius: BorderRadius.circular(0)
        ),
        child: TextFormField(
          controller: recogidaController,
          validator: (String? dato){
            if (dato!.isEmpty) {
              return 'Este campo es requerido';
            }
          },
          readOnly: true,
          onTap: ()async{
            Prediction? p = await authController.showGoogleAutoComplete(context);

            String selectedPlace = p!.description!;

            recogidaController.text = selectedPlace;

            List<geoCoding.Location> locations = await geoCoding.locationFromAddress(selectedPlace);

            source = LatLng(locations.first.latitude, locations.first.longitude);

            markers.add(Marker(markerId: MarkerId(selectedPlace),infoWindow: InfoWindow(title: 'Source $selectedPlace',),position: source ));

            myMapController!.animateCamera(
                CameraUpdate.newCameraPosition(
                    CameraPosition(target: source, zoom: 14)
                )
            );
            setState(() {
              showSourceField = true;

            });
          },


          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xffA7A7A7),
          ),
          decoration: InputDecoration(

            hintText: 'Lugar de recogida',
            hintStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.normal),

            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.circle_outlined,
                color: Colors.blue.shade900,),
            ),

            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget buildTextTarifa() {

    return Positioned(
      child: Container(
        width: Get.width,
        height: 45,
        padding: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 0,
              )
            ],
            borderRadius: BorderRadius.circular(0)
        ),
        child: TextFormField(
          controller: tarifaController,
          validator: (String? dato){
            if (dato!.isEmpty) {
              return 'Este campo es requerido';
            }
          },

          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Color(0xffA7A7A7),
          ),
          decoration: InputDecoration(

            hintText: 'Tarifa',
            hintStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.normal),

            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.paid_outlined,
                color: Colors.blue.shade900,),
            ),

            border: InputBorder.none,
          ),
        ),
      ),
    );
  }



  Widget buildCurrentLocationIcon() {
    return Align(


      alignment: Alignment.bottomRight,

      child: Padding(
        padding: const EdgeInsets.only(bottom: 620, right: 8),
        child: CircleAvatar(
          radius: 18,
          backgroundColor: Colors.white,
          child: Icon(Icons.my_location, color: Colors.blue.shade900,),
        ),

      ),
    );
  }

  Widget buildNotificationIcon() {
    return Align(

      alignment: Alignment.bottomLeft,

      child: Padding(
        padding: const EdgeInsets.only(bottom: 28, left: 8),
        child: CircleAvatar(
          radius: 18,
          backgroundColor: Colors.white,
          child: Icon(Icons.notifications, color: Colors.blue.shade900,),
        ),

      ),
    );
  }

  Widget buildBottomSheet() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: Get.width * 0.6,
        height: 25,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 4,
                blurRadius: 10,
              )
            ],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12), topLeft: Radius.circular(12))
        ),
        child: Center(
          child: Container(
            width: Get.width * 0.5,
            height: 3,
            color: Colors.blue.shade900,
          ),
        ),
      ),
    );
  }

  buildDrawerItem({required String title, required Function onPressed, Color color = Colors.black, double fontSize = 16,FontWeight fontWeight = FontWeight.w500,double height = 45}) {
    return SizedBox(
      height: height,
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        dense: true,
        onTap: ()=> onPressed(),
        title: Text(title, style: GoogleFonts.poppins(fontSize: fontSize,fontWeight: fontWeight,color: color),),
      ),
    );
  }

  buildDrawer(){
    return Drawer(
      child: Column(
        children: [
          InkWell(
            onTap: (){
              Get.to(()=> const MyProfile());
            },
            child: SizedBox(
              height: 150,

              child: DrawerHeader(

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: authController.myUser.value.image == null? DecorationImage(
                              image: AssetImage('assets/img/logo_app.png'),
                              fit: BoxFit.fill)
                          : DecorationImage(
                              image: NetworkImage(authController.myUser.value.image!),
                              fit: BoxFit.fill
                      )
                    ),
                  ),

                  SizedBox(width: 10,),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hola',
                        style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.50),fontSize: 15),
                        ),
                        Text(authController.myUser.value.name == null? "":authController.myUser.value.name!,
                        style:  GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  )

                ],
              ),

            ),
          ),
          ),

          const SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [

                  buildDrawerItem(title: 'Historial de viajes', onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ClientHistoryTravel()));
                  }),

                  buildDrawerItem(title: 'Configuración', onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ConfigClient()));
                  }),

                  buildDrawerItem(title: 'Soporte', onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const clientServices()));
                  }),

                  buildDrawerItem(title: 'Cerrar sesión', onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ClientHistoryTravel()));
                  }),

                ],
              ),
            )
        ],
      )

    );
  }

  void drawPolyline(String placeId){
    _polyline.clear();
    _polyline.add(Polyline(
      polylineId: PolylineId(placeId),
      visible: true,
      points: [source,destination],
      color: Colors.blue.shade900,
      width: 5
    ));
  }

  int selectedRide = 0;

  buildDriverList(){
    return Container(
      height: 90,
      width: Get.width,
      child: StatefulBuilder(builder: (context, set) {
        return ListView.builder(
          itemBuilder: (ctx, i) {
            return  InkWell(
              onTap: (){
                set((){
                  selectedRide = i;
                });
              },
              child: buildDriverCard(selectedRide == i),
            );
          },
          itemCount: 1,
          scrollDirection: Axis.horizontal,
        );
      }),
    );
  }

  buildDriverCard(bool selected){
    return Container(
      margin: EdgeInsets.only(right: 8,left: 8,top: 1,bottom: 2),
      height: 85,
      width: 165,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: selected
                ? Colors.blue.shade900.withOpacity(0.2)
                : Colors.grey.withOpacity(0.2),
            offset: Offset(0, 5),
            blurRadius: 5,
            spreadRadius: 1)
        ],
        borderRadius: BorderRadius.circular(12),
        color: selected ? Colors.blue.shade900 : Colors.grey),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textWidget(
                    text: 'Precio recomendado:',
                color: Colors.white,
                fontWeight: FontWeight.w700),

                textWidget(
                    text: '5.500',
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
                textWidget(
                    text: '5 min.',
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.normal,
                    fontSize: 12),
              ],
            ),
          ),
          Positioned(
            right: -1,
            top: 17,
            bottom: 0,
            child: Image.asset('assets/img/carro.png')),

        ],
      ),

    );

  }


  buildRideConfirmationSheet(){
    Get.bottomSheet(
        Container(
          width: Get.width,
          height: Get.height*0.8,
          padding: EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
          color: Colors.white,
           borderRadius: BorderRadius.only(
            topRight: Radius.circular(12), topLeft: Radius.circular(12)),
          ),
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child:
                Container(
                  width: Get.width*0.2,
                  height: 8,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.grey,
                  ),
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            textWidget(
              text: 'En Bip llegamos por ti! ',
              fontSize: 16,
              fontWeight: FontWeight.bold, color: Colors.blue.shade900),
            const SizedBox(
              height: 12,
            ),
            textWidget(
              text: 'Origen:',
              fontSize: 12,
              fontWeight: FontWeight.normal,color: Colors.black,
            ),
            const SizedBox(
              height: 10,
            ),

            buildTextRecogida(),

            const SizedBox(
              height: 12,
            ),

            textWidget(
              text: 'Destino:',
              fontSize: 12,
              fontWeight: FontWeight.normal,color: Colors.black,
            ),

            const SizedBox(
              height: 10,
            ),

            buildTextDestino(),

            const SizedBox(
              height: 10,
            ),

            textWidget(
                text: 'Ofrezca su tarifa:',
                fontSize: 12,
                fontWeight: FontWeight.normal, color: Colors.black
            ),
              const SizedBox(
                height: 10,
              ),

              buildTextTarifa(),

              const SizedBox(
                height: 15,
              ),

              textWidget(
                  text: 'Comentarios:',
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),

              Container(
                child: Container(
                  width: Get.width,
                  height: 45,
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 6,
                          blurRadius: 10,
                        )
                      ],
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: TextFormField(

                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffA7A7A7),
                    ),
                    decoration: InputDecoration(

                      hintText: 'Comentarios',
                      hintStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal),

                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.feed_outlined,
                          color: Colors.blue.shade900,),
                      ),

                      border: InputBorder.none,
                    ),
                  ),
                ),

              ),

            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Divider(),
              ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: buildPaymentCardWidget()),
                  MaterialButton(
                      onPressed: () {},
                      child: textWidget(
                        text: 'Solicitar auto',
                        color: Colors.white,
                      ),
                        color: Colors.blue.shade900,
                        shape: StadiumBorder(),
                        ),
                      ],
                  ),
                )
              ],
      ),
    ));
  }

  buildPaymentCardWidget(){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/tarjeta.png',
            width: 40,
          ),
          SizedBox(
            width: 10,
          ),
          Image.asset(
            'assets/img/efectivo.png',
            width: 40,
          ),
          SizedBox(
            width: 10,
          ),

        ],
      ),
    );
  }

  buildServicioInterurbano(){

      Get.bottomSheet(
          Container(
            width: Get.width,
            height: Get.height*1,
            padding: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
            color: Colors.white,
              borderRadius: BorderRadius.only(
              topRight: Radius.circular(12), topLeft: Radius.circular(12)),
          ),
            child: ListView(
              children: [
                const SizedBox(
                 height: 10,
                ),
              Center(
                child: Container(
                width: Get.width*0.2,
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.grey,
                ),
              ),
            ),
              const SizedBox(
                height: 20,
              ),
              textWidget(
                text: 'Completa la información: ',
                fontSize: 18,
                fontWeight: FontWeight.bold, color: Colors.black
              ),

              const SizedBox(
                height: 8,
              ),

              textWidget(
                text: 'Origen:',
                fontSize: 12,
                fontWeight: FontWeight.normal, color: Colors.black
              ),

              const SizedBox(
                height: 8,
              ),

              buildTextRecogida(),

              const SizedBox(
                height: 8,
              ),

              textWidget(
                text: 'Destino:',
                fontSize: 12,
                fontWeight: FontWeight.normal, color: Colors.black
              ),

              const SizedBox(
                height: 8,
              ),

              buildTextDestino(),

              const SizedBox(
                height: 20,
              ),

              textWidget(
                text: 'Numero de pasajeros: ',
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.black),

              Container(
                child: Container(
                width: Get.width,
                height: 45,
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 6,
                        blurRadius: 10,
                      )
                    ],
                    borderRadius: BorderRadius.circular(8)
                ),
                  child: TextFormField(

                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffA7A7A7),
                    ),
                    decoration: InputDecoration(

                    hintText: 'Numero de pasajeros',
                    hintStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal),

                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.people_alt_outlined,
                        color: Colors.blue.shade900,),
                      ),

                    border: InputBorder.none,
                  ),
                ),
              ),

              ),


              const SizedBox(
              height: 15,

              ),textWidget(
                text: 'Fecha de salida: ',
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.black),

              Container(
               child: Container(
                width: Get.width,
                height: 45,
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 6,
                        blurRadius: 10,
                      )
                    ],
                    borderRadius: BorderRadius.circular(8)
                ),
                child: TextFormField(

                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffA7A7A7),
                  ),
                  decoration: InputDecoration(

                    hintText: 'Fecha',
                    hintStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal),

                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.calendar_month,
                        color: Colors.blue.shade900,),
                    ),

                    border: InputBorder.none,
                  ),
                ),
              ),

            ),


              const SizedBox(
              height: 15,
              ),

              textWidget(
                text: 'Hora de salida:',
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.black),

              Container(
                child: Container(
                  width: Get.width,
                  height: 45,
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 6,
                        blurRadius: 10,
                      )
                    ],
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: TextFormField(

                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffA7A7A7),
                    ),
                    decoration: InputDecoration(

                    hintText: 'Hora de salida',
                    hintStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal),

                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.schedule,
                        color: Colors.blue.shade900,),
                    ),

                    border: InputBorder.none,
                  ),
                ),
              ),

            ),

            const SizedBox(
              height: 15,
            ),

            textWidget(
                text: 'Comentarios:',
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.black),

            Container(
              child: Container(
                width: Get.width,
                height: 45,
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 6,
                        blurRadius: 10,
                      )
                    ],
                    borderRadius: BorderRadius.circular(8)
                ),
                child: TextFormField(

                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffA7A7A7),
                  ),
                  decoration: InputDecoration(

                    hintText: 'Comentarios/ describe tu equipaje',
                    hintStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal),

                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.feed_outlined,
                        color: Colors.blue.shade900,),
                    ),

                    border: InputBorder.none,
                  ),
                ),
              ),

            ),

              const SizedBox(
              height: 15,
            ),

              textWidget(
                text: 'Ofrece tu tarifa:',
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.black),

              Container(
                child: Container(
                  width: Get.width,
                  height: 45,
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 6,
                        blurRadius: 10,
                      )
                    ],
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: TextFormField(

                    style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffA7A7A7),
                   ),
                    decoration: InputDecoration(

                      hintText: 'Tarifa',
                      hintStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal),

                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.paid_outlined,
                        color: Colors.blue.shade900,),
                    ),


                    border: InputBorder.none,
                  ),
                ),
              ),

            ),

            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: buildPaymentCardWidget()),
                  MaterialButton(
                    onPressed: () {},
                    child: textWidget(
                      text: 'Confirmar viaje',
                      color: Colors.white,
                    ),
                    color: Colors.blue.shade900,
                    shape: StadiumBorder(),
                  ),
                ],
              ),
            )
          ],
        ),
      ));
    }


  buildServicioFlete(){
    Get.bottomSheet(
        Container(
          width: Get.width,
          height: Get.height*1,
          padding: EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12), topLeft: Radius.circular(12)),
          ),
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  width: Get.width*0.2,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: Colors.grey,
                  ),
                ),
              ),
              textWidget(
                  text: 'Servicio de Flete',
                  fontSize: 18,
                  fontWeight: FontWeight.bold, color: Colors.blue.shade900),

              const SizedBox(
                height: 20,
              ),
              textWidget(
                  text: 'Completa la información: ',
                  fontSize: 16,
                  fontWeight: FontWeight.bold, color: Colors.black
              ),

              const SizedBox(
                height: 8,
              ),

              textWidget(
                  text: 'Lugar de recogida:',
                  fontSize: 12,
                  fontWeight: FontWeight.normal, color: Colors.black
              ),

              const SizedBox(
                height: 8,
              ),

              buildTextRecogida(),

              const SizedBox(
                height: 8,
              ),

              textWidget(
                  text: 'Destino:',
                  fontSize: 12,
                  fontWeight: FontWeight.normal, color: Colors.black
              ),

              const SizedBox(
                height: 8,
              ),

              buildTextDestino(),

              const SizedBox(
                height: 20,
              ),

              textWidget(
                  text: 'Fecha de recogida: ',
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),

              Container(
                child: Container(
                  width: Get.width,
                  height: 45,
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 6,
                          blurRadius: 10,
                        )
                      ],
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: TextFormField(

                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffA7A7A7),
                    ),
                    decoration: InputDecoration(

                      hintText: 'Fecha',
                      hintStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal),

                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.calendar_month,
                          color: Colors.blue.shade900,),
                      ),

                      border: InputBorder.none,
                    ),
                  ),
                ),

              ),


              const SizedBox(
                height: 15,
              ),

              textWidget(
                  text: 'Hora de recogida:',
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),

              Container(
                child: Container(
                  width: Get.width,
                  height: 45,
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 6,
                          blurRadius: 10,
                        )
                      ],
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: TextFormField(

                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffA7A7A7),
                    ),
                    decoration: InputDecoration(

                      hintText: 'Hora de salida',
                      hintStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal),

                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.schedule,
                          color: Colors.blue.shade900,),
                      ),

                      border: InputBorder.none,
                    ),
                  ),
                ),

              ),

              const SizedBox(
                height: 15,
              ),

              textWidget(
                  text: 'Descripción del flete:',
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),

              Container(
                child: Container(
                  width: Get.width,
                  height: 45,
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 6,
                          blurRadius: 10,
                        )
                      ],
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: TextFormField(

                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffA7A7A7),
                    ),
                    decoration: InputDecoration(

                      hintText: 'Describe los que transportaremos',
                      hintStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal),

                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.feed_outlined,
                          color: Colors.blue.shade900,),
                      ),

                      border: InputBorder.none,
                    ),
                  ),
                ),

              ),

              const SizedBox(
                height: 15,
              ),

              textWidget(
                  text: 'Ofrece tu tarifa:',
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),

              Container(
                child: Container(
                  width: Get.width,
                  height: 45,
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 6,
                          blurRadius: 10,
                        )
                      ],
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: TextFormField(

                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffA7A7A7),
                    ),
                    decoration: InputDecoration(

                      hintText: 'Tarifa',
                      hintStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal),

                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.paid_outlined,
                          color: Colors.blue.shade900,),
                      ),

                      border: InputBorder.none,
                    ),
                  ),
                ),

              ),

              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: buildPaymentCardWidget()),
                    MaterialButton(
                      onPressed: () {},
                      child: textWidget(
                        text: 'Confirmar viaje',
                        color: Colors.white,
                      ),
                      color: Colors.blue.shade900,
                      shape: StadiumBorder(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }



  Widget blueButton(String title, Function onPressed) {
    return MaterialButton(
      minWidth: Get.width,
      height: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      color: Colors.blue,
      onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const clientServices()));
          bool respuesta = await UserServices().saveTravel(
            recogidaController.text,
            destinationController.text,
            tarifaController.text,
            comentarioController.text,

          );

      },
      child: Text(title,style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
    );
  }



}


///DropdownButton<String>(
//
//               value: dropdownValue,
//               icon: const Icon(Icons.keyboard_arrow_down),
//               elevation: 16,
//               style: const TextStyle(color: Colors.deepPurple),
//               underline: Container(),
//               onChanged: (String? value) {
//
//                 setState(() {
//                   dropdownValue = value!;
//                 });
//               },
//
//               items: list.map<DropdownMenuItem<String>>((String value){
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: textWidget(text: value, color: Colors.black),
//                 );
//               }).toList(),
//           )







