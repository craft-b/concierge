import 'package:concierge/widgets/post.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
// import 'entry_lists.dart';
// import '/screens/camera_screen.dart';

class PostsList extends StatefulWidget {
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                return Scaffold(
                    // backgroundColor: Colors.blue,
                    appBar: AppBar(
                      title: const Text('Upcoming Trips'),
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    body: Center(
                        child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var trip = snapshot.data!.docs[index];

                                return Dismissible(
                                  key: Key(trip.toString()),
                                  // Provide a function that tells the app
                                  // what to do after an item has been swiped away.
                                  onDismissed: (direction) {
                                    // Remove the item from the data source.
                                    setState(() {
                                      snapshot.data!.docs.removeAt(index);
                                    });

                                    // Then show a snackbar.
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Bye Bye!')));
                                  },

                                  // Show a red background as the item is swiped away.
                                  background:
                                      Container(color: Colors.yellow[800]),

                                  child: ListTile(
                                    leading: tileImage(context),
                                    title: Text(trip['title'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                    subtitle: Text(
                                        '${DateFormat("MMM dd, yyyy").format(trip['startDate'].toDate()).toString()}'
                                        '-'
                                        '${DateFormat("MMM dd, yyyy").format(trip['endDate'].toDate()).toString()}'),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PostDetail(trip: trip)));
                                    },
                                  ),
                                );
                              }),
                        ),
                      ],
                    )));
              }
            }));
  }
}

Widget tileImage(BuildContext context) {
  return ClipRRect(
    borderRadius:
        BorderRadius.circular(MediaQuery.of(context).size.width * .3 * .22),
    child: Container(
        child: const Image(image: AssetImage('assets/images/italy.jpg')),
        width: MediaQuery.of(context).size.width * .3,
        height: MediaQuery.of(context).size.width * .3),
  );
}
