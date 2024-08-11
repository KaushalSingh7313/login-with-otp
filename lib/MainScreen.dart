import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(

        child:
        ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.person, size: 30, color: Colors.white),
                  ),
                  SizedBox(
                    height: 100,
                    width: 150,
                    child: Text(
                      'Drawer Header',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, size: 30),
              title: Text('Home'),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(Icons.group_add, size: 30),
              title: Text('Invite Friends'),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(Icons.mail, size: 30),
              title: Text('Login with gmail'),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(Icons.phone, size: 30),
              title: Text('Logion With phone'),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(Icons.settings, size: 30),
              title: Text('Settings'),

              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(Icons.info, size: 30),
              title: Text('About'),
              onTap: () {

              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Main Screen',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: const Text(
          'Welcome to the Main Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
