import 'dart:convert';
import 'package:books/strings.dart';
import 'package:http/http.dart' as http;
import 'listbook.dart';

// ignore: camel_case_types
class API_Manager {
  Future<BooksModel> getbooks() async {
    var client = http.Client();
    var booksModel;

    try {
      var response = await client.get(Strings.books_url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        booksModel = BooksModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return booksModel;
    }

    return booksModel;
  }
}
