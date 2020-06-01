import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/painting.dart';
import 'package:clima/services/weather.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;
  String emptyCity = '';
  int responseCode = 0;

  errorCity(String city) async {
    String checkCity = city;
    if(checkCity=='' || checkCity == null){
      setState(() {
        emptyCity = 'enter city name';
      });
    }
    else{
      try{
        var weatherData = await WeatherModel().weatherByCity(city);
        responseCode = weatherData['cod'];
        print(responseCode);
        if(responseCode == 200){
          Navigator.pop(context,city);
        }
      }
      catch(e){
        setState(() {
          emptyCity = 'not a valid city';
        });
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.purple,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/cityback.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
//              Align(
//                alignment: Alignment.topLeft,
//                child: FlatButton(
//                  onPressed: () {
//                    Navigator.pop(context);
//                  },
//                  child: Icon(
//                    Icons.arrow_back,
//                    size: 50.0,
//                    color: Colors.purple,
//                  ),
//                ),
//              ),
              Row(
                children: <Widget>[
                  Text(
                    ' ⛅ ',
                    style: TextStyle(
                      fontSize: 35,
                    ),
                  ),
                  Expanded(
//                padding: EdgeInsets.all(20.0),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: kInputDecoration,
                      //we have to get this text value.
                      onChanged: (value) {
                        cityName = value;
                        print(cityName);
                      },
                      onSubmitted: (String city) {
                        city = cityName;
                        errorCity(city);
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                  ),
                ],
              ),
//              FlatButton(
//                onPressed: () {
//                  Navigator.pop(context,cityName);
//                },
//                child: Text(
//                  'Get Weather',
//                  style: kButtonTextStyle,
//                ),
//              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                buttonHeight: 45,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Text(
                        emptyCity,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.purple.shade200, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: FlatButton(
                      child: Text(
                        'Get Weather',
                        style: TextStyle(
                          color: Colors.purple,
                          fontFamily: 'DancingScript',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          fontSize: 17,
                        ),
                      ),
                      color: Colors.purple.shade100,
                      onPressed: () {
                        errorCity(cityName);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
