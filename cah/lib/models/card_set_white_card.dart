class CardSetWhiteCards {
  int cardSetId;
  int whiteCardId;

  static String tableName = "'public.card_set_white_card'";
  CardSetWhiteCards({this.cardSetId = 0, this.whiteCardId = 0});

  Map<String, dynamic> toMap() {
    return {'card_set_id': cardSetId, 'white_card_id': whiteCardId};
  }

  @override
  String toString() {
    return 'CardSetWhiteCards{card_set_id: $cardSetId, white_card_id: $whiteCardId}';
  }
}
