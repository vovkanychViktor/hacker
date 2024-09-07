import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hacker/list_models.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  List<ListModel> personsList = [];

  Future<void> getPersons({required final int page}) async {
    setState(() {
      isLoading = true;
    });
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
      personsList = values;
      print(values);
    } catch (e) {
      print('Error: $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Counter App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    getPersons(page: 3);
                  },
                  child: const Text('Get persons by page'),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: personsList.length,
                    itemBuilder: (context, index) => ListItem(
                      name: personsList[index].name,
                      species: personsList[index].species,
                      location: personsList[index].location?.name ??
                          'Unknown Location',
                      imageUrl: personsList[index].imageUrl,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.species,
    required this.location,
  });
  final String name;
  final String imageUrl;
  final String species;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('My name: $name'),
        Text('My species: $species'),
        Text('My location: $location'),
        Image.network(imageUrl),
      ],
    );
  }
}
