import 'package:flutter/material.dart';
import '../models/connectivity_data.dart';
import '../widgets/app_logo.dart';

class HistoryScreen extends StatelessWidget {
  final List<ConnectivityEvent> events;

  const HistoryScreen({super.key, required this.events});

  Color _color(BuildContext context, int score) {
    final scheme = Theme.of(context).colorScheme;
    if (score >= 80) return scheme.tertiary;
    if (score >= 40) return const Color(0xFFF59E0B);
    return scheme.error;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      children: [
        BrandHeader(
          title: 'Connectivity history',
          subtitle: 'Your recent Home → College pattern',
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
                'Coverage trend',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 130,
                child: CustomPaint(
                  painter: _CoveragePainter(
                    events: events,
                    lineColor: scheme.primary,
                    gridColor: scheme.outlineVariant,
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        ...events.map(
          (event) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: Row(
                children: [
                  Text(
                    event.time,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      color: _color(context, event.score),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      event.label,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    '${event.score}%',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CoveragePainter extends CustomPainter {
  final List<ConnectivityEvent> events;
  final Color lineColor;
  final Color gridColor;

  _CoveragePainter({
    required this.events,
    required this.lineColor,
    required this.gridColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (events.length < 2) return;

    final line = Paint()
      ..color = lineColor
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final grid = Paint()
      ..color = gridColor
      ..strokeWidth = 1;

    for (int i = 1; i < 4; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final path = Path();

    for (int i = 0; i < events.length; i++) {
      final x = size.width * i / (events.length - 1);
      final y = size.height - (events[i].score / 100) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      canvas.drawCircle(
        Offset(x, y),
        4.5,
        Paint()..color = lineColor,
      );
    }

    canvas.drawPath(path, line);
  }

  @override
  bool shouldRepaint(covariant _CoveragePainter oldDelegate) {
    return oldDelegate.events != events ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.gridColor != gridColor;
  }
}
