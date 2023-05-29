import 'package:http/http.dart' as http;
import 'package:sowaste/data/services/auth_service.dart';

class HttpService {
  static Future<http.Response> postRequest({body, url}) async {
    return await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${AuthServices.idToken}',
        },
        body: body);
  }

  static Future<http.Response> putRequest({body, url}) async {
    return await http.put(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${AuthServices.idToken}',
        },
        body: body);
  }

  static Future<http.Response> getRequest(url) async {
    return await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AuthServices.idToken}',
      },
    );
  }

  static Future<http.Response> postRequestWithParam(
      {required Map<String, dynamic> parameters, required String url}) async {
    final uri = Uri.parse(url);

    // Append query parameters to the URL
    final uriWithParams = uri.replace(queryParameters: parameters);

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${AuthServices.idToken}',
    };

    return await http.post(uriWithParams, headers: headers);
  }
}
