
import 'package:flutter/material.dart';
import 'package:qrapp/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

openScan(BuildContext context, ScanModel scan) async {
  
  
  if (scan.tipo == 'http'){

    if (await canLaunch(scan.valor)) {
      await launch(scan.valor);
    } else {
      throw 'Could not launch ${scan.valor}';
    }
  } else {

    Navigator.pushNamed(context, 'map', arguments: scan);


  }


}