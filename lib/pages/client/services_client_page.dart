import 'package:flutter/material.dart';


class clientServices extends StatefulWidget {
  const clientServices({Key? key}) : super(key: key);

  @override
  State<clientServices> createState() => _clientServicesState();
}

class _clientServicesState extends State<clientServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ListView.builder")),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                leading: const Icon(Icons.list),
                trailing: const Text(
                  "Conductor:"
                      "Vehiculo:"
                      "Placa:"
                      "Calificación:",
                  style: TextStyle(color: Colors.green, fontSize: 15),
                ),
                title: Text("List item $index"));
          }),
    );
  }
}
