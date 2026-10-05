import 'package:flutter/material.dart';
import '../widgets/app_logo.dart';
import '../models/prediction_data.dart';

class PredictionScreen extends StatelessWidget {
  final PredictionData prediction;
  final VoidCallback onPrepareOffline;

  const PredictionScreen({
    super.key,
    required this.prediction,
    required this.onPrepareOffline,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const BrandAppBarTitle('Prediction details')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: scheme.errorContainer,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(
                color: scheme.error.withValues(alpha: .25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: scheme.error.withValues(alpha: .13),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: scheme.error,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Dead zone predicted',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${prediction.distance} · ${prediction.duration}',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _BigStat(
                        label: 'Probability',
                        value: '${prediction.probability}%',
                      ),
                    ),
                    Expanded(
                      child: _BigStat(
                        label: 'Confidence',
                        value: '${prediction.confidence}%',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Historical evidence',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          _EvidenceCard(prediction: prediction),
          const SizedBox(height: 18),
          Text(
            'Prediction factors',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          ...prediction.reasons.map(
            (reason) => ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 6),
              leading: Icon(
                Icons.check_circle_outline_rounded,
                color: scheme.primary,
              ),
              title: Text(reason),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: onPrepareOffline,
            icon: const Icon(Icons.offline_bolt_rounded),
            label: const Text('Prepare Offline'),
          ),
        ],
      ),
    );
  }
}

class _BigStat extends StatelessWidget {
  final String label;
  final String value;

  const _BigStat({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onErrorContainer.withValues(alpha: .72),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _EvidenceCard extends StatelessWidget {
  final PredictionData prediction;

  const _EvidenceCard({required this.prediction});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This route repeatedly dips near 08:40 AM.',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'The mock model combines location history, time of day, movement pattern, and earlier network drops to produce this forecast.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _EvidenceBar(
                  label: 'Location history',
                  value: .94,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _EvidenceBar(
                  label: 'Time pattern',
                  value: .86,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _EvidenceBar(
                  label: 'Movement',
                  value: .79,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _EvidenceBar(
                  label: 'Route history',
                  value: .91,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EvidenceBar extends StatelessWidget {
  final String label;
  final double value;

  const _EvidenceBar({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall,
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 7,
            backgroundColor: scheme.surfaceContainerHighest,
            color: scheme.primary,
          ),
        ),
      ],
    );
  }
}
