// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:talktune/constants/colors.dart';

// Message card from others class
class OtherMessageCard extends StatelessWidget {
  const OtherMessageCard({
    super.key,
    required this.message,
    required this.date,
  });

  final String message;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: colorMessageOther,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 30,
                  top: 5,
                  bottom: 20,
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 2,
                right: 10,
                child: Text(
                  date,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
