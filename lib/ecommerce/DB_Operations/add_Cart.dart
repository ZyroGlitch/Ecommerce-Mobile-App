class AddCart {
  final String itemID, userID, itemName, image, size;
  final double itemPrice, subtotal;
  final int quantity;
  final DateTime timeAddedCart;

  AddCart({
    required this.itemID,
    required this.userID,
    required this.itemName,
    required this.itemPrice,
    required this.quantity,
    required this.timeAddedCart,
    required this.image,
    required this.size,
    required this.subtotal,
  });

  Map<String, dynamic> toJson() => {
        'productID': itemID,
        'userID': userID,
        'itemName': itemName,
        'itemPrice': itemPrice,
        'quantity': quantity,
        'timeAddedCart': timeAddedCart,
        'image': image,
        'size': size,
        'subtotal': subtotal,
      };
}
