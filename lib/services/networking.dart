import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({this.url});
  final url;

  Future getWeatherData() async{
    http.Response response = await http.get(url);
    if(response.statusCode == 200 ){
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    }
    else{
      print('statusCode: ${response.statusCode}');
    }
  }


}