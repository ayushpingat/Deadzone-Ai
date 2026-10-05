import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final String label;
  final Color color;
  final Color background;
  final IconData icon;

  const StatusChip({
    super.key,
    required this.label,
    required this.color,
    required this.background,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                  letterSpacing: .3,
                ),
          ),
        ],
      ),
    );
  }
}
