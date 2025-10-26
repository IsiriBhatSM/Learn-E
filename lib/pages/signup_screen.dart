import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool _isSubmitting = false;

  // Store submitted data temporarily
  final List<Map<String, String>> _submittedUsers = [];

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isSubmitting = true;
      });

      // Simulate network delay or registration process
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isSubmitting = false;
        _submittedUsers.add({
          'name': name,
          'email': email,
        });
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signup successful!')),
      );

      // Optionally clear the form
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email cannot be empty';
                  } else if (!value.contains('@')) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) => email = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password cannot be empty';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                onSaved: (value) => password = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm your password';
                  } else if (value != password) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                onSaved: (value) => confirmPassword = value!,
              ),
              const SizedBox(height: 20),
              _isSubmitting
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Register'),
                    ),
              const SizedBox(height: 20),
              if (_submittedUsers.isNotEmpty) ...[
                const Text(
                  'Submitted Users:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _submittedUsers.length,
                    itemBuilder: (context, index) {
                      final user = _submittedUsers[index];
                      return ListTile(
                        title: Text(user['name']!),
                        subtitle: Text(user['email']!),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
