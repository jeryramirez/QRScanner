import 'package:flutter/material.dart';
import 'package:qrapp/src/bloc/scans_bloc.dart';
import 'package:qrapp/src/models/scan_model.dart';

import 'package:qrapp/src/utils/utils.dart' as utils ; 



class MapsPage extends StatelessWidget {

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {

    scansBloc.getScans();


    return StreamBuilder <List<ScanModel>>(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot){

        if (!snapshot.hasData){

          return Center(child: CircularProgressIndicator(),);

        }

        final scans = snapshot.data;

        if( scans.length == 0){
          return Center(
            child: Text('no info'),
          );
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(

            key: UniqueKey(),

            background: Container( color: Colors.red,),

            onDismissed: (direction ) => scansBloc.deleteScan(scans[i].id),

            child: ListTile(
              leading: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor,),
              title: Text( scans[i].valor),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () => utils.openScan(context, scans[i]),
            ),
          )
          
          
        );
      }
    );
  }
}