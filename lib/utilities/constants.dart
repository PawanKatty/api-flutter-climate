import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 50.0,
);

const kWeatherCondition= TextStyle(
  fontSize: 21,
  color: Colors.white
);


const kMessageTextStyle = TextStyle(
  fontFamily: 'Pacifico',
  fontSize: 35.0,
  color: Colors.black,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 40.0,
);

//input decoration
const kInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
//  icon: Icon(
//    Icons.location_city,
//    color: Colors.deepPurple,
//    size: 30,
//  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Colors.purpleAccent, width: 1.0),
  ),

  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.purpleAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);