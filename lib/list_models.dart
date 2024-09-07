class ListModel {
  final String name;
  final String species;
  final Location? location;
  final String imageUrl;

  const ListModel({
    required this.name,
    required this.species,
    required this.location,
    required this.imageUrl,
  });

  factory ListModel.fromJson(Map<String, dynamic> json) {
    return ListModel(
      name: json['name'],
      species: json['species'],
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
      imageUrl: json['image'],
    );
  }
}

class Location {
  String? name;
  String? url;

  Location({this.name, this.url});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
