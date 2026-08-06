import 'package:flutter/material.dart';
import '../../models/config/app_dimensions.dart';
import '../../styles/app_styles.dart';

/// Widget genérico para el header de las pantallas
class ScreenHeader extends StatelessWidget {
  final AppDimensions d;
  final ColorScheme colorScheme;
  final String title;
  final String? subtitle;
  final VoidCallback onBack;
  final Widget? trailing;

  const ScreenHeader({
    super.key,
    required this.d,
    required this.colorScheme,
    required this.title,
    this.subtitle,
    required this.onBack,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: d.screenHeight * 0.015 + d.spacingM,
        left: d.horizontalPadding,
        right: d.horizontalPadding,
        bottom: d.spacingS,
      ),
      child: Row(
        children: [
          Container(
            width: d.buttonHeight,
            height: d.buttonHeight,
            decoration: BoxDecoration(
              color: colorScheme.surface.withValues(alpha: 0.95),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.onSurface.withValues(alpha: 0.3),
                  blurRadius: d.blurRadius,
                  offset: Offset(0, d.spacingXS),
                ),
              ],
            ),
            child: IconButton(
              onPressed: onBack,
              icon: Icon(
                Icons.arrow_back,
                color: colorScheme.onSurface,
                size: d.iconSizeM,
              ),
            ),
          ),
          SizedBox(width: d.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.title(d).copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: d.spacingXS),
                  Text(
                    subtitle!,
                    style: AppTextStyles.body(d).copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            SizedBox(width: d.spacingM),
            trailing!,
          ],
        ],
      ),
    );
  }
}
