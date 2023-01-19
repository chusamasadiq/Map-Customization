import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  Map<String, dynamic>? userData;

  MyDrawer({Key? key, this.userData}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: const [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                accountName: Text('Usama Sadiq'),
                accountEmail: Text(''),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/avatar.png',
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(CupertinoIcons.home, color: Colors.black38),
              title: Text(
                'Home',
                textScaleFactor: 1.2,
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.black38),
              title: Text(
                'Logout',
                textScaleFactor: 1.2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
