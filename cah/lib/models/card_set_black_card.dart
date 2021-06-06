class CardSetBlackCards {
  int card_set_id;
  int black_card_id;

  static String tableName = "'public.card_set_black_card'";
  CardSetBlackCards({this.card_set_id = 0, this.black_card_id = 0});

  Map<String, dynamic> toMap() {
    return {'card_set_id': card_set_id, 'black_card_id': black_card_id};
  }

  @override
  String toString() {
    return 'CardSetBlackCards{card_set_id: $card_set_id, black_card_id: $black_card_id}';
  }
}
