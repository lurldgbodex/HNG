import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';
import '../providers/product_provider.dart';
import '../themes/theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/image_picker_bottom_sheet.dart';
import '../widgets/product_image.dart';

class AddEditScreen extends ConsumerStatefulWidget {
  final Product? product;
  const AddEditScreen({super.key, this.product});

  @override
  ConsumerState<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends ConsumerState<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  late TextEditingController _priceController;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    final product = widget.product;
    _nameController = TextEditingController(text: product?.name ?? '');
    _quantityController = TextEditingController(
      text: product?.quantity.toString() ?? '0',
    );
    _priceController = TextEditingController(
      text: product?.price.toStringAsFixed(2) ?? '0.00',
    );
    _imagePath = product?.imagePath;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final res = await showModalBottomSheet(
      context: context,
      builder: (_) => const ImagePickerBottomSheet(),
    );
    if (res != null) setState(() => _imagePath = res);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.product != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Product' : 'Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                  child: SizedBox(
                    height: 200,
                    child: _imagePath == null
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.camera_alt, size: 40),
                                SizedBox(height: 8),
                                Text('Tap to add image'),
                              ],
                            ),
                          )
                        : ProductImage(imagePath: _imagePath),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text('Name'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 2,
                    ),
                  ),
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Enter product name' : null,
              ),
              const SizedBox(height: 12),
              const Text('Quantity'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 2,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (v) => int.tryParse(v ?? '') == null
                    ? 'Enter a valid number'
                    : null,
              ),
              const SizedBox(height: 12),
              const Text('Price'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 2,
                    ),
                  ),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (v) => double.tryParse(v ?? '') == null
                    ? 'Enter a valid price'
                    : null,
              ),
              const SizedBox(height: 12),
              CustomButton(
                onPressed: () async {
                  final currentContext = context;

                  if (!_formKey.currentState!.validate()) return;
                  final name = _nameController.text.trim();
                  final price = double.parse(_priceController.text.trim());
                  final quantity = int.parse(_quantityController.text.trim());

                  if (isEdit) {
                    final updated = Product(
                      id: widget.product!.id,
                      name: name,
                      price: price,
                      quantity: quantity,
                      imagePath: _imagePath,
                    );
                    await ref
                        .read(productsProvider.notifier)
                        .updateProduct(updated);
                  } else {
                    await ref
                        .read(productsProvider.notifier)
                        .addProduct(
                          name: name,
                          quantity: quantity,
                          price: price,
                          imagePath: _imagePath,
                        );
                  }
                  if (!currentContext.mounted) return;
                  Navigator.of(currentContext).pop();
                },
                text: isEdit ? 'Save Changes' : 'Add Product',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
