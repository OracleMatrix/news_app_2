import 'package:flutter/material.dart';
import 'package:news_app_2/Widgets/methods.dart';

class ShowDifferentCategories extends StatelessWidget {
  const ShowDifferentCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            buildCategoryItem(context, "economy", "💰"),
            const VerticalDivider(),
            buildCategoryItem(context, "gaming", "🎮"),
            const VerticalDivider(),
            buildCategoryItem(context, "business", '👨‍💼'),
            const VerticalDivider(),
            buildCategoryItem(context, "sports", '🤼‍♂️'),
            const VerticalDivider(),
            buildCategoryItem(context, "technology", '🤖'),
            const VerticalDivider(),
            buildCategoryItem(context, "general", '📢'),
            const VerticalDivider(),
            buildCategoryItem(context, "health", '👩‍⚕️'),
            const VerticalDivider(),
            buildCategoryItem(context, "science", '🧬'),
            const VerticalDivider(),
            buildCategoryItem(context, "entertainment", '🏁'),
          ],
        ),
      ),
    );
  }
}
