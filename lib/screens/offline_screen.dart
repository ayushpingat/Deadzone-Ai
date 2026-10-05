import 'package:flutter/material.dart';
import '../models/prediction_data.dart';
import '../widgets/app_logo.dart';

class OfflineScreen extends StatelessWidget {
  final List<OfflineResource> resources;
  final VoidCallback onPrepare;

  const OfflineScreen({
    super.key,
    required this.resources,
    required this.onPrepare,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final allReady = resources.every((item) => item.ready);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      children: [
        BrandHeader(
          title: 'Offline resources',
          subtitle: 'Keep important information available when coverage drops.',
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: allReady
                ? scheme.tertiaryContainer
                : scheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: allReady
                  ? Colors.green.withValues(alpha: .30)
                  : scheme.outlineVariant,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 19,
                backgroundColor: allReady
                    ? Colors.green.withValues(alpha: .15)
                    : scheme.primaryContainer,
                child: Icon(
                  allReady
                      ? Icons.check_rounded
                      : Icons.offline_bolt_rounded,
                  color: allReady
                      ? Colors.green
                      : scheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      allReady
                          ? 'Offline resources ready'
                          : 'Protection is not prepared yet',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      allReady
                          ? 'Your route and important content are staged for offline access.'
                          : 'Prepare before the predicted dead zone.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...resources.map(
          (item) => Card(
            color: scheme.surfaceContainerLowest,
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 5,
              ),
              leading: Icon(
                _iconFor(item.title),
                color: item.ready
                    ? Colors.green
                    : scheme.onSurfaceVariant,
              ),
              title: Text(
                item.title,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              subtitle: Text(item.subtitle),
              trailing: Icon(
                item.ready
                    ? Icons.check_circle_rounded
                    : Icons.cloud_queue_rounded,
                color: item.ready
                    ? Colors.green
                    : scheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (!allReady)
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onPrepare,
              icon: const Icon(Icons.download_done_rounded),
              label: const Text('Prepare Offline'),
            ),
          ),
      ],
    );
  }

  IconData _iconFor(String title) {
    switch (title) {
      case 'Cached Maps':
        return Icons.map_outlined;
      case 'Important Documents':
        return Icons.description_outlined;
      case 'Saved Information':
        return Icons.bookmark_border_rounded;
      default:
        return Icons.sync_rounded;
    }
  }
}
