

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrapp/src/models/scan_model.dart';

class MapPage extends StatelessWidget {

  final MapController map = new MapController();

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;


    return Scaffold(
      appBar: AppBar(
        title: Text('Location QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){
              map.move(scan.getLatLng(), 15);
            },
          )
        ],
      ),
      body: _createMap(scan),
    );
  }

  Widget _createMap(ScanModel scan) {

    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 10,

      ),
      layers: [
        _createLayer(),
        _createMarkes(scan)
      ],
    );



  }

  _createLayer() {

    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/styles/v1/'
      '{id}/{z}/{x}/{y}@2x?access_token={accessToken}',
      additionalOptions: {

        'accessToken': 'pk.eyJ1Ijoib3NoaW5kZXZlbG9wZXIxMiIsImEiOiJja2I4YmUzbmMwMmphMnhyc2hqNXJsZ3Z1In0.QVRpItwzVs3rSSZagOTqAQ',
        'id': 'mapbox/streets-v11/tiles',
      }

      //https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/1/1/0?access_token=pk.eyJ1Ijoib3NoaW5kZXZlbG9wZXIxMiIsImEiOiJja2I4YmM5dGgwMmoyMnRudmJ4ejhxaTRhIn0._vLJ3DtQn2S3li8EK4jPmQ


      //https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/10/302/383?access_token=pk.eyJ1Ijoib3NoaW5kZXZlbG9wZXIxMiIsImEiOiJja2I4YmUzbmMwMmphMnhyc2hqNXJsZ3Z1In0.QVRpItwzVs3rSSZagOTqAQ


    );


  }

  _createMarkes(ScanModel scan) {


    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 120.0,
          height: 120.0,
          point: scan.getLatLng(),
          builder: (context) => Container(
            child: Icon( Icons.location_on, size: 70.0, color: Theme.of(context).primaryColor,),
          )
        )
      ]
    );

  }
}