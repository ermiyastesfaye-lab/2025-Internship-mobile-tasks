import 'package:flutter/material.dart';
import 'package:task_6/widget/size.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final List<bool> _isClicked = List.generate(10, (index) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/shoe1.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.4,
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              toolbarHeight: kToolbarHeight,
                              title: Container(
                                width: 50,
                                height: 50,
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Color.fromARGB(255, 63, 81, 243),
                                ),
                              ), // AppBar title
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Row(
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
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Derby Leather',
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "\$120",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Size:",
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.w600),
                              )),
                          SizedBox(
                            height: 65,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: ShoeSize(
                                      onTap: () {
                                        setState(() {
                                          _isClicked[index] =
                                              !_isClicked[index];
                                        });
                                      },
                                      isClicked: _isClicked[index],
                                      num: index + 39,
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(
                        child: Text(
                          "A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.",
                          style: TextStyle(
                              color: Color.fromARGB(255, 84, 82, 82),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.red),
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 150,
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor:
                                        const Color.fromARGB(255, 63, 81, 243)),
                                onPressed: () {},
                                child: const Text(
                                  'Update',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
