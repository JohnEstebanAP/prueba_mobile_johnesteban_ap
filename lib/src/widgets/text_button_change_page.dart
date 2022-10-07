import 'package:flutter/material.dart';

class TextButtonChangePage extends StatelessWidget {
  final String nameNextPage;
  final String title;

  const TextButtonChangePage({
    Key? key,
    required this.nameNextPage,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => Navigator.pushNamed(context, nameNextPage),
        style: ButtonStyle(
            overlayColor:
                MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
            shape: MaterialStateProperty.all(const StadiumBorder())),
        child: Text(title,
            style: const TextStyle(fontSize: 18, color: Colors.white70)));
  }
}
