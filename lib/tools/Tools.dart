import 'package:junior_test/resources/api/mall_api_provider.dart';

class Tools {
  static const int LIST_ITEM_COUNT = 5;
  static String getImagePath(String shortPath) {
    if ((shortPath == null) || (shortPath == "null")) {
      //картинка при пустом адресе
      shortPath = "uploads/promo/img/7/1.jpg";
    }
    return MallApiProvider.baseImageUrl + shortPath;
  }
}
