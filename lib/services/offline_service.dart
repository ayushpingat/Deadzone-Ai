import '../models/prediction_data.dart';

class OfflineService {
  Future<List<OfflineResource>> getResources({bool prepared = false}) async {
    return [
      OfflineResource(
        title: 'Cached Maps',
        subtitle: 'Home → College route',
        ready: prepared,
      ),
      OfflineResource(
        title: 'Important Documents',
        subtitle: '2 files protected for offline use',
        ready: prepared,
      ),
      OfflineResource(
        title: 'Saved Information',
        subtitle: 'Recent notes and reference data',
        ready: prepared,
      ),
      OfflineResource(
        title: 'Pending Sync',
        subtitle: prepared ? 'All changes synchronized' : '3 items waiting',
        ready: prepared,
      ),
    ];
  }
}
