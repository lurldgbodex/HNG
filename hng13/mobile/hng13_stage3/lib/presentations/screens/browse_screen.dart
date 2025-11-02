import 'package:flutter/material.dart';

import '../../data/datasources/category_data_source.dart';
import '../widgets/categories_grid.dart';
import '../widgets/screen_scaffold.dart';
import '../widgets/title_section.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      titleSection: TitleSection(
        title: 'Browse Categories',
        subtitle: 'Explore our curated collections of stunning wallpapers',
        size: MediaQuery.of(context).size,
        hasIcon: true,
      ),
      body: CategoriesGrid(
        categories: StaticCategoryDataSourceImpl().getCategories(),
      ),
    );
  }
}
