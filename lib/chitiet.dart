import 'package:flutter/material.dart';

class PageChiTiet extends StatelessWidget {
  const PageChiTiet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop()
            ? IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back),
              )
            : null,
        title: Text("Chi tiết"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      )
    );
  }
}
