import 'package:flutter/material.dart';

import '../../widgets/text_widget.dart';


class ListDriverAvailable extends StatefulWidget {
  const ListDriverAvailable({Key? key}) : super(key: key);

  @override
  State<ListDriverAvailable> createState() => _ListDriverAvailableState();
}

class _ListDriverAvailableState extends State<ListDriverAvailable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

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
    );

  }
}
