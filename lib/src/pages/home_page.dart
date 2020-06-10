import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:qrapp/src/bloc/scans_bloc.dart';
import 'package:qrapp/src/models/scan_model.dart';
import 'package:qrapp/src/pages/addresses_page.dart';
import 'package:qrapp/src/pages/maps_page.dart';

import 'package:qrapp/src/utils/utils.dart' as utils ; 



class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();

  int currentIndex = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon ( Icons.delete),
            onPressed: (){
              scansBloc.deleteAllScan();

            },
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _bottonNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.filter_center_focus),
        onPressed: () => _scanQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _bottonNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index){
        setState((){
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Maps')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.filter_none),
          title: Text('Pages')
        )
      ],

    );
  }

  Widget _callPage(int currentPage) {

    switch( currentPage ){
      case 0: return MapsPage();
      case 1: return AddressesPage();

      default: return MapsPage();
    }



  }

  _scanQR(BuildContext context) async{


    var result = await BarcodeScanner.scan();

    
    //'geo:40.724233047051705,-70.00731459101564'

    /* //https://fernando-herrera.com

    if(result.rawContent == ''){
      print('no info -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-');
    } else {
      print('*-*-*-*-*-*-* info: ${result.rawContent}');
    }*/

    if ( result != null ){



      final scan = ScanModel(valor: result.rawContent);

      scansBloc.addScan(scan);

      utils.openScan(context, scan);

    }
  }
}