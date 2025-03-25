import 'package:flutter/material.dart';
import 'package:task_7/widgets/watch.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addproduct');
        },
        shape: const CircleBorder(),
        backgroundColor: const Color.fromARGB(255, 37, 60, 103),
        elevation: 20,
        foregroundColor: Colors.white,
        tooltip: "Add Watch",
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color.fromARGB(255, 40, 48, 57),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 40, 48, 57),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/watch1.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          DefaultTabController(
            length: 3,
            child: Expanded(
              child: Column(
                children: [
                  TabBar(
                    tabs: const [
                      SizedBox(
                        width: 100,
                        child: Tab(
                          text: 'All',
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Tab(
                          text: 'Trending',
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Tab(
                          text: 'Recent',
                        ),
                      ),
                    ],
                    dividerColor: Colors.transparent,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white,
                    indicator: BoxDecoration(
                      color: const Color.fromARGB(255, 37, 60, 103),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: TabBarView(
                        children: [WatchGrid(), WatchGrid(), WatchGrid()],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
