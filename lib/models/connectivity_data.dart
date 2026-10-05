class ConnectivityData {
  final String status;
  final String networkType;
  final int score;
  final String locationName;
  final double latitude;
  final double longitude;

  const ConnectivityData({
    required this.status,
    required this.networkType,
    required this.score,
    required this.locationName,
    required this.latitude,
    required this.longitude,
  });
}

class ConnectivityEvent {
  final String time;
  final String label;
  final int score;

  const ConnectivityEvent({
    required this.time,
    required this.label,
    required this.score,
  });
}
