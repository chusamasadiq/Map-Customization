import 'package:flutter/material.dart';
import 'package:jobtask/theme/theme.dart';
import 'view/homefeed_screen.dart';

void main() {
  runApp(const JobTask());
}

class JobTask extends StatelessWidget {
  const JobTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.myTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeFeedScreen(),
    );
  }
}
