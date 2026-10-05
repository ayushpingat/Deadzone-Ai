import 'package:flutter/material.dart';
import '../widgets/app_logo.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const BrandAppBarTitle('About')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 34,
                  backgroundColor: scheme.primaryContainer,
                  child: Icon(
                    Icons.wifi_find_rounded,
                    size: 34,
                    color: scheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'About DeadZone AI',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'DeadZone AI is an intelligent connectivity prediction application designed to help users anticipate upcoming network dead zones and prepare for offline connectivity.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Card(
            color: scheme.surfaceContainerLowest,
            child: const ListTile(
              leading: Icon(Icons.verified_outlined),
              title: Text(
                'Version',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              trailing: Text(
                '1.0.0',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
