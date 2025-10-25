import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImagePickerBottomSheet extends StatefulWidget {
  const ImagePickerBottomSheet({super.key});

  @override
  State<ImagePickerBottomSheet> createState() => _ImagePickerBottomSheetState();
}

class _ImagePickerBottomSheetState extends State<ImagePickerBottomSheet> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _take(ImageSource source) async {
    final xfile = await _picker.pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 1200,
    );
    if (xfile == null) return;

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = path.basename(xfile.path);
    final saved = await File(xfile.path).copy('${appDir.path}/$fileName');

    if (!mounted) return;
    Navigator.of(context).pop(saved.path);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Take photo'),
            onTap: () => _take(ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Choose from gallery'),
            onTap: () => _take(ImageSource.gallery),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
