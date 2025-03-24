import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290,
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(0), top: Radius.circular(20)),
              child: Image.asset(
                'assets/images/shoe.png',
                width: 400,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Derby Leather Shoes',
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "\$120",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Men's Shoe",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 22,
                              color: Color.fromARGB(255, 233, 215, 54),
                            ),
                            Text(
                              '(4.0)',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
