import 'package:flutter/material.dart';
import 'models/connectivity_data.dart';
import 'models/prediction_data.dart';
import 'screens/history_screen.dart';
import 'screens/home_screen.dart';
import 'screens/journey_screen.dart';
import 'screens/offline_screen.dart';
import 'screens/prediction_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
import 'services/connectivity_service.dart';
import 'services/location_service.dart';
import 'services/offline_service.dart';
import 'services/prediction_service.dart';
import 'widgets/app_bottom_nav.dart';

void main() {
  runApp(const DeadZoneAiApp());
}

class DeadZoneAiApp extends StatefulWidget {
  const DeadZoneAiApp({super.key});

  @override
  State<DeadZoneAiApp> createState() => _DeadZoneAiAppState();
}

class _DeadZoneAiAppState extends State<DeadZoneAiApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _setDarkMode(bool enabled) {
    setState(() {
      _themeMode = enabled ? ThemeMode.dark : ThemeMode.light;
    });
  }

  ThemeData _buildLightTheme() {
    const seed = Color(0xFF6D28D9);
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: const Color(0xFFF7F7F8),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
      ),
      cardTheme: const CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerLowest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: scheme.primary, width: 1.6),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primaryContainer,
        labelTextStyle: const WidgetStatePropertyAll(
          TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: TextStyle(color: scheme.onInverseSurface),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    const seed = Color(0xFF8B5CF6);
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: const Color(0xFF0C0A12),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: const Color(0xFF0C0A12),
        foregroundColor: scheme.onSurface,
        elevation: 0,
      ),
      cardTheme: const CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: scheme.primary, width: 1.6),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primaryContainer,
        labelTextStyle: const WidgetStatePropertyAll(
          TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeadZone AI',
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: _themeMode,
      home: AppRoot(
        darkMode: _themeMode == ThemeMode.dark,
        onThemeChanged: _setDarkMode,
      ),
    );
  }
}

enum _AuthStep { signUp, login, app }

class AppRoot extends StatefulWidget {
  final bool darkMode;
  final ValueChanged<bool> onThemeChanged;

  const AppRoot({
    super.key,
    required this.darkMode,
    required this.onThemeChanged,
  });

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  final _connectivityService = ConnectivityService();
  final _locationService = LocationService();
  final _predictionService = PredictionService();
  final _offlineService = OfflineService();

  _AuthStep _authStep = _AuthStep.signUp;

  String _tempName = '';
  String _tempEmail = '';
  String _tempPassword = '';

  int _index = 0;
  bool _journeyStarted = false;
  bool _offlinePrepared = false;

  late final Future<ConnectivityData> _connectivityFuture;
  late final Future<PredictionData> _predictionFuture;
  late final Future<List<ConnectivityEvent>> _historyFuture;
  late final Future<String> _routeFuture;

  @override
  void initState() {
    super.initState();
    _connectivityFuture = _connectivityService.getCurrentConnectivity();
    _predictionFuture = _predictionService.getCurrentPrediction();
    _historyFuture = _connectivityService.getHistory();
    _routeFuture = _locationService.getCurrentRoute();
  }

  void _completeSignUp({
    required String name,
    required String email,
    required String password,
  }) {
    setState(() {
      _tempName = name;
      _tempEmail = email;
      _tempPassword = password;
      _authStep = _AuthStep.login;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account created for this demo session. Please log in.')),
    );
  }

  void _login({
    required String identifier,
    required String password,
  }) {
    final matchesIdentifier =
        identifier.trim().toLowerCase() == _tempEmail.toLowerCase() ||
        identifier.trim().toLowerCase() == _tempName.toLowerCase();

    if (!matchesIdentifier || password != _tempPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login details do not match the temporary demo account.'),
        ),
      );
      return;
    }

    setState(() {
      _authStep = _AuthStep.app;
    });
  }

  void _goBackToSignUp() {
    setState(() {
      _authStep = _AuthStep.signUp;
    });
  }

  Future<void> _prepareOffline() async {
    setState(() => _offlinePrepared = true);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✓ Route, documents, sync and offline resources are ready.'),
        ),
      );
    }
  }

  void _openPrediction(PredictionData prediction) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PredictionScreen(
          prediction: prediction,
          onPrepareOffline: _prepareOffline,
        ),
      ),
    );
  }

  void _openSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SettingsScreen(
          darkMode: widget.darkMode,
          onThemeChanged: widget.onThemeChanged,
        ),
      ),
    );
  }

  void _startJourney() {
    setState(() {
      _journeyStarted = true;
      _index = 1;
    });
  }

  Future<List<OfflineResource>> _loadResources() =>
      _offlineService.getResources(prepared: _offlinePrepared);

  @override
  Widget build(BuildContext context) {
    if (_authStep == _AuthStep.signUp) {
      return SignUpScreen(
        onSignUp: _completeSignUp,
      );
    }

    if (_authStep == _AuthStep.login) {
      return LoginScreen(
        registeredName: _tempName,
        registeredEmail: _tempEmail,
        onLogin: _login,
        onBackToSignUp: _goBackToSignUp,
      );
    }

    return FutureBuilder<ConnectivityData>(
      future: _connectivityFuture,
      builder: (context, connectivitySnapshot) {
        if (!connectivitySnapshot.hasData) return const _LoadingScreen();

        return FutureBuilder<PredictionData>(
          future: _predictionFuture,
          builder: (context, predictionSnapshot) {
            if (!predictionSnapshot.hasData) return const _LoadingScreen();

            return FutureBuilder<List<ConnectivityEvent>>(
              future: _historyFuture,
              builder: (context, historySnapshot) {
                if (!historySnapshot.hasData) return const _LoadingScreen();

                return FutureBuilder<List<OfflineResource>>(
                  future: _loadResources(),
                  builder: (context, resourcesSnapshot) {
                    if (!resourcesSnapshot.hasData) return const _LoadingScreen();

                    return FutureBuilder<String>(
                      future: _routeFuture,
                      builder: (context, routeSnapshot) {
                        if (!routeSnapshot.hasData) return const _LoadingScreen();

                        final pages = [
                          HomeScreen(
                            connectivity: connectivitySnapshot.data!,
                            prediction: predictionSnapshot.data!,
                            resources: resourcesSnapshot.data!,
                            journeyStarted: _journeyStarted,
                            onPredictionTap: () =>
                                _openPrediction(predictionSnapshot.data!),
                            onPrepareOffline: _prepareOffline,
                            onStartJourney: _startJourney,
                            onOpenSettings: _openSettings,
                          ),
                          JourneyScreen(
                            learning: _journeyStarted,
                            route: routeSnapshot.data!,
                          ),
                          HistoryScreen(events: historySnapshot.data!),
                          OfflineScreen(
                            resources: resourcesSnapshot.data!,
                            onPrepare: _prepareOffline,
                          ),
                        ];

                        return Scaffold(
                          body: SafeArea(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 220),
                              child: KeyedSubtree(
                                key: ValueKey(_index),
                                child: pages[_index],
                              ),
                            ),
                          ),
                          bottomNavigationBar: AppBottomNav(
                            currentIndex: _index,
                            onTap: (value) => setState(() => _index = value),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: CircularProgressIndicator()));
}
