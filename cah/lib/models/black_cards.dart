class BlackCards {
  int id;
  int draw;
  int pick;
  String text;
  String watermark;

  static String tableName = "'public.black_cards'";
  BlackCards(
      {this.id = 0,
      this.draw = 0,
      this.pick = 0,
      this.text = "word",
      this.watermark = "word"});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'draw': draw,
      'pick': pick,
      'text': text,
      'watermark': watermark,
    };
  }

  @override
  String toString() {
    return 'BlackCards{id: $id, draw: $draw, pick: $pick, text: $text, watermark: $watermark}';
  }
}
