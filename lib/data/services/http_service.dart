import 'package:http/http.dart' as http;
import 'package:sowaste/data/services/auth_service.dart';

class HttpService {
  static const String idToken =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6ImQwZTFkMjM5MDllNzZmZjRhNzJlZTA4ODUxOWM5M2JiOTg4ZjE4NDUiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiSGlldSBOZ2FuIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FBY0hUdGZ4VWtHRFhZRHpGcXR2cHRma1JkX0wxSk5HRnhfUjZGbURmR3c5PXM5Ni1jIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL3Nvd2FzdGUtMTY2MTUiLCJhdWQiOiJzb3dhc3RlLTE2NjE1IiwiYXV0aF90aW1lIjoxNjg1MTc1ODY2LCJ1c2VyX2lkIjoiaWVrcFVGRUQ0ZFN4R0szRVowNFhQcXk0UUh4MiIsInN1YiI6Imlla3BVRkVENGRTeEdLM0VaMDRYUHF5NFFIeDIiLCJpYXQiOjE2ODUxNzU4NjYsImV4cCI6MTY4NTE3OTQ2NiwiZW1haWwiOiJsdXVuZ2FuMTkuZGV2QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7Imdvb2dsZS5jb20iOlsiMTE2MjQyNDI4OTA2MDUxMDk0NTU0Il0sImVtYWlsIjpbImx1dW5nYW4xOS5kZXZAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoiZ29vZ2xlLmNvbSJ9fQ.M_kaI6iM-LK_buHVO-jvm61U32fKJCHdjjcESEzOPHczUaY5RtzkAxqjoBWYo-Ph2K3xdJLZsENxIHZt3utaXkkaDDpnT9FGZnRwtWtecJM-QCP_QBjHQAzLHAlJST4iQy0Yc9nmaxEqjiE0D2_o08rRqKns1i36Hm_9XnpxT-VoCKKyF880ubQaPMyis2fFl9WDfDAksqkyWt08ySX-4jTHqLEHb5NCq";

  static Future<http.Response> postRequest(Set<Object?> set,
      {body, url}) async {
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
        'Authorization': 'Bearer $idToken',
      },
    );
  }
}
