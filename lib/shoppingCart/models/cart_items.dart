class CartItem {
  final String description;
  final double amount;
  final String thumbnail;
  final String postId;

  CartItem({
    required this.description,
    required this.amount,
    required this.thumbnail,
    required this.postId,
  });

  // Define fromJson constructor
  CartItem.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        amount = json['amount'].toDouble(),
        thumbnail = json['thumbnail'],
        postId = json['postId'];

  // Add toJson method
  Map<String, dynamic> toJson() => {
        'description': description,
        'amount': amount,
        'thumbnail': thumbnail,
        'postId': postId,
      };
}
