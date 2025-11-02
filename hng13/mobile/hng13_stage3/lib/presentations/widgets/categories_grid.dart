import 'package:flutter/material.dart';

import '../../core/utils/responsive.dart';
import '../../data/models/category_model.dart';
import 'category_card.dart';

class CategoriesGrid extends StatelessWidget {
  final List<CategoryModel> categories;

  const CategoriesGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = Responsive.isDesktop(context)
        ? 3
        : Responsive.isTablet(context)
        ? 2
        : 1;

    return GridView.builder(
      itemCount: categories.length,
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) =>
          CategoryCard(category: categories[index]),
    );
  }
}
