// lib/pages/login_screen.dart
import 'package:flutter/material.dart';
import 'package:learn_e/pages/signup_screen.dart';
import 'package:learn_e/pages/first_page.dart';
import '../data/profile_data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  //Email validation using regex
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // Password validation (at least 6 chars)
  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    //  Validation checks
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }
    if (!_isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address.')),
      );
      return;
    }
    if (!_isValidPassword(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 6 characters long.')),
      );
      return;
    }

    // Simulated login
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);

    // Update profile
    Profile.updateProfile(
      username: email.split('@')[0], // username inferred from email
      email: email,
      dob: null,
    );

    // Navigate after login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const FirstPage()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white70 : Colors.black87;
    final hintColor = isDark ? Colors.white54 : Colors.black54;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // LOGO
              Image.asset(
                'assets/logo/learn-e_orange.png',
                height: 60,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),

              // TAGLINE
              Text(
                '5   m i n u t e   f a c t s',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 40),

              // EMAIL FIELD
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: hintColor),
                  filled: true,
                  fillColor: isDark ? Colors.grey[800] : Colors.white,
                  prefixIcon: Icon(Icons.email, color: theme.primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // PASSWORD FIELD
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: hintColor),
                  filled: true,
                  fillColor: isDark ? Colors.grey[800] : Colors.white,
                  prefixIcon: Icon(Icons.lock, color: theme.primaryColor),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: theme.primaryColor,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // LOGIN BUTTON
              SizedBox(
                width: double.infinity,
                height: 42,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 3,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),

              // SIGN UP LINK
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: textColor),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SignUpScreen(),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
