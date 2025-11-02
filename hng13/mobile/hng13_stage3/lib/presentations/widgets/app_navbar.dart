import 'package:flutter/material.dart';
import 'package:hng13_stage3/core/utils/responsive.dart';

import '../../core/constants/app_colors.dart';
import 'nav_item.dart';

class AppNavbar extends StatefulWidget {
  const AppNavbar({super.key});

  @override
  State<AppNavbar> createState() => _AppNavbarState();
}

class _AppNavbarState extends State<AppNavbar> {
  int _activeIndex = 0;

  final List<Map<String, String>> _navItems = [
    {"title": "Home", "icon": "assets/icons/home.png", "route": "/home"},
    {"title": "Browse", "icon": "assets/icons/browse.png", "route": "/browse"},
    {
      "title": "Favourites",
      "icon": "assets/icons/favorites.png",
      "route": "/favorite",
    },
    {
      "title": "Settings",
      "icon": "assets/icons/settings.png",
      "route": "/setting",
    },
  ];

  void _updateActiveIndex() {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute != null) {
      final index = _navItems.indexWhere(
        (item) => item['route'] == currentRoute,
      );
      if (index != -1 && _activeIndex != index) {
        setState(() {
          _activeIndex = index;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _updateActiveIndex();

    return Container(
      color: AppColors.whiteColor,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        children: [
          TextButton.icon(
            onPressed: () {},
            icon: Image.asset('assets/icons/logo.png', fit: BoxFit.contain),
            label: Text(
              "Wallpaper Studio",
              style: TextStyle(fontSize: 14, color: AppColors.textPrimary),
            ),
          ),
          const Spacer(),
          if (Responsive.isDesktop(context))
            Row(
              children: List.generate(
                _navItems.length,
                (index) => NavItem(
                  title: _navItems[index]['title']!,
                  isActive: _activeIndex == index,
                  iconPath: _navItems[index]['icon']!,
                  onTap: () {
                    setState(() => _activeIndex = index);
                    Navigator.pushNamed(context, _navItems[index]['route']!);
                  },
                ),
              ),
            )
          else
            PopupMenuButton<int>(
              icon: const Icon(Icons.menu, color: AppColors.textPrimary),
              offset: const Offset(0, 40),
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (index) {
                setState(() => _activeIndex = index);
              },
              itemBuilder: (context) {
                return List.generate(
                  _navItems.length,
                  (index) => PopupMenuItem<int>(
                    value: index,
                    child: Row(
                      children: [
                        Image.asset(
                          _navItems[index]["icon"]!,
                          width: 20,
                          height: 20,
                          color: AppColors.textPrimary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          _navItems[index]["title"]!,
                          style: TextStyle(
                            fontWeight: _activeIndex == index
                                ? FontWeight.w500
                                : FontWeight.normal,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
