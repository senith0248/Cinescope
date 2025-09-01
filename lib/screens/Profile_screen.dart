import 'package:flutter/material.dart';
import 'Login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.02,
        ),
        child: Column(
          children: [
           
            Container(
              padding: EdgeInsets.all(screenWidth * 0.05),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: isLandscape ? screenHeight * 0.08 : screenWidth * 0.14,
                    backgroundColor: const Color(0xFF292A6B),
                    child: Icon(
                      Icons.person,
                      size: isLandscape ? screenHeight * 0.08 : screenWidth * 0.14,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'Senith Kavishka',
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headlineMedium?.color,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  const Text(
                    'kavishkasenith@gmail.com',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem('Movies Watched', '127', screenWidth, screenHeight),
                      _buildStatItem('Favourites', '23', screenWidth, screenHeight),
                      _buildStatItem('Reviews', '15', screenWidth, screenHeight),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03),

          
            _buildSectionContainer(
              context: context,
              title: 'Settings',
              items: [
                _buildSettingItem(
                  context: context,
                  icon: Icons.notifications,
                  title: 'Notifications',
                  subtitle: 'Manage your notification preferences',
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                    activeColor: const Color(0xFF292A6B),
                  ),
                ),
                _buildSettingItem(
                  context: context,
                  icon: Icons.dark_mode,
                  title: 'Dark Mode',
                  subtitle: 'Switch between light and dark themes',
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {},
                    activeColor: const Color(0xFF292A6B),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),

           
            _buildSectionContainer(
              context: context,
              title: 'Account',
              items: [
                _buildSettingItem(
                  context: context,
                  icon: Icons.person_outline,
                  title: 'Edit Profile',
                  subtitle: 'Update your personal information',
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
                _buildSettingItem(
                  context: context,
                  icon: Icons.history,
                  title: 'Watch History',
                  subtitle: 'View your movie watching history',
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
                _buildSettingItem(
                  context: context,
                  icon: Icons.star_outline,
                  title: 'My Reviews',
                  subtitle: 'See all your movie reviews',
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.03),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false, 
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, double screenWidth, double screenHeight) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF292A6B),
          ),
        ),
        SizedBox(height: screenHeight * 0.005),
        Text(
          label,
          style: TextStyle(fontSize: screenWidth * 0.035, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSectionContainer({
    required BuildContext context,
    required String title,
    required List<Widget> items,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.headlineMedium?.color,
              ),
            ),
          ),
          ...items,
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF292A6B).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: const Color(0xFF292A6B), size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium?.color,
          fontSize: 12,
        ),
      ),
      trailing: trailing,
      onTap: () {},
    );
  }
}
