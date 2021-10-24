import 'package:flutter/material.dart';
import 'package:storify/languages/English.dart';
import 'package:storify/languages/Hindi.dart';
import 'package:storify/languages/Marathi.dart';
import 'package:storify/notifier/theme_provider.dart';

import 'package:storify/languages/Telugu.dart';

class Languages extends StatefulWidget {
  @override
  _LanguagesState createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(child: Text("Languages")),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(),
            child: ChangeThemeButtonWidget(),
          ), //dark mode toggle
        ],
      ),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80.0),
          child: ListView(shrinkWrap: true, children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Center(
                child: Text(
                  "Language Specific Stories",
                  style: TextStyle(color: Colors.purple.shade300, fontSize: 20),
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => English()),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.arrow_drop_down_circle),
                      title: const Text('English'),
                      trailing: Image.asset(
                        'assets/image_sample.jpg',
                        height: 500,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Hindi()),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.arrow_drop_down_circle),
                      title: const Text('Hindi'),
                      trailing: Image.asset(
                        'assets/image_01.png',
                        height: 500,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    // Image.asset(
                    //   'assets/image_01.png',
                    //),
                  ],
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Telugu()),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.arrow_drop_down_circle),
                      title: const Text('Telugu'),
                      trailing: Image.asset(
                        'assets/image_02.jpg',
                        height: 500,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    // Image.asset(
                    //   'assets/image_02.jpg',
                    // ),
                  ],
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Marathi()),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.arrow_drop_down_circle),
                      title: const Text('Marathi'),
                      trailing: Image.asset(
                        'assets/image_03.jpg',
                        height: 500,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    // Image.asset(
                    //   'assets/image_03.jpg',
                    // ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
