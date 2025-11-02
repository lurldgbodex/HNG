import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../widgets/screen_scaffold.dart';
import '../widgets/title_section.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      titleSection: TitleSection(
        title: 'Saved Wallpapers',
        subtitle: 'Your saved wallpapers collections',
        size: MediaQuery.of(context).size,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/selector.png', fit: BoxFit.contain),
            const SizedBox(height: 16),
            const Text(
              'No Saved Wallpapers',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            const Text(
              'Start saving your favorite wallpapers to see them here',
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 18,
                ),
              ),
              onPressed: () => Navigator.of(context).pushNamed('/browse'),
              child: Text(
                "Browse Wallpapers",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
