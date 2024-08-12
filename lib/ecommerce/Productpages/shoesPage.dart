import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../DB_Operations/add_Cart.dart';
import '../No_DirectToPage_FetchData/fetchData.dart';

class ShoesPage extends StatefulWidget {
  ShoesPage({
    Key? key,
    required this.image,
    required this.imageFit,
    required this.productName,
    required this.price,
    required this.description,
    required this.isShoes,
  }) : super(key: key);

  final String image, productName, price, description;
  final BoxFit imageFit;
  final bool isShoes;
  static String? shoeSize;

  @override
  State<ShoesPage> createState() => _ShoesPageState();
}

class _ShoesPageState extends State<ShoesPage> {
  TextEditingController quantityCtr = TextEditingController();
  int qty = 1;

  var productDescription = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 28,
  );

  // The size of the item that will be pushed to Firestore
  String selectedSize = '';

  void handleSizeSelection(String size) {
    setState(() {
      selectedSize = size;
      print('Selected size: $selectedSize');
    });
  }

  Future<void> addToCart(String userID, String productName, String productPrice,
      String productImage, String size) async {
    final itemID = FirebaseFirestore.instance
        .collection('Cart')
        .doc()
        .id; // Generate a unique ID

    final docUser = FirebaseFirestore.instance.collection('Cart').doc(itemID);

    // Debug: Log input parameters
    print("Adding to cart: $productName, $productPrice, $productImage");

    try {
      // Remove the peso sign and any leading/trailing whitespace from the price string
      String priceWithoutPesoSign = productPrice.replaceAll('₱', '').trim();

      // Parse the cleaned price string to a double
      double parsedPrice = double.parse(priceWithoutPesoSign);

      // Create AddCart object
      final newCart = AddCart(
        itemID: itemID,
        userID: userID,
        itemName: productName,
        itemPrice: parsedPrice,
        quantity: qty,
        timeAddedCart: DateTime.now(),
        image: productImage,
        size: size,
        subtotal: parsedPrice * qty,
      );

      // Convert AddCart object to JSON
      final json = newCart.toJson();

      // Debug: Log the JSON data
      print("JSON data to be added to Firestore: $json");

      // Save to Firestore
      await docUser.set(json);

      // Debug: Log success
      print("Item added to cart successfully.");
    } catch (e) {
      // Debug: Log error
      print("Error adding item to cart: $e");
    }
  }

  Widget buildButtons(String sizeVal, VoidCallback onPressed) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          minimumSize: const Size(80, 50),
        ),
        onPressed: onPressed,
        child: Text(
          sizeVal,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  @override
  void initState() {
    super.initState();

    // Initialize the initial value of textfield qty
    setState(() {
      quantityCtr.text = qty.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Fetch the User ID by using provider in fetchData.dart
    final userIDProvider = Provider.of<UserIDProvider>(context);
    final String getUserID = userIDProvider.userID;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              // Product Image
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage(widget.image),
                    fit: widget.imageFit,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),

              // Product Description
              Container(
                color: Colors.grey[300],
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productName,
                          style: productDescription,
                        ),
                        Text(
                          widget.price,
                          style: productDescription,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Text(
                          'Available Sizes',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Sizes Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildButtons(
                            widget.isShoes ? '37' : 'S',
                            () => handleSizeSelection(
                                widget.isShoes ? '37' : 'S')),
                        buildButtons(
                            widget.isShoes ? '38' : 'M',
                            () => handleSizeSelection(
                                widget.isShoes ? '38' : 'M')),
                        buildButtons(
                            widget.isShoes ? '39' : 'L',
                            () => handleSizeSelection(
                                widget.isShoes ? '39' : 'L')),
                        buildButtons(
                            widget.isShoes ? '40' : 'XL',
                            () => handleSizeSelection(
                                widget.isShoes ? '40' : 'XL')),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Text(
                          'Quantity : ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        IconButton.outlined(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            qty <= 1 ? qty == 1 : qty--;
                            quantityCtr.text = qty.toString();
                          },
                          icon: Icon(Icons.remove),
                        ),
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            textAlign: TextAlign.center,
                            controller: quantityCtr,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            onChanged: (value) {},
                          ),
                        ),
                        IconButton.outlined(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              qty++;
                              quantityCtr.text = qty.toString();
                            });
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: widget.description,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 80), // Add space to accommodate FAB
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 30,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                if (selectedSize.isNotEmpty || selectedSize != '') {
                  getUserID.isNotEmpty
                      ? addToCart(
                          getUserID,
                          widget.productName,
                          widget.price,
                          widget.image,
                          selectedSize,
                        ).then(
                          (value) {
                            DelightToastBar(
                              position: DelightSnackbarPosition.top,
                              autoDismiss: true,
                              builder: (context) => const ToastCard(
                                leading: Icon(
                                  Icons.check,
                                  size: 28,
                                ),
                                title: Text(
                                  "Item added to Cart Successfully.",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ).show(context);
                          },
                        )
                      : print("User ID is not available.");
                } else {
                  print("Please select a size.");
                }
              },
              backgroundColor: Colors.orange,
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
