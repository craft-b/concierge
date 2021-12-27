import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class PostDetail extends StatelessWidget {
  DocumentSnapshot trip;

  PostDetail({Key? key, required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // DateTime? postTime = DateTime.tryParse(trip['startDate']);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Itinerary'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('trips')
                .orderBy('startDate', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData ||
                  snapshot.data!.docs.length == 0 ||
                  // ignore: unnecessary_null_comparison
                  snapshot.data!.docs == null) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            '${DateFormat("MMM dd, yyyy").format(trip['startDate'].toDate()).toString()}'
                            '-'
                            '${DateFormat("MMM dd, yyyy").format(trip['endDate'].toDate()).toString()}',
                            style: TextStyle(fontSize: 20)),
                        Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.height * 0.4,
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: const Image(
                              image: AssetImage('assets/images/italy.jpg'),
                              fit: BoxFit.contain),
                        ),
                        Text("${trip['title']} ",
                            style: const TextStyle(fontSize: 18)),
                        Text('To Do List: ' '${trip['itenerary']}',
                            style: const TextStyle(fontSize: 25))
                      ],
                    ),
                  ),
                );
              }
            }));
  }
}
