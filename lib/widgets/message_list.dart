// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:faker/faker.dart';

// Project imports:
import 'package:talktune/widgets/other_message_card.dart';
import 'package:talktune/widgets/self_message_card.dart';

// Message list class
class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    final faker = Faker();
    final info =
        List.generate(faker.randomGenerator.integer(8, min: 4), (index) {
      return {
        'self': faker.randomGenerator.boolean(),
        'text': faker.lorem.sentence(),
        'time': faker.date.justTime(),
      };
    });

    return ListView.builder(
      itemCount: info.length,
      itemBuilder: (context, index) {
        if (info[index]['self'] == true) {
          return SelfMessageCard(
            message: info[index]['text'].toString(),
            date: info[index]['time'].toString(),
          );
        }
        return OtherMessageCard(
          message: info[index]['text'].toString(),
          date: info[index]['time'].toString(),
        );
      },
    );
  }
}
