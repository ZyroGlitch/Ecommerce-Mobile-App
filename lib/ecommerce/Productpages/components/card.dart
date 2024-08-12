import 'package:flutter/material.dart';

class BuildCard extends StatelessWidget {
  BuildCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.fitStyle,
    required this.onpressed,
  });

  final String image, name, price;
  BoxFit fitStyle;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        color: Colors.grey[300],
        width: 185,
        height: 300, // Increased height to accommodate text
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Image.asset(
              image,
              filterQuality: FilterQuality.high,
              fit: fitStyle,
              width: 180,
              height: 150,
            ),
            Text(
              name,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              price,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.visibility),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                elevation: 3,
                minimumSize: const Size(150, 50),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: onpressed,
              label: const Text('View'),
            ),
          ],
        ),
      ),
    );
  }
}
