// Flutter imports:
import 'package:flutter/material.dart';

// Loader class
class WidgetLoader extends StatelessWidget {
  const WidgetLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
