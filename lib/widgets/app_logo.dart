import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool full;

  const AppLogo({
    super.key,
    this.size = 48,
    this.full = false,
  });

  static const String fullAsset = 'assets/images/deadzone_ai_logo.png';
  static const String markAsset = 'assets/images/deadzone_ai_mark.png';

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      full ? fullAsset : markAsset,
      width: size,
      height: size,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
      semanticLabel: 'DeadZone AI logo',
    );
  }
}

class BrandAppBarTitle extends StatelessWidget {
  final String title;

  const BrandAppBarTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AppLogo(size: 38),
        const SizedBox(width: 10),
        Text(title),
      ],
    );
  }
}

class BrandHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const BrandHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 54,
          height: 54,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: const AppLogo(size: 44),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: -.3,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 3),
                Text(
                  subtitle!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
