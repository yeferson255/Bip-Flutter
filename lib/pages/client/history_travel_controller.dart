import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClientHistoryController {
  late Function refresh;
  late BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
  }

}