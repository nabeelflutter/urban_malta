import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kappu/components/AppColors.dart';

import '../../models/serializable_model/CategoryResponse.dart';

class CategorySelectionScreen extends StatelessWidget {
  final List<Category> categories;
  final Function(Category)? onCategorySelected;

  CategorySelectionScreen({required this.categories, this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Select a Service',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios_new,color: AppColors.iconColor,))
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(categories[index].name),
              onTap: () {
                Navigator.pop(context, categories[index]);
                // if (onCategorySelected != null) {
                //   onCategorySelected!(categories[index]);
                // }
                // Navigator.pop(context);
              },
            );
          },
        ),
      ),
    );
  }
}
