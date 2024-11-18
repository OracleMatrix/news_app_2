import 'package:flutter/material.dart';

class NoDataAvailableWidget extends StatelessWidget {
  const NoDataAvailableWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(top: 150.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              size: 80,
              color: Colors.red,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "No Data Available!",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
