import 'package:flutter/material.dart';

import '../widgets/screen_scaffold.dart';
import '../widgets/title_section.dart';
import '../widgets/wall_paper_setup.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      titleSection: TitleSection(
        title: 'Settings',
        subtitle: 'Customize your Wallpaper Studio experience',
        size: MediaQuery.of(context).size,
      ),
      body: const WallPaperSetup(),
    );
  }
}
