import 'package:craftybay/data/models/categori_data.dart';
import 'package:craftybay/presentation/ui/utility/color_palette.dart';
import 'package:flutter/material.dart';

class CategoriCard extends StatelessWidget {
  const CategoriCard({
    super.key, required this.categoriData, required this.onTap,
  });

  final CategoriData categoriData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child:  Image.network(categoriData.categoryImg ?? '',height: 50)
            ),
            const SizedBox(height: 8),
            Text(
              categoriData.categoryName ?? '',
              style: TextStyle(
                  fontSize: 15,
                  color: AppColors.primaryColor,
                  letterSpacing: 0.4),
            ),
          ],
        ),
      ),
    );
  }
}
