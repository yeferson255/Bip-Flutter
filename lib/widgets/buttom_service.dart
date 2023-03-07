import 'package:flutter/material.dart';

class ButtomService extends StatelessWidget {
  const ButtomService({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

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
      },
    );
  }

}
