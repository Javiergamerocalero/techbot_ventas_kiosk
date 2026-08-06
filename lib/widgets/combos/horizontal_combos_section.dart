import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/combos/combo.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/widgets/combos/featured_combo_card.dart';

class HorizontalCombosSection extends ConsumerWidget {
  final String title;
  final List<Combo> combos;

  const HorizontalCombosSection({
    super.key,
    required this.title,
    required this.combos,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));

    if (combos.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: d.horizontalPadding),
          child: Text(
            title,
            style: AppTextStyles.sectionHeader(d),
          ),
        ),
        SizedBox(height: d.spacingM),
        SizedBox(
          height: (d.screenWidth * 0.42) / 0.85, // Altura reducida para cards más compactos (0.85 vs 0.75)
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: d.horizontalPadding),
            itemCount: combos.length,
            itemBuilder: (context, index) {
              return FeaturedComboCard(
                combo: combos[index],
                width: d.screenWidth * 0.42, // Mismo ancho que productos para consistencia
              );
            },
          ),
        ),
        SizedBox(height: d.spacingXL),
      ],
    );
  }
}
