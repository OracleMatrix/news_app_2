import 'package:flutter/material.dart';

class ShowAuthor extends StatelessWidget {
  const ShowAuthor({
    super.key,
    required this.author,
  });

  final String author;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: Text(
        "Author: $author",
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
