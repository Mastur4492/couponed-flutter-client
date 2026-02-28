class Coupon {
  final int id;
  final String title;
  final String description;

  Coupon({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}