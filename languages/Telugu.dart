import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:storify/notifier/theme_provider.dart';

class Telugu extends StatefulWidget {
  @override
  _TeluguState createState() => _TeluguState();
}

class _TeluguState extends State<Telugu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Telugu"),
          actions: [
            ChangeThemeButtonWidget(), //dark mode toggle
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Telugu').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return PageView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.network(
                          snapshot.data.docs.elementAt(index)['image'],
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          fit: BoxFit.fitWidth,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          snapshot.data.docs.elementAt(index)['name'],
                          style: TextStyle(fontSize: 30.0),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          snapshot.data.docs.elementAt(index)['category'],
                          style: TextStyle(fontSize: 20.0),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data.docs
                                      .elementAt(index)['chapters'],
                                  style: TextStyle(fontSize: 10.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            Icons.swipe,
                            size: 24.0,
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else {
                debugPrint('Loading...');
                return Center(
                  child: Text('Loading...'),
                );
              }
            },
          ),
        ));
  }
}
