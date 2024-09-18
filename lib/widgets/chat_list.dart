import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:talktune/constants/colors.dart';
import 'package:talktune/screens/chat_screen.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    final faker = Faker();
    final size = faker.randomGenerator.integer(32, min: 8);
    final info = List.generate(size, (index) {
      final seed = faker.randomGenerator.integer(1000);
      return {
        'name': faker.person.name(),
        'message': faker.lorem.sentence(),
        'icon': faker.image.loremPicsum(random: seed),
        'time': faker.date.justTime(),
      };
    });

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: info.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        name: info[index]['name'].toString(),
                        uid: '12345678',
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(
                      info[index]['name'].toString(),
                      style: const TextStyle(fontSize: 18),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        info[index]['message'].toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        info[index]['icon'].toString(),
                      ),
                      radius: 30,
                    ),
                    trailing: Text(
                      info[index]['time'].toString(),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: colorDivider,
                indent: 85,
              ),
            ],
          );
        },
      ),
    );
  }
}
