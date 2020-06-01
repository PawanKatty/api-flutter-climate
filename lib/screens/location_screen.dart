import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/widgets.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  //since state is separate from stateful , so we access its properties through 'widget'.
  //we override init method 1st.
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  String cityName;
  var temperature;
  int intTemp;
  int condition;
  String weatherCondition;
  String humidity;
  double doubleWind;
  String wind;
  var minTemp;
  var maxTemp;
  String minMaxTemp;

  String weatherMsg;
  var weatherIcon;

  void updateUI (dynamic weatherData ){
    setState(() {
      if(weatherData == null){
        intTemp = 0;
        weatherIcon = 'Error';
        weatherMsg = 'Device Location or Connection issues';
        cityName = '';
        weatherCondition='';
        humidity='';
        wind='';
        minMaxTemp='';
        return;
      }
      cityName = weatherData['name'];
      temperature = weatherData['main']['temp'];
      condition = weatherData['weather'][0]['id'];
      weatherCondition = weatherData['weather'][0]['main'];
      humidity= 'Humidity: ${weatherData['main']['humidity']}%';
      doubleWind = (((weatherData['wind']['speed'])*18)/5);
      wind = 'Wind: ${doubleWind.toStringAsFixed(1)} km/hr';
      minTemp = weatherData['main']['temp_min'];
      maxTemp = weatherData['main']['temp_max'];
      minMaxTemp = 'min:${minTemp.toInt()}\u2103 & max:${maxTemp.toInt()}\u2103';

      intTemp = temperature.toInt();
      weatherIcon = weatherModel.getWeatherIcon(condition);
      weatherMsg = weatherModel.getMessage(intTemp);
    });

    print(cityName);
    print(temperature);
    print(intTemp);
    print(condition);
    print(weatherCondition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/byLocation.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.7), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{
                      var weatherData = await WeatherModel().getLocationWeather();
                      setState(() {
                        updateUI(weatherData);
                      });
                    },
                    child: Icon(
                      Icons.location_on,
                      size: 40.0,
                      color: Colors.red,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                      var typedName= await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                      if(typedName!=null){
                        var weatherData = await WeatherModel().weatherByCity(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 40.0,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '$intTemp°',
                          style: kTempTextStyle,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 35),
                          child: Text('c',style: TextStyle(
                            fontSize: 25,
                          ),),
                        ),
                        Text(
                          weatherIcon,
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                    Text(weatherCondition,style: kWeatherCondition),
                    Text(humidity,style: kWeatherCondition),
                    Text(wind,style: kWeatherCondition),
                    SizedBox(height: 10,),
                    Text(minMaxTemp,style: kWeatherCondition),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMsg in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
