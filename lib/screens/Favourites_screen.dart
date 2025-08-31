import 'package:flutter/material.dart';
import 'package:cinescope/screens/Movie_details_screen.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample favorite movies data
    final List<Map<String, dynamic>> favouriteMovies = [
      {
        'title': 'The Dark Knight',
        'rating': 9.0,
        'imageUrl': 'https://via.placeholder.com/150',
        'synopsis': 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
      },
      {
        'title': 'Inception',
        'rating': 8.8,
        'imageUrl': 'https://via.placeholder.com/150',
        'synopsis': 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.',
      },
      {
        'title': 'Interstellar',
        'rating': 8.6,
        'imageUrl': 'https://via.placeholder.com/150',
        'synopsis': 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.',
      },
      {
        'title': 'The Shawshank Redemption',
        'rating': 9.3,
        'imageUrl': 'https://via.placeholder.com/150',
        'synopsis': 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.',
      },
      {
        'title': 'Pulp Fiction',
        'rating': 8.9,
        'imageUrl': 'https://via.placeholder.com/150',
        'synopsis': 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF292A6B),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          'Favourites',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 2,
                color: Colors.black26,
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: favouriteMovies.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No favourite movies yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add movies to your favourites to see them here',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: favouriteMovies.length,
              itemBuilder: (context, index) {
                final movie = favouriteMovies[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: FavouriteMovieCard(
                    title: movie['title'],
                    rating: movie['rating'],
                    imageUrl: movie['imageUrl'],
                    synopsis: movie['synopsis'],
                  ),
                );
              },
            ),

    );
  }
}

class FavouriteMovieCard extends StatelessWidget {
  final String title;
  final double rating;
  final String imageUrl;
  final String synopsis;

  const FavouriteMovieCard({
    super.key,
    required this.title,
    required this.rating,
    required this.imageUrl,
    required this.synopsis,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(
                title: title,
                rating: rating,
                synopsis: synopsis,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Movie poster
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: 80,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 120,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.movie,
                        color: Colors.grey,
                        size: 32,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              // Movie details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.red[400],
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Favourite',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Arrow icon
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 