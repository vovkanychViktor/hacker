import 'package:hacker/models/list_models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RemoteData {
  static Future<List<ListModel>> getPersons({required final int page}) async {
    try {
      // request is https://rickandmortyapi.com/api/character/?page=2'
      //response is json with persons from page2
      final persons = await http.get(
          Uri.parse('https://rickandmortyapi.com/api/character/?page=$page'));
      final Map<String, dynamic> jsonResponse =
          jsonDecode(persons.body) as Map<String, dynamic>;
      final results = jsonResponse['results'] as List;
      final values = results
          .map(
            (result) => ListModel.fromJson(result),
          )
          .toList();
      print(values);
      return values;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
