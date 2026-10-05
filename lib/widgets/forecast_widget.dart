import 'package:flutter/material.dart';

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final items = [
      ('Good Coverage', Colors.green),
      ('Weak Coverage', const Color(0xFFF59E0B)),
      ('Dead Zone', scheme.error),
      ('Good Coverage', Colors.green),
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Connectivity forecast',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 18),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < items.length; i++) ...[
                  Column(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: items[i].$2,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: 9),
                      Text(
                        items[i].$1,
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  if (i != items.length - 1)
                    Container(
                      width: 54,
                      height: 2,
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 26,
                      ),
                      color: scheme.outlineVariant,
                    ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Predicted route state · Home → College',
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
