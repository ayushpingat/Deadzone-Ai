import 'package:flutter/material.dart';
import '../widgets/app_logo.dart';

class JourneyScreen extends StatelessWidget {
  final bool learning;
  final String route;

  const JourneyScreen({
    super.key,
    required this.learning,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      children: [
        BrandHeader(
          title: 'Current journey',
          subtitle: route,
          trailing: Chip(
            avatar: Icon(Icons.auto_awesome_rounded,
                size: 16, color: scheme.primary),
            label: const Text(
              'Learning',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ),
        const SizedBox(height: 18),
        const SizedBox(height: 18),
        Container(
          height: 230,
          decoration: BoxDecoration(
            color: scheme.surfaceContainer,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _RoutePainter(
                    roadColor: scheme.outlineVariant,
                    routeColor: scheme.primary,
                  ),
                ),
              ),
              Positioned(
                top: 18,
                left: 18,
                child: _MapTag(
                  icon: Icons.home_rounded,
                  label: 'Home',
                ),
              ),
              Positioned(
                bottom: 18,
                right: 18,
                child: _MapTag(
                  icon: Icons.school_rounded,
                  label: 'College',
                ),
              ),
              CircleAvatar(
                radius: 22,
                backgroundColor: scheme.primary,
                child: Icon(
                  Icons.navigation_rounded,
                  color: scheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Distance',
                value: '4.8 km',
                icon: Icons.straighten_rounded,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                title: 'Network',
                value: '5G',
                icon: Icons.network_cell_rounded,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                title: 'Status',
                value: 'Stable',
                icon: Icons.check_circle_rounded,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        _JourneyStatusCard(learning: learning),
        const SizedBox(height: 20),
        Text(
          'Route overview',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 10),
        _InfoGrid(
          items: const [
            ('Start', 'Home', Icons.home_outlined),
            ('Destination', 'College', Icons.school_outlined),
            ('Estimated time', '18 min', Icons.schedule_rounded),
            ('Current score', '92%', Icons.speed_rounded),
            ('Dead zone', '700 m ahead', Icons.warning_amber_rounded),
            ('Risk window', '3–5 min', Icons.timer_outlined),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Connectivity timeline',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 10),
        _TimelineCard(
          time: '08:32',
          title: 'Good Coverage',
          detail: 'Signal is strong at the start of the route.',
          score: '95%',
          icon: Icons.signal_cellular_4_bar_rounded,
          color: const Color(0xFF16A34A),
        ),
        _TimelineCard(
          time: '08:38',
          title: 'Weak Coverage',
          detail: 'Coverage begins to weaken near the predicted zone.',
          score: '61%',
          icon: Icons.network_cell_rounded,
          color: const Color(0xFFF59E0B),
        ),
        _TimelineCard(
          time: '08:40',
          title: 'Dead Zone',
          detail: 'Route history shows a repeated connectivity drop here.',
          score: '18%',
          icon: Icons.signal_cellular_connected_no_internet_4_bar_rounded,
          color: const Color(0xFFDC2626),
        ),
        _TimelineCard(
          time: '08:47',
          title: 'Good Coverage',
          detail: 'Connectivity recovers after the low-coverage area.',
          score: '88%',
          icon: Icons.signal_cellular_4_bar_rounded,
          color: const Color(0xFF16A34A),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: scheme.primaryContainer,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: scheme.primary.withValues(alpha: .25),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.lightbulb_outline_rounded,
                color: scheme.onPrimaryContainer,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'insight',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: scheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'DeadZone AI uses previous route history, time of day, movement pattern and location history to warn you before the connection drops. In this case, the model expects the weakest point around 08:40 AM.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onPrimaryContainer,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Before the dead zone',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              const _ActionRow(
                icon: Icons.map_outlined,
                text: 'Cache the Home → College route.',
              ),
              const _ActionRow(
                icon: Icons.description_outlined,
                text: 'Keep important documents available offline.',
              ),
              const _ActionRow(
                icon: Icons.sync_rounded,
                text: 'Finish pending sync while coverage is strong.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _JourneyStatusCard extends StatelessWidget {
  final bool learning;

  const _JourneyStatusCard({required this.learning});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: learning ? scheme.primaryContainer : scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: learning ? scheme.primary.withValues(alpha: .28) : scheme.outlineVariant,
        ),
      ),
      child: Row(
        children: [
          Icon(
            learning ? Icons.psychology_rounded : Icons.insights_rounded,
            color: scheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  learning
                      ? 'Learning connectivity patterns...'
                      : 'Journey intelligence ready',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  learning
                      ? 'Using this trip to improve future dead-zone predictions.'
                      : 'Start a journey to collect mock route history.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (learning)
            const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
        ],
      ),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  final List<(String, String, IconData)> items;

  const _InfoGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.75,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          child: Row(
            children: [
              Icon(item.$3, size: 19),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.$1,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.$2,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TimelineCard extends StatelessWidget {
  final String time;
  final String title;
  final String detail;
  final String score;
  final IconData icon;
  final Color color;

  const _TimelineCard({
    required this.time,
    required this.title,
    required this.detail,
    required this.score,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                time,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              CircleAvatar(
                radius: 18,
                backgroundColor: color.withValues(alpha: .12),
                child: Icon(icon, size: 18, color: color),
              ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  detail,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            score,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ActionRow({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 19, color: scheme.primary),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 19),
          const SizedBox(height: 10),
          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _MapTag extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MapTag({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(99),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 12,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15),
            const SizedBox(width: 5),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoutePainter extends CustomPainter {
  final Color roadColor;
  final Color routeColor;

  _RoutePainter({
    required this.roadColor,
    required this.routeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final road = Paint()
      ..color = roadColor
      ..strokeWidth = 26
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final route = Paint()
      ..color = routeColor
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final p = Path()
      ..moveTo(size.width * .17, size.height * .80)
      ..cubicTo(
        size.width * .28,
        size.height * .52,
        size.width * .48,
        size.height * .74,
        size.width * .58,
        size.height * .45,
      )
      ..cubicTo(
        size.width * .70,
        size.height * .14,
        size.width * .78,
        size.height * .62,
        size.width * .88,
        size.height * .25,
      );

    canvas.drawPath(p, road);
    canvas.drawPath(p, route);
  }

  @override
  bool shouldRepaint(covariant _RoutePainter oldDelegate) =>
      oldDelegate.roadColor != roadColor || oldDelegate.routeColor != routeColor;
}
