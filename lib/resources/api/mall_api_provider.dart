import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:junior_test/model/RootResponse.dart';
import 'package:junior_test/resources/api/RootType.dart';

class MallApiProvider {
  Client client = Client();
  final _baseUrlMall = "https://bonus.andreyp.ru/api/v1/";
  static const baseImageUrl = "https://bonus.andreyp.ru/";

  Future<RootResponse> _baseGETfetchWithEvent(
      RootTypes event, String url) async {
    try {
      final uri = Uri.parse(_baseUrlMall + url);
      Response response = await client.get(uri);
      if (response.statusCode == 200) {
        RootResponse resp = RootResponse.fromJson(json.decode(response.body));
        resp.setEventType(event);
        return resp;
      } else {
        return RootResponse();
      }
    } on Exception catch (e) {
      if (!e.toString().contains('HttpException')) {
        RootResponse resp = RootResponse();
        resp.setEventType(RootTypes.EVENT_NETWORK_EXCEPTION);
        return resp;
      }
    }
  }

  Future<RootResponse> _baseGETfetchAllWithEvent(
      RootTypes event, String url) async {
    try {
      final uri =
          Uri.parse(_baseUrlMall + url);
      Response response = await client.get(uri);
      if (response.statusCode == 200) {
        RootResponse resp = RootResponse.fromJson(json.decode(response.body));
        resp.setEventType(event);
        return resp;
      } else {
        return RootResponse();
      }
    } on Exception catch (e) {
      if (!e.toString().contains('HttpException')) {
        RootResponse resp = RootResponse();
        resp.setEventType(RootTypes.EVENT_NETWORK_EXCEPTION);
        return resp;
      }
    }
  }

  Future<RootResponse> _basePOSTfetchWithEvent(
      RootTypes event, String url, Object args) async {
    print(_baseUrlMall + url);
    final uri = Uri.parse(_baseUrlMall + url);
    Response request = await client.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: args);
    print(request.body);
    if (request.statusCode == 200) {
      RootResponse resp = RootResponse.fromJson(json.decode(request.body));
      resp.setEventType(event);
      return resp;
    } else {
      return RootResponse();
    }
  }

  Future<RootResponse> fetchActionInfo(int id) {
    return _baseGETfetchWithEvent(RootTypes.EVENT_ACTION_ITEM, "promo?id=$id");
  }

  Future<RootResponse> fetchActions(int page, int itemsOnPage) {
    return _baseGETfetchAllWithEvent(RootTypes.EVENT_ACTION_LIST,
        'promos?page=$page&count=$itemsOnPage');
  }
}
