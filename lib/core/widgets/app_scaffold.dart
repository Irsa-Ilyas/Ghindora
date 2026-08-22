import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;

  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.floatingActionButton,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ?? (title != null ? AppBar(title: Text(title!)) : null),
      body: SafeArea(child: body),
      floatingActionButton: floatingActionButton,
    );
  }
}
