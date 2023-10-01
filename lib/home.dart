import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_parking/location_bar.dart';
import 'package:smart_parking/home_menu.dart';
import 'package:smart_parking/screens/current_location.dart';
import 'package:smart_parking/screens/nearby_location.dart';
import 'package:smart_parking/screens/search_location.dart';
import 'package:smart_parking/screens/polyline_location.dart';

class HomePage extends StatefulWidget {
  const HomePage ({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Map<String, Marker> _markers = <String, Marker>{};
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
          constraints: const BoxConstraints.expand(),
          color: Colors.white,
          child: Stack(
            children: <Widget>[

              //Create goolge map
              GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(35.011665, 135.768326),
                    zoom: 13,
                  )),

              Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  child: Column(
                    children: <Widget>[
                      AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        title: const Text("PARKING APP",
                            style: TextStyle(color: Colors.black)),
                        leading: TextButton(
                            onPressed: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            child: Image.asset("assets/ic_menu.png")),
                        //actions: <Widget>[Image.asset("")],
                      ),

                      ElevatedButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                          return const NearByPlacesScreen() ;
                        }));
                      }, child: const Text("Nearby location")),

                      ElevatedButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                          return const PolylineScreen() ;
                        }));
                      }, child: const Text("Next location")),

                      const Padding(
                        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: LocationBar(),
                      )
                    ],
                  ))

            ],
          )),
      drawer: const Drawer(child: HomeMenu()),
    );
  }

  // void onPlaceSelected(PlaceItemRes place, bool fromAddress) {
  //   var mkId = fromAddress ? "from_address" : "to_address";
  //   _addMarker(mkId, place);
  // }

  // void _addMarker(String mkId, PlaceItemRes place) async {
  //   _markers.remove(mkId);
  //   _mapController.clearMarkers();
  //
  //   _markers[mkId] = Marker(
  //       mkId,
  //       MarkerOptions(
  //           position: LatLng(place.lat, place.lng),
  //           infoWindowText: InfoWindowText(place.name, place.address)));
  //
  //   for (var m in _markers.values) {
  //     await _mapController.addMarker(m.options);
  //   }
  // }
}
