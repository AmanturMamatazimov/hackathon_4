import 'package:http/http.dart' as http;

const String baseUrl = 'http://192.168.43.81:2323';

class BaseClient {
  var client = http.Client();

  //GET
  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl+api);

    var response = await client.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }

  Future<dynamic> post(String api,var json) async {
    var url = Uri.parse(baseUrl+api);
    //var _payload = json.encode(object);

    var response = await client.post(url,body: json);
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      print('error not found');
      return false;
      //throw exception and catch it in UI
    }
  }

  ///PUT Request
  /*Future<dynamic> put(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);
    var _headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'Content-Type': 'application/json',
      'api_key': 'ief873fj38uf38uf83u839898989',
    };

    var response = await client.put(url, body: _payload, headers: _headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }*/

  /*Future<dynamic> delete(String api) async {
    var url = Uri.parse(baseUrl + api);
    var _headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'api_key': 'ief873fj38uf38uf83u839898989',
    };

    var response = await client.delete(url, headers: _headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }*/
}
