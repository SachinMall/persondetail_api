import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:persondetail_api/person_detail/person_detail.dart';

class PersonDetailAPI {
  static var client = http.Client();
  Future getList() async {
    var PersonDetailList = [];

    try {
      final response = await client.get(Uri.parse(
          'https://run.mocky.io/v3/c8b8f8f4-a0d0-4fbc-a1a1-3821c1595ff9'));
      if (response.statusCode == 200) {
        final jsonRes = response.body;
        final jsonMap = json.decode(response.body);
        PersonDetailList =
            (jsonMap as List).map((e) => PersonDetail.fromJson(e)).toList();
        return PersonDetailList;
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      log("message $e $stackTrace");
      return null;
    }
  }
}
