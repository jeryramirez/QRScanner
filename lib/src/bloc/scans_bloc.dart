


import 'dart:async';

import 'package:qrapp/src/bloc/validators.dart';
import 'package:qrapp/src/providers/db_provider.dart';

class ScansBloc with Validators {


  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc(){

    return _singleton;

  }


  ScansBloc._internal(){
    return ;
  }
 
  final _scansController = StreamController<List<ScanModel>>.broadcast();


  Stream<List<ScanModel>> get scansStream     => _scansController.stream.transform(validateGeo);
  Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validateHttp);


  dispose(){


    _scansController?.close();


  }

  getScans() async{

    _scansController.sink.add( await DBProvider.db.getAllScans() );

  }

  addScan(ScanModel scan) async {
    await DBProvider.db.createScan(scan);
    getScans();
  }

  deleteScan(int id) async{

    await DBProvider.db.deleteScan(id);
    getScans();


  }

  deleteAllScan() async {
    await DBProvider.db.deleteAllScan();
    getScans();
  }



}