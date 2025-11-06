// lib/pages/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:learn_e/data/profile_data.dart';
// import 'package:learn_e/pages/home_page.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _dobController = TextEditingController();

  bool _isSubmitting = false;
  

  // Helper to format month name (Jan, Feb, …)
  String monthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // ---- SAVE PROFILE DATA ----
    Profile.updateProfile(
      username: _nameController.text.trim(),
      email: _emailController.text.trim(),
      dob: _dobController.text,
    );
    // ---------------------------

    setState(() => _isSubmitting = false);

    // Success feedback
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signup successful!')),
    );

    // Navigate to Home (replaced login stack)
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white70 : Colors.black87;
    final hintColor = isDark ? Colors.white54 : Colors.black54;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Full Name
                TextFormField(
                  style: TextStyle(color: textColor),
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: hintColor),
                    labelText: 'Full Name',
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (v) =>
                      v?.trim().isEmpty ?? true ? 'Name cannot be empty' : null,
                ),
                const SizedBox(height: 16),

                // Email
                TextFormField(
                  style: TextStyle(color: textColor),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: hintColor),
                    labelText: 'Email',
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  validator: (v) {
                    if (v?.trim().isEmpty ?? true) return 'Email cannot be empty';
                    if (!v!.contains('@')) return 'Enter a valid email';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password
                TextFormField(
                  style: TextStyle(color: textColor),
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: hintColor),
                    labelText: 'Password',
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: theme.primaryColor,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  ),
                  validator: (v) =>
                      (v?.length ?? 0) < 6 ? 'Password must be ≥6 characters' : null,
                ),
                const SizedBox(height: 16),

                // Confirm Password
                TextFormField(
                  style: TextStyle(color: textColor),
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: hintColor),
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                      color: theme.primaryColor,
                    ),
                    onPressed: () =>
                        setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                  ),
                  ),
                  validator: (v) {
                    if (v != _passwordController.text) return 'Passwords do not match';
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Date of Birth
                TextFormField(
                  style: TextStyle(color: textColor),
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: hintColor),
                    labelText: 'Date of Birth (DD MM YYYY)',
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                    prefixIcon: const Icon(Icons.calendar_today),
                  ),
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      _dobController.text =
                          '${picked.day} ${monthName(picked.month)} ${picked.year}';
                    }
                  },
                  validator: (v) =>
                      v?.isEmpty ?? true ? 'Please select your date of birth' : null,
                ),
                const SizedBox(height: 30),

                // Submit Button
                _isSubmitting
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                    foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                           shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 3,
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                const SizedBox(height: 20),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Color(0xFFFC603F),
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
      ),
    );
  }
}