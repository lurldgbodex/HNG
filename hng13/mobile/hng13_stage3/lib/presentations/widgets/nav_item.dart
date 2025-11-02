import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class NavItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final String iconPath;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.title,
    required this.isActive,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFF5F5F5) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton.icon(
        onPressed: onTap,
        icon: Image.asset(iconPath, fit: BoxFit.contain),
        label: Text(
          title,
          style: TextStyle(
            fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
            color: AppColors.textPrimary,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
