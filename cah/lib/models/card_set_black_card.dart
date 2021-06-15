class CardSetBlackCards {
  int cardSetId;
  int blackCardId;

  static String tableName = "'public.card_set_black_card'";
  CardSetBlackCards({this.cardSetId = 0, this.blackCardId = 0});

  Map<String, dynamic> toMap() {
    return {'card_set_id': cardSetId, 'black_card_id': blackCardId};
  }

  @override
  String toString() {
    return 'CardSetBlackCards{card_set_id: $cardSetId, black_card_id: $blackCardId}';
  }
}
