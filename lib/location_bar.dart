import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:smart_parking/screens/current_location.dart';
import 'package:smart_parking/screens/search_location.dart';


class LocationBar extends StatefulWidget {
  const LocationBar({Key? key}) : super(key: key);

  @override
  _LocationBarState createState() => _LocationBarState();
}

class _LocationBarState extends State<LocationBar> {

  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  Set<Marker> markers = {};


  @override
  void dispose() {
    //placeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color(0x88999999),
              offset: Offset(0, 5),
              blurRadius: 5.0,
            ),
          ]),
      child: Column(
        children: <Widget>[

          SizedBox( //search location box
            width: double.infinity,
            height: 50,
            child: TextButton(
              onPressed: (

                  ) {},
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[

                    SizedBox(
                      width: 40,
                      height: 50,
                      child: Center(
                        child: TextButton(
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                              return const SearchPlacesScreen() ;
                            }));
                          },
                        child: Image.asset("assets/search.png")
                        ),
                      ),
                    ),

                    Positioned(
                      right: 0,
                      top: 0,
                      width: 40,
                      height: 35,
                      child: Center(
                        child: TextButton(
                            onPressed: () {
                              //_addressController.text = "";

                            },
                            child: Image.asset("assets/ic_remove_x.png")
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 40, right: 50),
                      child: TextField(
                        // controller: _addressController,
                        // textInputAction: TextInputAction.search,
                        // onSubmitted: (str) {
                        //   placeBloc
                        // },
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff323643)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          //-----------------------------------

          SizedBox( //user location box
            width: double.infinity,
            height: 50,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                  return const CurrentLocation() ;
                }));
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                      height: 50,
                      child: Center(
                        child: Image.asset("assets/ic_location_black.png"),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      width: 40,
                      height: 35,
                      child: Center(
                        child: Image.asset("assets/ic_remove_x.png"),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 40, right: 50),
                      child: Text(
                        "Your current location",
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff323643)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



}


