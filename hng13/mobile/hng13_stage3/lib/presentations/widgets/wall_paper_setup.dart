import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/responsive.dart';

class WallPaperSetup extends StatefulWidget {
  const WallPaperSetup({super.key});

  @override
  State<WallPaperSetup> createState() => _WallPaperSetupState();
}

class _WallPaperSetupState extends State<WallPaperSetup> {
  String _selectedQuality = 'High (Best Quality)';
  bool _notificationEnabled = true;

  final List<String> _qualities = ['Low', 'medium', 'High (Best Quality)'];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(32),
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Responsive.isTablet(context)
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLeftPanel(),
                    const SizedBox(height: 40),
                    _buildPhonePreview(),
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 3, child: _buildLeftPanel()),
                  const SizedBox(width: 40),
                  Expanded(flex: 2, child: _buildPhonePreview()),
                ],
              ),
      ),
    );
  }

  Widget _buildLeftPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Wallpaper Setup",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Configure your wallpaper settings and enable auto-rotation",
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 32),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Image Quality",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: _selectedQuality,
                    items: _qualities
                        .map(
                          (q) => DropdownMenuItem<String>(
                            value: q,
                            child: Text(q, style: TextStyle(fontSize: 12)),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() => _selectedQuality = val!);
                    },
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Notification",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Get notified about new wallpapers and updates",
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
              Switch(
                value: _notificationEnabled,
                onChanged: (value) =>
                    setState(() => _notificationEnabled = value),
                activeThumbColor: AppColors.primary,
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 150,
              height: 40,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                  side: BorderSide(color: Colors.grey.shade300),
                  backgroundColor: Colors.grey.shade100,
                ),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                ),
                child: const Text(
                  "Save Settings",
                  style: TextStyle(color: AppColors.whiteColor),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPhonePreview() {
    return Image.asset("assets/images/phone.png");
  }
}
