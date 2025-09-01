import 'package:flutter/material.dart';
import 'Homescreen.dart';
import 'Favourites_screen.dart';
import 'Profile_screen.dart';

class MovieDetailScreen extends StatefulWidget {
  final String title;
  final double rating;
  final String synopsis;
  final String poster;
  final String year;

  const MovieDetailScreen({
    super.key,
    required this.title,
    required this.rating,
    required this.synopsis,
    required this.poster,
    required this.year,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         
          Image.asset(
            widget.poster,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          SafeArea(
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF292A6B), size: 28),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 260),
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  Text(
                    "${widget.title} ${widget.year}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Icon(Icons.schedule, size: 18, color: Colors.grey),
                      const SizedBox(width: 4),
                      const Text("152 minutes"),
                      const SizedBox(width: 16),
                      const Icon(Icons.star, size: 18, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text("${widget.rating}/10"),
                      const SizedBox(width: 16),
                      const Icon(Icons.calendar_today,
                          size: 18, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text("March 4, ${widget.year}"),
                    ],
                  ),

                  const SizedBox(height: 16),

                 
                  Row(
                    children: [
                      const Chip(label: Text("Action")),
                      const SizedBox(width: 8),
                      const Chip(label: Text("Sci-Fi")),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                          size: 28,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                
                  const Text(
                    "Synopsis",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.synopsis,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),

                  const SizedBox(height: 20),

                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text("Add watchlist"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF292A6B),
                        ),
                        child: const Text("Write a review"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF292A6B),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          
          
          switch (index) {
            case 0: // Home
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Homescreen(),
                ),
              );
              break;
            case 1: // Favourites
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavouritesScreen(),
                ),
              );
              break;
            case 2: // Profile
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
