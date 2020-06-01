import 'dart:async';

import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  getLocationData() async {
    //wait for 10sec for data otherwise it will move on next page with error msg.
    var weatherData;
    try{
      weatherData = await WeatherModel().getLocationWeather().timeout(Duration(seconds: 10));
    }
    on TimeoutException catch(e){
      weatherData = null;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(locationWeather: weatherData,);
    }));
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.purpleAccent,
          size: 60,
        ),
      ),
    );
  }
}
