import 'package:flutter/material.dart';
import '../models/prediction_data.dart';
import 'status_chip.dart';

class PredictionCard extends StatelessWidget {
  final PredictionData prediction;
  final VoidCallback onTap;

  const PredictionCard({
    super.key,
    required this.prediction,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: scheme.errorContainer,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: scheme.error.withValues(alpha: .25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: scheme.error.withValues(alpha: .13),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: scheme.error,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    prediction.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: scheme.onErrorContainer,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _Metric(
                    label: 'Distance',
                    value: prediction.distance,
                  ),
                ),
                Expanded(
                  child: _Metric(
                    label: 'Duration',
                    value: prediction.duration,
                  ),
                ),
                Expanded(
                  child: _Metric(
                    label: 'Confidence',
                    value: '${prediction.confidence}%',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                StatusChip(
                  label: '${prediction.probability}% probability',
                  color: scheme.error,
                  background: scheme.error.withValues(alpha: .12),
                  icon: Icons.auto_awesome_rounded,
                ),
                const Spacer(),
                Text(
                  'View details',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;

  const _Metric({
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
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
