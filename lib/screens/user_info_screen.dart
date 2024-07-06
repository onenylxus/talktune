import 'dart:io';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:talktune/utils/utils.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  static const routeName = '/user-info';

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final faker = Faker();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  image == null
                      ? CircleAvatar(
                          backgroundImage:
                              NetworkImage(faker.image.image(random: true)),
                          radius: 64,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(image!),
                          radius: 64,
                        ),
                  Positioned(
                    left: 80,
                    bottom: -10,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: size.width * 0.85,
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your name',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.done),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
