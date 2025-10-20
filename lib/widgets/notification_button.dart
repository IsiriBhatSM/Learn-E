import 'package:flutter/material.dart';
// import '../theme.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.notifications, color: Theme.of(context).appBarTheme.foregroundColor),
      onPressed: () {
        // Display notification content
        // showDialog(context: context, builder: (context) => AlertDialog(title: Text('Notifications')));
      },
    );
  }
}