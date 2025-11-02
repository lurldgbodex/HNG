import 'package:flutter/material.dart';

import '../../core/utils/responsive.dart';

class TitleSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final Size size;
  final bool hasIcon;

  const TitleSection({
    super.key,
    required this.size,
    required this.title,
    required this.subtitle,
    this.hasIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: [Color(0xFFFBB03B), Color(0xFFEC0C43)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ).createShader(bounds);
          },

          child: Text(
            title,
            style: TextStyle(
              fontSize: Responsive.isDesktop(context)
                  ? 50
                  : Responsive.isTablet(context)
                  ? 35
                  : 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: size.width * 0.5,
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: Responsive.isDesktop(context)
                      ? 20
                      : Responsive.isTablet(context)
                      ? 16
                      : 14,
                ),
              ),
            ),
            hasIcon
                ? Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.grid_view_outlined),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.format_list_numbered_rtl_sharp),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ],
    );
  }
}
