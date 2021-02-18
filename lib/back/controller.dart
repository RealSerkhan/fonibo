import 'dart:convert' as convert;

import 'package:fonibo/models/Fonibo.dart';
import 'package:http/http.dart' as http;

class Controller {
  static final String URL =
      "https://cdn.fonibo.com/challenges/tasks.json?fbclid=IwAR1e6bR68wFdndOtgYumR2dD8CZWGU50DdDwPtQg3Z8tBiIKhVBcYcOHyV0";
  Future<List<Fonibo>> getFormList() async {
    return await http.get(URL).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      return jsonFeedback.map((json) => Fonibo.fromJsonMap(json)).toList();
    });
  }
}
