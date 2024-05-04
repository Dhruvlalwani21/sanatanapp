class CategoryModel {
  final String id;
  final String categoryIn;
  final String name;
  final String status;
  final String icon;
  final String bannerColor;
  final String headFontColor;
  final String colorLeft;
  final String colorRight;

  CategoryModel({
    required this.id,
    required this.categoryIn,
    required this.name,
    required this.status,
    required this.icon,
    required this.bannerColor,
    required this.headFontColor,
    required this.colorLeft,
    required this.colorRight,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] ?? '',
      categoryIn: json['CategoryIn'] ?? '',
      name: json['Name'] ?? '',
      status: json['Status'] ?? '',
      icon: json['Icon'] ?? '',
      bannerColor: json['Bannercolor'] ?? '',
      headFontColor: json['Headfontcolor'] ?? '',
      colorLeft: json['Colorleft'] ?? '',
      colorRight: json['Colorright'] ?? '',
    );
  }
}
