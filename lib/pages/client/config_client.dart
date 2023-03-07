import 'package:flutter/material.dart';

class ConfigClient extends StatefulWidget {
  const ConfigClient({Key? key}) : super(key: key);

  @override
  State<ConfigClient> createState() => _ConfigClientState();
}

class _ConfigClientState extends State<ConfigClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuraciones'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Container(

      ),


    );
  }
}

Widget changePhone(){
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
            Text('Cambiar el número de teléfono')
          ],
        )
      ],
    ),
  );
}
