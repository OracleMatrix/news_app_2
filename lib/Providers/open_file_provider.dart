// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class OpenFileProvider extends ChangeNotifier {
  bool isOpening = false;
  Future<void> openFile(
      String url, String fileName, BuildContext context) async {
    try {
      isOpening = true;
      notifyListeners();

      final dir = await getTemporaryDirectory();

      final String validFileName = url.split('/').last;
      final filePath = '${dir.path}/$validFileName';

      final fileExtension = validFileName.split('.').last.toLowerCase();
      const allowedImageExtensions = ['jpg', 'jpeg', 'png', 'gif'];
      const allowedVideoExtensions = ['mp4', 'mkv', 'avi', 'mov'];

      if (!allowedImageExtensions.contains(fileExtension) &&
          !allowedVideoExtensions.contains(fileExtension)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orange,
            content: Text('Only images and videos are allowed to be opened.'),
          ),
        );
        return;
      }

      final response = await http.get(Uri.parse(url));
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      await OpenFilex.open(filePath);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content:
              Text('Failed to open the file!\nCheck internet or try again...'),
        ),
      );
    } finally {
      isOpening = false;
      notifyListeners();
    }
  }
}
