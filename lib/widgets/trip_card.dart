// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:concierge/screens/detail_trip_view.dart';
// import 'package:concierge/screens/models/trip.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// Widget buildTripCard(
//   BuildContext context,
//   DocumentSnapshot document,
// ) {
//   final trip = Trip.fromSnapshot(document);
//   // final tripType = trip.types();

//   var trip;
//   return new Container(
//     child: Card(
//       child: InkWell(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
//                   child: Row(children: <Widget>[
//                     Text(
//                       trip.title,
//                       // style: GoogleFonts.seymourOne(fontSize: 20.0),
//                     ),
//                     Spacer(),
//                   ]),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
//                   child: Row(children: <Widget>[
//                     Text(
//                         "${DateFormat('MM/dd/yyyy').format(trip.startDate).toString()} - ${DateFormat('MM/dd/yyyy').format(trip.endDate).toString()}"),
//                     Spacer(),
//                   ]),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
//                   child: Row(
//                     children: <Widget>[
//                       // Text(
//                       //   "\$${(trip.budget == null) ? "n/a" : trip.budget.toStringAsFixed(2)}",
//                       //   style: new TextStyle(fontSize: 35.0),
//                       // ),
//                       // Spacer(),
//                       // (tripType.containsKey(trip.travelType))
//                       //     ? tripType[trip.travelType]
//                       //     : tripType["other"],
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//           onTap: () {
//             // if (loadBannerAd == true) {
//             //   Navigator.push(context, MaterialPageRoute(builder: (context) => DetailTripView(trip: trip))).then((value) {
//             //     AdMobService.showHomeBannerAd();
//             //   });
//             // } else {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => DetailTripView(trip: trip)));
//           }),
//     ),
//   );
// }
