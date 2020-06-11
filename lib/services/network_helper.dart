import 'dart:convert';

import 'package:http/http.dart' as http;

class HTTPHelper{
  final url;
  HTTPHelper(this.url);
  Future<dynamic> getResponse() async{
    http.Response response = await http.get(url);
    if(response.statusCode==200){

      var decodedData = jsonDecode(utf8.decode(response.bodyBytes));
      return decodedData;
    }
    else{
      print(response.statusCode);
    }

  }
}