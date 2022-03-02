import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;
  final Color backgroundColor;

  CustomAppBar({
    Key? key, 
    required this.title, 
    required this.backgroundColor
  }) : preferredSize = const Size.fromHeight(50.0), super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(title),
      backgroundColor: backgroundColor,
    );
  }
}