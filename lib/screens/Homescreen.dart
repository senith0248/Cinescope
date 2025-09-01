import 'package:flutter/material.dart';
import 'Movie_details_screen.dart';
import 'Favourites_screen.dart';
import 'Profile_screen.dart';
import 'Login_screen.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    
    int crossAxisCount;
    if (screenWidth > 800) {
      crossAxisCount = 5;
    } else if (screenWidth > 600) {
      crossAxisCount = 4;
    } else if (screenWidth > 400) {
      crossAxisCount = 3;
    } else {
      crossAxisCount = 2;
    }

    
    double horizontalPadding = screenWidth * 0.03;
    double verticalPadding = screenHeight * 0.02;
    double headerHeight = isLandscape ? screenHeight * 0.4 : screenHeight * 0.25;

    return Scaffold(
      appBar: AppBar(
        leading: PopupMenuButton<String>(
          icon: const Icon(Icons.menu),
          onSelected: (value) {
            _handleMenuSelection(context, value);
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem<String>(
              value: 'home',
              child: Row(
                children: [
                  Icon(Icons.home, color: Color(0xFF292A6B)),
                  SizedBox(width: 12),
                  Text('Home'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'favorites',
              child: Row(
                children: [
                  Icon(Icons.favorite, color: Color(0xFF292A6B)),
                  SizedBox(width: 12),
                  Text('Favorites'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'profile',
              child: Row(
                children: [
                  Icon(Icons.person, color: Color(0xFF292A6B)),
                  SizedBox(width: 12),
                  Text('Profile'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'settings',
              child: Row(
                children: [
                  Icon(Icons.settings, color: Color(0xFF292A6B)),
                  SizedBox(width: 12),
                  Text('Settings'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'logout',
              child: Row(
                children: [
                  Icon(Icons.exit_to_app, color: Color(0xFF292A6B)),
                  SizedBox(width: 12),
                  Text('Logout'),
                ],
              ),
            ),
          ],
        ),
        title: const Text(
          'CineScope',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Batman 
            Container(
              height: headerHeight,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Thebatman.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(horizontalPadding),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailScreen(
                            title: 'The Batman',
                            rating: 8.5,
                            synopsis:
                                'Two years of nights have turned Bruce Wayne into a nocturnal animal, '
                                'but as he continues to find his way as Gotham\'s dark knight, '
                                'Bruce is forced into a game of cat and mouse with his biggest threat so far.',
                            poster: 'assets/images/Thebatman.jpeg',
                            year: '2022',
                          ),
                        ),
                      );
                    },
                    child: const Text('See more'),
                  ),
                ),
              ),
            ),

           
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding / 2),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recommended movies',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ),
            ),

           
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recommendedMovies.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: horizontalPadding,
                  mainAxisSpacing: verticalPadding,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final movie = recommendedMovies[index];
                  return MovieCard(
                    title: movie['title']!,
                    rating: double.parse(movie['rating']!),
                    imagePath: movie['imagePath']!,
                    synopsis: movie['synopsis']!,
                    year: movie['year']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuSelection(BuildContext context, String value) {
    switch (value) {
      case 'home':
       
        break;
      case 'favorites':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FavouritesScreen(),
          ),
        );
        break;
      case 'profile':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
        break;
      case 'settings':
        
        break;
      case 'logout':
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false,
        );
        break;
    }
  }
}


class MovieCard extends StatefulWidget {
  final String title;
  final double rating;
  final String imagePath;
  final String synopsis;
  final String year;

  const MovieCard({
    super.key,
    required this.title,
    required this.rating,
    required this.imagePath,
    required this.synopsis,
    required this.year,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: InkWell(
              onTap: () {
                
                _animationController.forward().then((_) {
                  _animationController.reverse();
                });
                
                // Navigation 
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => MovieDetailScreen(
                      title: widget.title,
                      rating: widget.rating,
                      synopsis: widget.synopsis,
                      poster: widget.imagePath,
                      year: widget.year,
                    ),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, 1.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOutCubic;
                      
                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 400),
                  ),
                );
              },
              child: Card(
                margin: EdgeInsets.zero,
                elevation: _isHovered ? 8 : 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: _isHovered 
                      ? Border.all(color: const Color(0xFF292A6B), width: 2)
                      : null,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            image: DecorationImage(
                              image: AssetImage(widget.imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontSize: screenWidth * 0.04,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(widget.rating.toStringAsFixed(1)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//  recommended movies list with synopsis
const List<Map<String, String>> recommendedMovies = [
  {
    'title': 'Warrior',
    'rating': '8.1',
    'imagePath': 'assets/images/Warrior.jpeg',
    'year': '2011',
    'synopsis':
        'Two estranged brothers enter a mixed martial arts tournament, each with their own motives, '
        'struggling with family and personal demons.'
  },
  {
    'title': 'One love',
    'rating': '6.6',
    'imagePath': 'assets/images/one-love.jpg',
    'year': '2024',
    'synopsis': 'A romantic tale about love, destiny, and second chances that tests the limits of the heart.'
  },
  {
    'title': 'Inception',
    'rating': '8.8',
    'imagePath': 'assets/images/inception-1.jpg',
    'year': '2010',
    'synopsis': 'A skilled thief is given a chance at redemption if he can successfully plant an idea into a target\'s subconscious.'
  },
  {
    'title': 'F1',
    'rating': '7.8',
    'imagePath': 'assets/images/F1.jpg',
    'year': '2023',
    'synopsis': 'The high-speed world of Formula 1 racing is captured with drama, rivalry, and innovation at every turn.'
  },
  {
    'title': '300',
    'rating': '7.6',
    'imagePath': 'assets/images/300.jpeg',
    'year': '2006',
    'synopsis': 'King Leonidas of Sparta and his 300 warriors fight against the Persian army in a legendary battle.'
  },
  {
    'title': 'Interstellar',
    'rating': '8.7',
    'imagePath': 'assets/images/interstellar.jpg',
    'year': '2014',
    'synopsis': 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.'
  },
];
