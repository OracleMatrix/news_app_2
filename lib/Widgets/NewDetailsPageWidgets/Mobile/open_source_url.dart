import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenSourceUrl extends StatelessWidget {
  const OpenSourceUrl({
    super.key,
    required this.screenSize,
    required this.url,
    required this.source,
  });

  final Size screenSize;
  final String url;
  final String source;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: screenSize.width * 0.6,
        child: ElevatedButton(
          onPressed: () async {
            final Uri uri = Uri.parse(url);
            if (!await launchUrl(uri)) {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.orange,
                  content: Text(
                      'Failed to launch URL!\n Check your internet or try again!'),
                ),
              );
            }
          },
          child: Text("read this from $source"),
        ),
      ),
    );
  }
}