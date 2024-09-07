import 'package:flutter/material.dart';
import 'package:hacker/data/remote_data.dart';
import 'package:hacker/ui/widgets/list_items.dart';
import '../models/list_models.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  List<ListModel> personsList = [];

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
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                RemoteData.getPersons(page: 4);
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
                  location:
                      personsList[index].location?.name ?? 'Unknown Location',
                  imageUrl: personsList[index].imageUrl,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
