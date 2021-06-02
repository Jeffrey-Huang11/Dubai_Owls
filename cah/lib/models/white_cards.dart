class WhiteCards {
  int id;
  String text;
  String watermark;

  static String tableName = "public.white_cards";
  WhiteCards({this.id = 0, this.text = "word", this.watermark = "word"});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'watermark': watermark,
    };
  }

  factory WhiteCards.fromJson(Map<String, dynamic> json) {
    return WhiteCards(
      id: json['id'],
      text: json['text'],
      watermark: json['watermark'],
    );
  }
}
