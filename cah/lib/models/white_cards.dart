class WhiteCards {
  int id;
  String text;
  String watermark;

  static String tableName = "'public.white_cards'";
  WhiteCards({this.id = 0, this.text = "word", this.watermark = "word"});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'watermark': watermark,
    };
  }

  @override
  String toString() {
    return 'WhiteCards{id: $id, text: $text, watermark: $watermark}';
  }
}
