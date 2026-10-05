class PredictionData {
  final String title;
  final String distance;
  final String duration;
  final int confidence;
  final int probability;
  final List<String> reasons;

  const PredictionData({
    required this.title,
    required this.distance,
    required this.duration,
    required this.confidence,
    required this.probability,
    required this.reasons,
  });
}

class OfflineResource {
  final String title;
  final String subtitle;
  final bool ready;

  const OfflineResource({
    required this.title,
    required this.subtitle,
    required this.ready,
  });
}
