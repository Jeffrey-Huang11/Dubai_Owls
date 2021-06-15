class CardSets {
  int id;
  int active;
  int baseDeck;
  String description;
  String name;
  int weight;

  static String tableName = "'public.card_set'";
  CardSets(
      {this.id = 0,
      this.active = 0,
      this.baseDeck = 0,
      this.description = "word",
      this.name = "word",
      this.weight = 0});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'active': active,
      'base_deck': baseDeck,
      'description': description,
      'name': name,
      'weight': weight
    };
  }

  @override
  String toString() {
    return 'CardSets{id: $id, active: $active, base_deck: $baseDeck, description: $description, name: $name, weight: $weight}';
  }
}
