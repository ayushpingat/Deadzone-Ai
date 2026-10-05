import 'package:flutter/material.dart';
import '../widgets/app_logo.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const BrandAppBarTitle('Profile')),
      body: const SizedBox.shrink(),
    );
  }
}
