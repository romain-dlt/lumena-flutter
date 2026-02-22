import 'package:flutter/material.dart';
import 'package:lumena_ai/models/models.dart';
import 'package:lumena_ai/widgets/widgets.dart';

class PromptCategories extends StatelessWidget {
  const PromptCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final promptCategories = PromptCategoryModel.getPromptCategories(context);

    return ListView.separated(
      itemCount: promptCategories.length,
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemBuilder: (context, index) {
        return PromptCategory(promptCategory: promptCategories[index]);
      },
    );
  }
}
