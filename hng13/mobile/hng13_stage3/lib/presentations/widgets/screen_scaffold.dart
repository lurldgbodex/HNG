import 'package:flutter/material.dart';
import 'package:hng13_stage3/core/utils/responsive.dart';

import '../../core/constants/app_colors.dart';
import 'app_navbar.dart';

class ScreenScaffold extends StatelessWidget {
  final Widget titleSection;
  final Widget body;

  const ScreenScaffold({
    super.key,
    required this.titleSection,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Responsive.isMobile(context) ? SafeArea(child: _body()) : _body(),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const AppNavbar(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
          child: titleSection,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 48, right: 48, bottom: 48),
            child: body,
          ),
        ),
      ],
    );
  }
}
