import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'signin_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Completer<GoogleMapController> _controller=Completer();
  static final CameraPosition _kGooglePlex=CameraPosition(target: LatLng(20.5937, 78.9629),zoom: 14.4746);
  List<Marker> _marker=[];
  List<Marker> _list=[Marker(markerId: MarkerId("1"),position:LatLng(20.5937, 78.9629),
  infoWindow: InfoWindow(title: "My Position"))];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
    loadLocation();
  }
  loadLocation()
  {
    getUserCurrentLocation().then((value)async{
      print("My Current location");
      print(value.latitude.toString()+" "+value.longitude.toString());
      _marker.add(Marker(markerId: MarkerId("2"),position: LatLng(value.latitude,value.longitude),infoWindow:
      InfoWindow(title: "My CUreent Location")),
      );
      CameraPosition cameraPosition =CameraPosition(target: LatLng(value.latitude,value.longitude),zoom: 14);
      final GoogleMapController controller =await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {

      });

    });
  }
  Future<Position> getUserCurrentLocation() async{
  await Geolocator.requestPermission().then((value){

  }).onError((error, stackTrace) {
    print("error"+error.toString());
  });
  return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(initialCameraPosition:_kGooglePlex,onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        mapType: MapType.normal,
        compassEnabled: false,
        markers: Set<Marker>.of(_marker),),
      ),
    floatingActionButton: FloatingActionButton(child: Icon(Icons.location_disabled_outlined),
        onPressed: (){
            getUserCurrentLocation().then((value)async{
              print("My Current location");
              print(value.latitude.toString()+" "+value.longitude.toString());
              _marker.add(Marker(markerId: MarkerId("2"),position: LatLng(value.latitude,value.longitude),infoWindow:
              InfoWindow(title: "My CUreent Location")),
              );
              CameraPosition cameraPosition =CameraPosition(target: LatLng(value.latitude,value.longitude),zoom: 14);
              final GoogleMapController controller =await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
              setState(() {

              });
              
            });
        },),
    );
  }
}
ElevatedButton LogOutButton(BuildContext context)
{
  return ElevatedButton(
    child: Text("Log Out"),

    onPressed: (){
      FirebaseAuth.instance.signOut().then((value) {
        print("Signed Out");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
      });

    },
  );
}