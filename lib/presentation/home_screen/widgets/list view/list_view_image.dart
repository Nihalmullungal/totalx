import 'package:flutter/material.dart';

class ListViewImage extends StatelessWidget {
  final String image;
  const ListViewImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      foregroundImage: NetworkImage(image),
      backgroundImage: const AssetImage("assets/images/1user.png"),
    );
  }
}
