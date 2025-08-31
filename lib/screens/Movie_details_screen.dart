import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  final String title;
  final double rating;
  final String synopsis;

  const MovieDetailScreen({
    super.key,
    required this.title,
    required this.rating,
    required this.synopsis,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Poster Image
          Image.network(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSKHRqA0OkiVvxqc9koNQjvK_CbJ9asDH_ZA&s",
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          // Back Button (overlaid)
          SafeArea(
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF292A6B), size: 28),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Content below image
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
                  // Title with Year
                  Text(
                    "$title 2022",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Movie Details Row
                  Row(
                    children: [
                      const Icon(Icons.schedule, size: 18, color: Colors.grey),
                      const SizedBox(width: 4),
                      const Text("152 minutes"),
                      const SizedBox(width: 16),
                      const Icon(Icons.star, size: 18, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text("$rating/10"),
                      const SizedBox(width: 16),
                      const Icon(Icons.calendar_today,
                          size: 18, color: Colors.grey),
                      const SizedBox(width: 4),
                      const Text("March 4, 2022"),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Genre Chips and Favorite Icon
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

                  // Synopsis
                  const Text(
                    "Synopsis",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    synopsis,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),

                  const SizedBox(height: 20),

                  // Action Buttons
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

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF292A6B),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
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
