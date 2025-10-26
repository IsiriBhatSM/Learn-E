import 'package:flutter/material.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String feedback = '';
  bool _isSubmitting = false;
  final List<Map<String, String>> _submittedFeedbacks = [];

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() => _isSubmitting = true);

      // Simulate submission delay
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isSubmitting = false;
        _submittedFeedbacks.add({'email': email, 'feedback': feedback});
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Feedback submitted successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feedback Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email cannot be empty';
                  }
                  if (!value.contains('@')) return 'Enter a valid email';
                  return null;
                },
                onSaved: (value) => email = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Feedback'),
                validator: (value) =>
                    value!.isEmpty ? 'Feedback cannot be empty' : null,
                onSaved: (value) => feedback = value!,
              ),
              const SizedBox(height: 20),
              _isSubmitting
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Submit'),
                    ),
              const SizedBox(height: 20),
              if (_submittedFeedbacks.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: _submittedFeedbacks.length,
                    itemBuilder: (context, index) {
                      final item = _submittedFeedbacks[index];
                      return Card(
                        child: ListTile(
                          title: Text(item['email']!),
                          subtitle: Text(item['feedback']!),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
