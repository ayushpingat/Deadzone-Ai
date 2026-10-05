import 'package:flutter/material.dart';
import '../models/connectivity_data.dart';
import '../models/prediction_data.dart';
import '../widgets/connectivity_card.dart';
import '../widgets/app_logo.dart';
import '../widgets/forecast_widget.dart';
import '../widgets/offline_card.dart';
import '../widgets/prediction_card.dart';

class HomeScreen extends StatelessWidget {
  final ConnectivityData connectivity;
  final PredictionData prediction;
  final List<OfflineResource> resources;
  final bool journeyStarted;
  final VoidCallback onPredictionTap;
  final VoidCallback onPrepareOffline;
  final VoidCallback onStartJourney;
  final VoidCallback onOpenSettings;

  const HomeScreen({
    super.key,
    required this.connectivity,
    required this.prediction,
    required this.resources,
    required this.journeyStarted,
    required this.onPredictionTap,
    required this.onPrepareOffline,
    required this.onStartJourney,
    required this.onOpenSettings,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
          sliver: SliverToBoxAdapter(
            child: BrandHeader(
              title: 'DeadZone AI',
              subtitle: 'Predict. Prepare. Stay connected.',
              trailing: IconButton(
                tooltip: 'Settings',
                onPressed: onOpenSettings,
                icon: const Icon(Icons.settings_outlined),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              ConnectivityCard(data: connectivity),
              const SizedBox(height: 14),
              _LocationCard(connectivity: connectivity),
              const SizedBox(height: 22),
              Text(
                'What happens ahead',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              const ForecastWidget(),
              const SizedBox(height: 22),
              Text(
                'AI prediction',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              PredictionCard(
                prediction: prediction,
                onTap: onPredictionTap,
              ),
              const SizedBox(height: 22),
              Text(
                'Why the AI expects this',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              _ReasoningCard(reasons: prediction.reasons),
              const SizedBox(height: 22),
              OfflineCard(
                resources: resources,
                onPrepare: onPrepareOffline,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: onStartJourney,
                  icon: Icon(
                    journeyStarted
                        ? Icons.psychology_rounded
                        : Icons.play_arrow_rounded,
                  ),
                  label: Text(
                    journeyStarted
                        ? 'Learning your route...'
                        : 'Start Journey',
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ]),
          ),
        ),
      ],
    );
  }
}

class _LocationCard extends StatelessWidget {
  final ConnectivityData connectivity;

  const _LocationCard({required this.connectivity});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: scheme.primaryContainer,
            child: Icon(
              Icons.location_on_rounded,
              color: scheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  connectivity.locationName,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${connectivity.latitude.toStringAsFixed(4)}, ${connectivity.longitude.toStringAsFixed(4)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.my_location_rounded,
            size: 18,
            color: scheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}

class _ReasoningCard extends StatelessWidget {
  final List<String> reasons;

  const _ReasoningCard({required this.reasons});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        children: reasons
            .map(
              (reason) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Row(
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      size: 16,
                      color: scheme.primary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        reason,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
