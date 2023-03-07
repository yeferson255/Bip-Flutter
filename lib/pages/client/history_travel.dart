import 'package:bip/pages/client/history_travel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'history_travel_controller.dart';

class ClientHistoryTravel extends StatefulWidget {
  const ClientHistoryTravel({Key? key}) : super(key: key);

  @override
  State<ClientHistoryTravel> createState() => _ClientHistoryTravelState();
}

class _ClientHistoryTravelState extends State<ClientHistoryTravel> {

  ClientHistoryController _con = new ClientHistoryController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) { 
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      appBar: AppBar(title: Text('Historial de viajes'),
        backgroundColor: Colors.blue.shade900,),
      body: ListView(
        children: [
          const SizedBox(
            height: 12,
          ),
          cardHistoryInfo(),
          const SizedBox(
            height: 12,
          ),
          cardHistoryInfo(),
          const SizedBox(
            height: 12,
          ),
          cardHistoryInfo(),
          const SizedBox(
            height: 12,
          ),
          cardHistoryInfo(),
          const SizedBox(
            height: 12,
          ),
          cardHistoryInfo(),
          const SizedBox(
            height: 12,
          ),
          cardHistoryInfo(),
          const SizedBox(
            height: 12,
          ),
          cardHistoryInfo(),
          const SizedBox(
            height: 12,
          ),
          cardHistoryInfo(),
          const SizedBox(
            height: 12,
          ),
          cardHistoryInfo(),
          const SizedBox(
            height: 12,
          ),
          cardHistoryInfo(),



        ],
      )
    );
  }

  Widget cardHistoryInfo(){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text('Fecha: ', style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          ),

          Row(
            children: [
              Text('Origen: ', style: TextStyle(fontWeight: FontWeight.bold),),
              Text('Campanario Centro Comercial, Campanario, Carrera 9, Comuna 1, Popayán, Cauca', style: TextStyle(fontWeight: FontWeight.normal),)
            ],
          ),

          Row(
            children: [
              Text('Destino: ', style: TextStyle(fontWeight: FontWeight.bold),),
              Text('Parque Caldas, Centro, Popayán, Cauca ', style: TextStyle(fontWeight: FontWeight.normal),),
            ],
          ),

          Row(
            children: [
              Text('Tarifa: ', style: TextStyle(fontWeight: FontWeight.bold),),
              Text('7000 ', style: TextStyle(fontWeight: FontWeight.normal),)
            ],
          ),

          Row(
            children: [
              Text('Comentarios: ', style: TextStyle(fontWeight: FontWeight.bold),),
              Text('', style: TextStyle(fontWeight: FontWeight.normal),)
            ],
          )
          
        ],
      ),
    );
  }


  void refresh(){
    setState(() {

    });
  }
}
