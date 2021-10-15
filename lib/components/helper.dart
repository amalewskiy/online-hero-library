import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Helper with ChangeNotifier {
  late Future<Map<String, dynamic>> allFutureData;
  bool isFiltered = false, isOpened = true, isNext = true;

  void changeIsFiltered(bool value) {
    isFiltered = value;
    value ? isNext = false : isNext = true;
    notifyListeners();
  }

  void changeIsOpened() {
    isOpened = !isOpened;
    notifyListeners();
  }

  void changeIsNext() {
    isNext = !isNext;
    notifyListeners();
  }

  Future<Map<String, dynamic>> fetchData(String link) async {
    final response = await http.get(Uri.parse(link));
    isOpened = !isOpened;
    return jsonDecode(response.body);
  }

  void changeAllFutureData({String link = 'https://swapi.dev/api/people/'}) {
    allFutureData = fetchData(link);
    notifyListeners();
  }
}
