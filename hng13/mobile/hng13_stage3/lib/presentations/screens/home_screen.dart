import 'package:flutter/material.dart';

import '../../data/datasources/category_data_source.dart';
import '../../data/models/category_model.dart';
import '../widgets/categories_grid.dart';
import '../widgets/screen_scaffold.dart';
import '../widgets/title_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categories = StaticCategoryDataSourceImpl()
        .getCategories();

    final size = MediaQuery.of(context).size;

    return ScreenScaffold(
      titleSection: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleSection(
            title: 'Discover Beautiful Wallpapers',
            subtitle:
                'Discover curated collections of stunning wallpapers. Browse by category, preview in full-screen, and set your favorites.',
            size: size,
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              Text('See All'),
            ],
          ),
        ],
      ),
      body: CategoriesGrid(categories: categories),
    );
  }
}
