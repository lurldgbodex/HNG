import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../data/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Image.asset(
            category.imagePath,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black54, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  category.description,
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.whiteTransparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "${category.wallpapersCount} wallpapers",
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
