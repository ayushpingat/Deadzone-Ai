import 'package:flutter/material.dart';
import '../widgets/app_logo.dart';
import 'profile_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const BrandAppBarTitle('Account')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
        children: [
          Card(
            color: scheme.surfaceContainerLowest,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: CircleAvatar(
                radius: 23,
                backgroundColor: scheme.primaryContainer,
                child: Icon(
                  Icons.person_outline_rounded,
                  color: scheme.onPrimaryContainer,
                ),
              ),
              title: const Text(
                'Profile',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              subtitle: const Text('Open profile'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ProfileScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
