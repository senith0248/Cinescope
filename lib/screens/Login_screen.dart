import 'package:flutter/material.dart';
import 'package:cinescope/screens/Register_screen.dart';
import 'package:cinescope/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  bool _isLoading = false;
  late AnimationController _buttonAnimationController;
  late AnimationController _formAnimationController;
  late Animation<double> _buttonScaleAnimation;
  late Animation<double> _formFadeAnimation;

  @override
  void initState() {
    super.initState();
    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _formAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _buttonScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _buttonAnimationController,
      curve: Curves.easeInOut,
    ));
    
    _formFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _formAnimationController,
      curve: Curves.easeOut,
    ));
    
   
    _formAnimationController.forward();
  }

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    _formAnimationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() {
        _isLoading = false;
      });
      
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292A6B),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenHeight = constraints.maxHeight;
            final screenWidth = constraints.maxWidth;
            final isLandscape = screenWidth > screenHeight;

            final logoSize = (isLandscape ? screenHeight * 0.2 : screenWidth * 0.2)
                .clamp(40.0, 120.0);
            final formPadding = (screenWidth * 0.06).clamp(16.0, 32.0);
            final borderRadius = (screenWidth * 0.03).clamp(8.0, 16.0);

            Widget logoSection() {
              return FadeTransition(
                opacity: _formFadeAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(logoSize * 0.3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.movie,
                        size: logoSize,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      'CineScope',
                      style: TextStyle(
                        fontSize: (screenWidth * 0.09).clamp(24.0, 48.0),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                      'Your Ultimate Movie Companion',
                      style: TextStyle(
                        fontSize: (screenWidth * 0.04).clamp(14.0, 20.0),
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            Widget loginForm() {
              return FadeTransition(
                opacity: _formFadeAnimation,
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.all(formPadding),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(borderRadius),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: (screenWidth * 0.065).clamp(20.0, 32.0),
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.headlineMedium?.color,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          'Sign in to continue your movie journey',
                          style: TextStyle(
                            fontSize: (screenWidth * 0.035).clamp(12.0, 18.0),
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.03),

                        // Email
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                              borderSide: const BorderSide(
                                color: Color(0xFF292A6B),
                                width: 2,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: screenHeight * 0.02),

                        // Password
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            prefixIcon: const Icon(Icons.lock_outlined),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                              borderSide: const BorderSide(
                                color: Color(0xFF292A6B),
                                width: 2,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: screenHeight * 0.02),

                       
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value ?? false;
                                    });
                                  },
                                  activeColor: const Color(0xFF292A6B),
                                ),
                                Text(
                                  'Remember me',
                                  style: TextStyle(
                                    fontSize: (screenWidth * 0.035).clamp(12.0, 16.0),
                                    color: Theme.of(context).textTheme.bodyMedium?.color,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: const Color(0xFF292A6B),
                                  fontWeight: FontWeight.w600,
                                  fontSize: (screenWidth * 0.035).clamp(12.0, 16.0),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.03),

                       
                        AnimatedBuilder(
                          animation: _buttonScaleAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _buttonScaleAnimation.value,
                              child: SizedBox(
                                width: double.infinity,
                                height: (screenHeight * 0.07).clamp(48.0, 60.0),
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : () {
                                    _buttonAnimationController.forward().then((_) {
                                      _buttonAnimationController.reverse();
                                    });
                                    _handleLogin();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF292A6B),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(borderRadius),
                                    ),
                                  ),
                                  child: _isLoading
                                    ? Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            'Signing In...',
                                            style: TextStyle(
                                              fontSize: (screenWidth * 0.045).clamp(16.0, 20.0),
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        'Sign In',
                                        style: TextStyle(
                                          fontSize: (screenWidth * 0.045).clamp(16.0, 20.0),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            Widget registerLink() {
              return FadeTransition(
                opacity: _formFadeAnimation,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 4,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: (screenWidth * 0.035).clamp(12.0, 16.0),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: (screenWidth * 0.035).clamp(12.0, 16.0),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: formPadding,
                vertical: screenHeight * 0.04,
              ),
              child: isLandscape
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: logoSection(),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              loginForm(),
                              SizedBox(height: screenHeight * 0.03),
                              registerLink(),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        logoSection(),
                        SizedBox(height: screenHeight * 0.04),
                        loginForm(),
                        SizedBox(height: screenHeight * 0.03),
                        registerLink(),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
