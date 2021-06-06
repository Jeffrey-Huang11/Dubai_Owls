class CardSetWhiteCards {
  int card_set_id;
  int white_card_id;

  static String tableName = "'public.card_set_white_card'";
  CardSetWhiteCards({this.card_set_id = 0, this.white_card_id = 0});

  Map<String, dynamic> toMap() {
    return {'card_set_id': card_set_id, 'white_card_id': white_card_id};
  }

  @override
  String toString() {
    return 'CardSetWhiteCards{card_set_id: $card_set_id, white_card_id: $white_card_id}';
  }
}
