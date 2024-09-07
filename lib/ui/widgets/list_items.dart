import 'package:flutter/material.dart';

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
