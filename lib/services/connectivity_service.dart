import '../models/connectivity_data.dart';

class ConnectivityService {
  Future<ConnectivityData> getCurrentConnectivity() async {
    // Mock now; replace with real connectivity/network APIs later.
    return const ConnectivityData(
      status: 'CONNECTED',
      networkType: '5G',
      score: 92,
      locationName: 'Baner, Pune',
      latitude: 18.5590,
      longitude: 73.7868,
    );
  }

  Future<List<ConnectivityEvent>> getHistory() async {
    return const [
      ConnectivityEvent(time: '08:32', label: 'Good Coverage', score: 95),
      ConnectivityEvent(time: '08:35', label: 'Good Coverage', score: 91),
      ConnectivityEvent(time: '08:38', label: 'Weak Coverage', score: 61),
      ConnectivityEvent(time: '08:40', label: 'Dead Zone', score: 18),
      ConnectivityEvent(time: '08:44', label: 'Dead Zone', score: 9),
      ConnectivityEvent(time: '08:47', label: 'Good Coverage', score: 88),
    ];
  }
}
