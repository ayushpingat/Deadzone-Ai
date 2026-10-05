import 'package:flutter/material.dart';
import '../widgets/app_logo.dart';
import 'account_screen.dart';
import 'about_screen.dart';

class SettingsScreen extends StatefulWidget {
  final bool darkMode;
  final ValueChanged<bool> onThemeChanged;

  const SettingsScreen({
    super.key,
    required this.darkMode,
    required this.onThemeChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _darkMode;

  @override
  void initState() {
    super.initState();
    _darkMode = widget.darkMode;
  }

  void _changeTheme(bool value) {
    setState(() => _darkMode = value);
    widget.onThemeChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const BrandAppBarTitle('Settings')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
        children: [
          Text(
            'Preferences',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Card(
            color: scheme.surfaceContainerLowest,
            child: SwitchListTile.adaptive(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 5,
              ),
              value: _darkMode,
              onChanged: _changeTheme,
              secondary: CircleAvatar(
                backgroundColor: scheme.primaryContainer,
                child: Icon(
                  _darkMode
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                  color: scheme.onPrimaryContainer,
                ),
              ),
              title: const Text(
                'Dark theme',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              subtitle: Text(
                _darkMode ? 'Dark mode is active' : 'Use a brighter light theme',
              ),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'Account & information',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Card(
            color: scheme.surfaceContainerLowest,
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: scheme.secondaryContainer,
                    child: Icon(
                      Icons.person_rounded,
                      color: scheme.onSecondaryContainer,
                    ),
                  ),
                  title: const Text(
                    'Account',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  subtitle: const Text('Open your account and profile'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const AccountScreen(),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: scheme.tertiaryContainer,
                    child: Icon(
                      Icons.info_outline_rounded,
                      color: scheme.onTertiaryContainer,
                    ),
                  ),
                  title: const Text(
                    'About',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  subtitle: const Text('About DeadZone AI'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const AboutScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
