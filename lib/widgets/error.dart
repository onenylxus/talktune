import 'package:flutter/material.dart';

class WidgetError extends StatelessWidget {
  const WidgetError({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(error));
  }
}
