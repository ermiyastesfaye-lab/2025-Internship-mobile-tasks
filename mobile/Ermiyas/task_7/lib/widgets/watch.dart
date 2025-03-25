import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_7/model/watch.dart';
import 'package:task_7/pages/watch_detail.dart';

class WatchGrid extends StatefulWidget {
  const WatchGrid({super.key});

  @override
  State<WatchGrid> createState() => _WatchGridState();
}

class _WatchGridState extends State<WatchGrid> {
  List<Watch> _watchList = [];
  void initState() {
    super.initState();
    _loadWatches();
  }

  Future<void> _loadWatches() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? watchJsonList = prefs.getStringList('watch_list');

    if (watchJsonList != null) {
      setState(() {
        _watchList = watchJsonList.map((json) => Watch.fromJson(json)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10, crossAxisSpacing: 20, crossAxisCount: 2),
      itemCount: _watchList.length,
      itemBuilder: (context, index) {
        final watch = _watchList[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WatchDetail(watch: watch),
              ),
            );
          },
          child: Card(
              color: const Color.fromARGB(255, 61, 69, 78),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 61, 69, 78),
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        watch.imageUrl,
                        width: double.infinity,
                        height: 90,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/watch5.webp',
                            width: 100,
                            height: 100,
                          );
                        },
                      ),
                    ),
                    Text(watch.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${watch.price}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        )
                      ],
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
