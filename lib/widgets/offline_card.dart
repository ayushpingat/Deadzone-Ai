import 'package:flutter/material.dart';
import '../models/prediction_data.dart';

class OfflineCard extends StatelessWidget {
  final List<OfflineResource> resources;
  final VoidCallback onPrepare;

  const OfflineCard({
    super.key,
    required this.resources,
    required this.onPrepare,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final allReady = resources.every((item) => item.ready);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 19,
                backgroundColor: scheme.secondaryContainer,
                child: Icon(
                  Icons.offline_bolt_rounded,
                  color: scheme.onSecondaryContainer,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Text(
                  'Prepare for connectivity loss',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...resources.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                children: [
                  Icon(
                    item.ready
                        ? Icons.check_circle_rounded
                        : Icons.radio_button_unchecked_rounded,
                    size: 19,
                    color: item.ready ? scheme.tertiary : scheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    item.ready ? 'Ready' : 'Pending',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: item.ready
                          ? scheme.tertiary
                          : scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: allReady ? null : onPrepare,
              icon: Icon(
                allReady
                    ? Icons.check_rounded
                    : Icons.download_done_rounded,
              ),
              label: Text(allReady ? 'Offline Ready' : 'Prepare Offline'),
            ),
          ),
        ],
      ),
    );
  }
}
