import 'package:flutter/material.dart';
import 'package:task_6/widget/product.dart';

class SearchProduct extends StatelessWidget {
  const SearchProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 63, 81, 243),
          ),
        ),
        title: const Align(
            alignment: Alignment.center,
            child: Text(
              'Search Product',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            )),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Leather",
                              suffixIcon: const Icon(
                                Icons.arrow_forward,
                                color: Color.fromARGB(255, 63, 81, 243),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          height: 55,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 63, 81, 243),
                              borderRadius: BorderRadius.circular(7)),
                          child: const Icon(
                            Icons.filter_list,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Product(),
                  const SizedBox(
                    height: 15,
                  ),
                  const Product(),
                  const SizedBox(
                    height: 15,
                  ),
                  const Product()
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Category"),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Price"),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor:
                              const Color.fromARGB(255, 63, 81, 243),
                          inactiveTrackColor: Colors.grey,
                          disabledActiveTrackColor:
                              const Color.fromARGB(255, 63, 81, 243),
                          disabledInactiveTrackColor: Colors.grey,
                          disabledThumbColor:
                              const Color.fromARGB(255, 63, 81, 243),
                          trackHeight: 4,
                        ),
                        child: const Slider(
                          value: 45,
                          min: 0,
                          max: 100,
                          onChanged: null,
                          divisions: 5,
                          label: 'price',
                          activeColor: Color.fromARGB(
                              255, 63, 81, 243), // Color of the slider track
                          inactiveColor:
                              Colors.grey, // Color of the inactive track
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor:
                                const Color.fromARGB(255, 63, 81, 243)),
                        onPressed: () {},
                        child: const Text(
                          'Apply',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
