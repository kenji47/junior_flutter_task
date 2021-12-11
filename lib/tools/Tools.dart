import 'package:junior_test/resources/api/mall_api_provider.dart';

class Tools {
  static const int LIST_ITEM_COUNT = 5;

  static String getImagePath(String shortPath) {
    //TODO change image.
    if ((shortPath == null) || (shortPath == "null")) {
      shortPath = "assets/uploads/mall.png";
    }
    return MallApiProvider.baseImageUrl + shortPath;
  }
}
