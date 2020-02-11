import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'mapsIntent.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String lat = "";
  String long = "";
  double long_admin = 72.835792;
  double lat_admin = 19.1231508;
  String approval = "Not Approved";

  double _distance;
  Position position;
  final Distance distance = new Distance();

  String address = "";
  String url;

  Map<String, double> userLocation;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to sample',
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text("Location"),
            actions: <Widget>[
              new IconButton(icon: new Icon(Icons.home), onPressed: null),
              new IconButton(
                  icon: new Icon(Icons.exit_to_app), onPressed: null),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "$address",
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "$lat  $long",
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "$approval",
                          textAlign: TextAlign.center,
                        ),
                        RaisedButton(
                          onPressed: () {
                            _getLocation();
                          },
                          color: Colors.blue,
                          child: Text(
                            "Get Location",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () async {
                            MapUtils.openMap(lat, long);
                          },
                        ),
                      ],
                    )),
              ],
            ),
          )),
    );
  }

  _getLocation() async {
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    _distance = distance.as(LengthUnit.Meter, new LatLng(position.latitude, position.longitude), new LatLng(lat_admin, long_admin));
    setState(() {
      lat = position.latitude.toString();
      long = position.longitude.toString();
      address = first.addressLine;
      if(_distance < 25)
      {
        approval = "Approved";
      } else {
        approval = "Not Approved";
      }
    });
  }
}
