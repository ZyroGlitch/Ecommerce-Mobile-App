import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:firebase_journey/ecommerce/Productpages/shoesPage.dart';
import 'package:flutter/material.dart';
import '../Productpages/components/card.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});

  var shoes1 =
      "Dominate the court with these high-performance basketball shoes. Featuring a breathable mesh upper and responsive cushioning, they offer superior agility and support.";
  var shoes2 =
      "Elevate your game with these cutting-edge basketball sneakers. Their durable outsole and ankle-locking design ensure stability and grip during every play.";
  var shoes3 =
      "Unleash your full potential with these advanced basketball shoes. Engineered for explosive jumps and quick lateral movements, they provide unmatched comfort and control.";
  var shoes4 =
      "Stay ahead of the competition in these stylish basketball kicks. With a sleek design and high-impact cushioning, they deliver both on-trend looks and top-notch performance.";
  var shoes5 =
      "Get ready for the win with these dynamic basketball shoes. Their lightweight construction and excellent traction make them perfect for fast breaks and sharp cuts.";
  var shoes6 =
      "Experience next-level performance with these game-changing basketball sneakers. Featuring a supportive fit and responsive sole, they’re designed for peak performance on the court.";

  var cloth1 =
      "Refresh your wardrobe with this elegant, flowy blouse. Crafted from lightweight fabric with a subtle sheen, it’s perfect for both office wear and evening outings.";
  var cloth2 =
      "Stay cozy and stylish in this versatile knit sweater. Its relaxed fit and soft texture make it a must-have for chilly days and casual weekends.";
  var cloth3 =
      "Upgrade your casual look with these trendy jogger pants. Featuring a sleek design and adjustable waistband, they combine comfort with contemporary style.";
  var cloth4 =
      "Turn heads with this chic, tailored blazer. Its sharp lines and classic color make it an essential piece for a polished and professional appearance.";
  var cloth5 =
      "Embrace effortless elegance in this flowy maxi dress. With its flattering silhouette and vibrant print, it’s perfect for summer outings and special occasions.";
  var cloth6 =
      "Experience ultimate comfort in these breathable, high-waisted leggings. Ideal for workouts or lounging, they offer a perfect blend of flexibility and support.";

  var watch1 =
      "Make a statement with this classic stainless steel watch. Featuring a sleek, minimalist design and precise quartz movement, it’s perfect for any occasion.";
  var watch2 =
      "Stay on time and in style with this elegant leather strap watch. Its sophisticated dial and durable build make it a timeless addition to your accessory collection.";
  var watch3 =
      "Enhance your active lifestyle with this rugged sports watch. Built with a durable case, water resistance, and multifunctional features, it’s ideal for any adventure.";
  var watch4 =
      "Add a touch of luxury to your look with this beautifully crafted watch. The intricate details and gleaming gold finish make it a perfect accessory for formal events.";
  var watch5 =
      "Experience modern elegance with this sleek, smart watch. Combining advanced technology with a stylish design, it keeps you connected and fashionable.";
  var watch6 =
      "Discover precision and style with this automatic watch. Its open-heart design and intricate movement showcase a blend of craftsmanship and modern aesthetics.";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          toolbarHeight: 140,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Products',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.cyan,
                    radius: 41,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('images/profile.jpg'),
                    radius: 38,
                  ),
                ],
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: ButtonsTabBar(
                elevation: 3,
                contentCenter: true,
                radius: 25,
                contentPadding: const EdgeInsets.all(15),
                width: 135,
                height: 60,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                tabs: const [
                  Tab(
                    icon: Icon(Icons.directions_run),
                    text: 'Shoes',
                  ),
                  Tab(
                    icon: Icon(Icons.checkroom),
                    text: 'Shirt',
                  ),
                  Tab(
                    icon: Icon(Icons.watch),
                    text: 'Watch',
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BuildCard(
                            image: 'images/Nike1/skyblue.png',
                            name: 'Nike G.T. Cut 3 EP',
                            price: '₱10,295',
                            fitStyle: BoxFit.fitWidth,
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShoesPage(
                                    image: 'images/Nike1/skyblue.png',
                                    imageFit: BoxFit.cover,
                                    productName: 'Nike G.T. Cut 3 EP',
                                    price: '₱10295',
                                    description: shoes1,
                                    isShoes: true,
                                  ),
                                ),
                              );
                            },
                          ),
                          BuildCard(
                            image: 'images/Nike1/red.png',
                            name: 'LeBron NXXT Gen',
                            price: '₱8,895',
                            fitStyle: BoxFit.fitWidth,
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShoesPage(
                                    image: 'images/Nike1/red.png',
                                    imageFit: BoxFit.cover,
                                    productName: 'LeBron NXXT Gen',
                                    price: '₱8895',
                                    description: shoes2,
                                    isShoes: true,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BuildCard(
                            image: 'images/Nike1/green.png',
                            name: 'Air Jordan 4 Retro',
                            price: '₱11,395',
                            fitStyle: BoxFit.fitWidth,
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShoesPage(
                                    image: 'images/Nike1/green.png',
                                    imageFit: BoxFit.cover,
                                    productName: 'Air Jordan 4 Retro',
                                    price: '₱11395',
                                    description: shoes3,
                                    isShoes: true,
                                  ),
                                ),
                              );
                            },
                          ),
                          BuildCard(
                            image: 'images/Nike1/grey.png',
                            name: 'Cosmic Unity 3',
                            price: '₱5,459',
                            fitStyle: BoxFit.fitWidth,
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShoesPage(
                                    image: 'images/Nike1/grey.png',
                                    imageFit: BoxFit.cover,
                                    productName: 'Cosmic Unity 3',
                                    price: '₱5459',
                                    description: shoes4,
                                    isShoes: true,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BuildCard(
                            image: 'images/Nike1/black.png',
                            name: 'Luka 2 PF',
                            price: '₱5,919',
                            fitStyle: BoxFit.fitWidth,
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShoesPage(
                                    image: 'images/Nike1/black.png',
                                    imageFit: BoxFit.cover,
                                    productName: 'Luka 2 PF',
                                    price: '₱5919',
                                    description: shoes5,
                                    isShoes: true,
                                  ),
                                ),
                              );
                            },
                          ),
                          BuildCard(
                            image: 'images/Nike1/gold.png',
                            name: 'Air Jordan I High G',
                            price: '₱5,939',
                            fitStyle: BoxFit.fitWidth,
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShoesPage(
                                    image: 'images/Nike1/gold.png',
                                    imageFit: BoxFit.cover,
                                    productName: 'Air Jordan I High G',
                                    price: '₱5939',
                                    description: shoes6,
                                    isShoes: true,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Placeholder for Shirts
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BuildCard(
                            image: 'images/Shirt/shirtBlack.png',
                            name: "FreshIQ Polo Shirt",
                            price: '₱655',
                            fitStyle: BoxFit.contain,
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShoesPage(
                                    image: 'images/Shirt/shirtBlack.png',
                                    imageFit: BoxFit.contain,
                                    productName: "FreshIQ Polo Shirt",
                                    price: '₱655',
                                    description: cloth1,
                                    isShoes: false,
                                  ),
                                ),
                              );
                            },
                          ),
                          BuildCard(
                            image: 'images/Shirt/shirtBrown.png',
                            name: "Turtleneck Sleeve",
                            price: '₱800',
                            fitStyle: BoxFit.contain,
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShoesPage(
                                    image: 'images/Shirt/shirtBrown.png',
                                    imageFit: BoxFit.contain,
                                    productName: "Turtleneck Sleeve",
                                    price: '₱800',
                                    description: cloth2,
                                    isShoes: false,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BuildCard(
                            image: 'images/Shirt/shirtCyan.png',
                            name: "Hawaiian Floral",
                            price: '₱1200',
                            fitStyle: BoxFit.contain,
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShoesPage(
                                    image: 'images/Shirt/shirtCyan.png',
                                    imageFit: BoxFit.contain,
                                    productName: "Hawaiian Floral",
                                    price: '₱1200',
                                    description: cloth3,
                                    isShoes: false,
                                  ),
                                ),
                              );
                            },
                          ),
                          BuildCard(
                            image: 'images/Shirt/shirtGreen.png',
                            name: "Cocktail Dresses",
                            price: '₱655',
                            fitStyle: BoxFit.contain,
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShoesPage(
                                    image: 'images/Shirt/shirtGreen.png',
                                    imageFit: BoxFit.contain,
                                    productName: "Cocktail Dresses",
                                    price: '₱655',
                                    description: cloth4,
                                    isShoes: false,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BuildCard(
                            image: 'images/Shirt/shirtBlue.png',
                            name: "Men's Crewneck",
                            price: '₱500',
                            fitStyle: BoxFit.contain,
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShoesPage(
                                    image: 'images/Shirt/shirtBlue.png',
                                    imageFit: BoxFit.contain,
                                    productName: "Men's Crewneck",
                                    price: '₱500',
                                    description: cloth5,
                                    isShoes: false,
                                  ),
                                ),
                              );
                            },
                          ),
                          BuildCard(
                            image: 'images/Shirt/shirtWhite.png',
                            name: "Dokotoo Tank Top",
                            price: '₱1500',
                            fitStyle: BoxFit.contain,
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShoesPage(
                                    image: 'images/Shirt/shirtWhite.png',
                                    imageFit: BoxFit.contain,
                                    productName: "Dokotoo Tank Top",
                                    price: '₱1500',
                                    description: cloth6,
                                    isShoes: false,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Placeholder for Watches
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BuildCard(
                            image: 'images/Watch/watchPink.png',
                            name: 'AGPTEK Watch',
                            price: '₱2500',
                            fitStyle: BoxFit.contain,
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShoesPage(
                                    image: 'images/Watch/watchPink.png',
                                    imageFit: BoxFit.contain,
                                    productName: 'AGPTEK Watch',
                                    price: '₱2500',
                                    description: watch1,
                                    isShoes: false,
                                  ),
                                ),
                              );
                            },
                          ),
                          BuildCard(
                            image: 'images/Watch/watchBlack.png',
                            name: 'TOZO S5 Watch',
                            price: '₱4500',
                            fitStyle: BoxFit.contain,
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShoesPage(
                                    image: 'images/Watch/watchBlack.png',
                                    imageFit: BoxFit.contain,
                                    productName: 'TOZO S5 Watch',
                                    price: '₱4500',
                                    description: watch2,
                                    isShoes: false,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BuildCard(
                            image: 'images/Watch/watchGray.png',
                            name: 'K10 Smart Watch',
                            price: '₱3000',
                            fitStyle: BoxFit.contain,
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShoesPage(
                                    image: 'images/Watch/watchGray.png',
                                    imageFit: BoxFit.contain,
                                    productName: 'K10 Smart Watch',
                                    price: '₱3000',
                                    description: watch3,
                                    isShoes: false,
                                  ),
                                ),
                              );
                            },
                          ),
                          BuildCard(
                            image: 'images/Watch/watchWhite.png',
                            name: 'Bip 5 Smart Watch',
                            price: '₱3500',
                            fitStyle: BoxFit.contain,
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShoesPage(
                                    image: 'images/Watch/watchWhite.png',
                                    imageFit: BoxFit.contain,
                                    productName: 'Bip 5 Smart Watch',
                                    price: '₱3500',
                                    description: watch4,
                                    isShoes: false,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BuildCard(
                            image: 'images/Watch/watchPink1.png',
                            name: 'GTR Smart Watch',
                            price: '₱4800',
                            fitStyle: BoxFit.contain,
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShoesPage(
                                    image: 'images/Watch/watchPink1.png',
                                    imageFit: BoxFit.contain,
                                    productName: 'GTR Smart Watch',
                                    price: '₱4800',
                                    description: watch5,
                                    isShoes: false,
                                  ),
                                ),
                              );
                            },
                          ),
                          BuildCard(
                            image: 'images/Watch/watchGreen.png',
                            name: 'Amazfit Mini Watch',
                            price: '₱4000',
                            fitStyle: BoxFit.contain,
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShoesPage(
                                    image: 'images/Watch/watchGreen.png',
                                    imageFit: BoxFit.contain,
                                    productName: 'Amazfit Mini Watch',
                                    price: '₱4000',
                                    description: watch6,
                                    isShoes: false,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
