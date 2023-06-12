import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notification Screen Content',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.notification_important),
                title: const Text('Notification 1'),
                subtitle: const Text('This is the first notification'),
                trailing: IconButton(
                  onPressed: () {
                    // TODO: Implement notification action
                  },
                  icon: const Icon(Icons.arrow_forward),
                ),
              ),
            ),
            Card(
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.notification_important),
                title: const Text('Notification 2'),
                subtitle: const Text('This is the second notification'),
                trailing: IconButton(
                  onPressed: () {
                    // TODO: Implement notification action
                  },
                  icon: const Icon(Icons.arrow_forward),
                ),
              ),
            ),
            // Add more notifications as needed
          ],
        ),
      ),
    );
  }
}
