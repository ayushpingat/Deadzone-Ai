import '../models/prediction_data.dart';

class PredictionService {
  Future<PredictionData> getCurrentPrediction() async {
    // Mock AI output; replace with the ML inference layer later.
    return const PredictionData(
      title: 'Dead zone predicted',
      distance: '700 m ahead',
      duration: '3–5 minutes',
      confidence: 87,
      probability: 84,
      reasons: [
        'Previous connectivity loss at this location',
        'Similar time of day',
        'Current movement pattern',
        'Historical route data',
      ],
    );
  }
}
