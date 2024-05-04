class ScriptureModel {
  final String id;
  final String category;
  final String subcategory;
  final String pageStyle;
  final String cardStyle;
  final String status;
  final DateTime publishDate;
  final String cardColor;
  final String cardShadow;
  final double shadowX;
  final double shadowY;
  final double shadowX1;
  final double shadowY1;
  final String shadowColor;
  final double blur;
  final double spread;
  final String title;

  final String image;

  ScriptureModel({
    required this.id,
    required this.category,
    required this.subcategory,
    required this.pageStyle,
    required this.cardStyle,
    required this.status,
    required this.publishDate,
    required this.cardColor,
    required this.cardShadow,
    required this.shadowX,
    required this.shadowY,
    required this.shadowX1,
    required this.shadowY1,
    required this.shadowColor,
    required this.blur,
    required this.spread,
    required this.title,
    required this.image,
  });

  factory ScriptureModel.fromJson(Map<String, dynamic> json) {
    return ScriptureModel(
      id: json['_id'] ?? '',
      category: json['Category'] ?? '',
      subcategory: json['Subcategory'] ?? '',
      pageStyle: json['Pagestyle'] ?? '',
      cardStyle: json['Cardstyle'] ?? '',
      status: json['Status'] ?? 0,
      publishDate: DateTime.parse(json['Publish'] ?? ''),
      cardColor: json['CardColor'] ?? '',
      cardShadow: json['CardShadow'] ?? '',
      shadowX: json['Shadowx'] ?? 0.0,
      shadowY: json['Shadowy'] ?? 0.0,
      shadowX1: json['Shadowx1'] ?? 0.0,
      shadowY1: json['Shadowy1'] ?? 0.0,
      shadowColor: json['ShadowColor'] ?? '',
      blur: json['Blur'] ?? 0.0,
      spread: json['Spread'] ?? 0.0,
      title: json['Title'] ?? '',
      image: json['Img'] ?? '',
    );
  }
}
