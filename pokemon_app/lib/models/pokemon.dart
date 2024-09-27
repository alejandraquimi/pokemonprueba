class Pokemon {
  int? id;
  String? name;
  String? url;
  List<String>? types;
  List<String>? abilities;
  List<String>? stats;

  Pokemon(
      {this.id, this.stats, this.name, this.url, this.types, this.abilities});

  Pokemon.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('id')) {
      id = json['id'];
    }

    if (json.containsKey('name')) {
      name = json['name'];
    }

    if (json.containsKey('sprites') &&
        json['sprites'].containsKey('front_shiny')) {
      url = json['sprites']['front_shiny'];
    } else if (json.containsKey('url')) {
      url = json['url'];
    }

    if (json.containsKey('types')) {
      types =
          List<String>.from(json['types'].map((type) => type['type']['name']));
    }

    if (json.containsKey('abilities')) {
      abilities = List<String>.from(
          json['abilities'].map((ability) => ability['ability']['name']));
    }

    if (json.containsKey('stats')) {
      stats =
          List<String>.from(json['stats'].map((stat) => stat['stat']['name']));
    }
  }

  @override
  String toString() {
    return 'Pokemon{id: $id, name: $name, url: $url, types: $types, abilities: $abilities}';
  }

  Pokemon copyWith({
    int? id,
    String? name,
    String? url,
    List<String>? types,
    List<String>? abilities,
  }) {
    return Pokemon(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      types: types ?? this.types,
      abilities: abilities ?? this.abilities,
    );
  }
}
