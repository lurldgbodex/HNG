import '../models/category_model.dart';

abstract class StaticCategoryDataSource {
  List<CategoryModel> getCategories();
  CategoryModel? getCategoryByName(String name);
}

class StaticCategoryDataSourceImpl implements StaticCategoryDataSource {
  @override
  List<CategoryModel> getCategories() {
    return _staticCategories;
  }

  @override
  CategoryModel? getCategoryByName(String name) {
    try {
      return _staticCategories.firstWhere((category) => category.name == name);
    } catch (e) {
      return null;
    }
  }

  static final List<CategoryModel> _staticCategories = [
    CategoryModel(
      name: "Nature",
      description: "Mountains, Forest and Landscapes",
      imagePath: "assets/images/nature.jpg",
      wallpapersCount: 3,
    ),
    CategoryModel(
      name: "Abstract",
      description: "Modern geometric and artistic designs",
      imagePath: "assets/images/abstract.jpg",
      wallpapersCount: 4,
    ),
    CategoryModel(
      name: "Urban",
      description: "Cities, architecture and street",
      imagePath: "assets/images/urban.jpg",
      wallpapersCount: 6,
    ),
    CategoryModel(
      name: "Space",
      description: "Cosmos, planets, and galaxies",
      imagePath: "assets/images/space.jpg",
      wallpapersCount: 3,
    ),
    CategoryModel(
      name: "Minimalist",
      description: "Clean, simple, and elegant",
      imagePath: "assets/images/minimalist.jpg",
      wallpapersCount: 6,
    ),
    CategoryModel(
      name: "Animals",
      description: "Wildlife and nature photography",
      imagePath: "assets/images/animal.jpg",
      wallpapersCount: 4,
    ),
  ];
}
