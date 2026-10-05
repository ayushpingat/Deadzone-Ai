import 'package:flutter/material.dart';
import '../widgets/app_logo.dart';

class LoginScreen extends StatefulWidget {
  final String registeredName;
  final String registeredEmail;
  final void Function({
    required String identifier,
    required String password,
  }) onLogin;
  final VoidCallback onBackToSignUp;

  const LoginScreen({
    super.key,
    required this.registeredName,
    required this.registeredEmail,
    required this.onLogin,
    required this.onBackToSignUp,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    widget.onLogin(
      identifier: _identifierController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 36, 20, 28),
          child: Column(
            children: [
              Container(
                width: 210,
                height: 150,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: const AppLogo(size: 134, full: true),
              ),
              const SizedBox(height: 18),
              Container(
                width: 86,
                height: 86,
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Icon(
                  Icons.lock_open_rounded,
                  size: 42,
                  color: scheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'Welcome back',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Log in to continue to your DeadZone AI dashboard.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 10),
              Chip(
                avatar: const Icon(Icons.check_circle_outline_rounded, size: 16),
                label: Text(
                  'Account: ${widget.registeredName}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 28),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _identifierController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Email or name',
                        prefixIcon: Icon(Icons.person_outline_rounded),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter your email or name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submit(),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: FilledButton.icon(
                        onPressed: _submit,
                        icon: const Icon(Icons.login_rounded),
                        label: const Text(
                          'Log In',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              TextButton.icon(
                onPressed: widget.onBackToSignUp,
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('Create a different demo account'),
              ),
              const SizedBox(height: 10),
              
            ],
          ),
        ),
      ),
    );
  }
}
