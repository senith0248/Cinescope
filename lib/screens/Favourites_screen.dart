import 'package:flutter/material.dart';
import 'package:cinescope/screens/Movie_details_screen.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // favorite movies data with asset images
    final List<Map<String, dynamic>> favouriteMovies = [
      {
        'title': 'The Dark Knight',
        'rating': 9.0,
        'imagePath': 'assets/images/dark_knight.jpg',
        'year': '2008',
        'synopsis': 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
      },
      {
        'title': 'Inception',
        'rating': 8.8,
        'imagePath': 'assets/images/inception-1.jpg',
        'year': '2010',
        'synopsis': 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.',
      },
      {
        'title': 'Interstellar',
        'rating': 8.7,
        'imagePath': 'assets/images/interstellar.jpg',
        'year': '2014',
        'synopsis': 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.',
      },
      {
        'title': 'The Shawshank Redemption',
        'rating': 9.3,
        'imagePath': 'assets/images/shawshank.jpeg',
        'year': '1994',
        'synopsis': 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.',
      },
      {
        'title': 'Pulp Fiction',
        'rating': 8.9,
        'imagePath': 'assets/images/pulp_fiction.jpg',
        'year': '1994',
        'synopsis': 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.',
      },
    ];

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text(
          'Favourites',
          style: TextStyle(
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
            icon: const Icon(Icons.search),
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
                    imagePath: movie['imagePath'],
                    synopsis: movie['synopsis'],
                    screenWidth: screenWidth,
                    year: movie['year'],
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
  final String imagePath;
  final String synopsis;
  final double screenWidth;
  final String year;

  const FavouriteMovieCard({
    super.key,
    required this.title,
    required this.rating,
    required this.imagePath,
    required this.synopsis,
    required this.screenWidth,
    required this.year,
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
                poster: imagePath,
                year: year,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
             
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  width: screenWidth * 0.25,
                  height: screenWidth * 0.38,
                  fit: BoxFit.cover,
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
