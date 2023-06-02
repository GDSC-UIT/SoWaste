import 'package:sowaste/core/values/app_url.dart';
import 'package:sowaste/data/services/http_service.dart';

class QrService {
  static Future<bool> isQrExist(String qr) async {
    var res = await HttpService.getRequest("${UrlValue.getQrCodes}/$qr");
    return res.statusCode == 200;
  }
}
