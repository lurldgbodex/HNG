import 'dart:io';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? imagePath;

  const ProductImage({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: imagePath == null
            ? Container(
                color: Colors.grey[200],
                child: const Center(child: Icon(Icons.photo, size: 48)),
              )
            : Image.file(
                File(imagePath!),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
      ),
    );
  }
}
