import 'package:concierge/utilities/credentials.dart';
import 'package:flutter/material.dart';

class Trip {
  String? title;
  DateTime? startDate;
  DateTime? endDate;
  List<dynamic>? itenerary;
  // String? notes;
  // String documentID;
  String? photoReference;

  // double budget;
  // Map budgetTypes;
  // String travelType;
  // List ledger;

  Trip({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.itenerary,
    // required this.notes,
    // required this.documentID,
    required this.photoReference,
    // required this.travelType
  });

  // formatting for upload to Firbase when creating the trip
  Map<String, dynamic> toJson() => {
        'title': title,
        'startDate': startDate,
        'endDate': endDate,
        'itinerary': itenerary,
        'photoReference': photoReference,

        // 'notes': notes,
        // 'travelType': travelType,
      };

  // creating a Trip object from a firebase snapshot
  Trip.fromFirestoreMap(map) {
    title = map['title'] ?? 'N/A';
    startDate = map['startDate'].toDate() ?? 'N/A';
    endDate = map['endDate'].toDate() ?? 'N/A';
    itenerary = map['ratings'] ?? [];

    // budget = snapshot.data()['budget'],
    // budgetTypes = snapshot.data()['budgetTypes'],
    // travelType = snapshot.data()['travelType'],
    photoReference = map['photoReference'] ?? 'N/A';
    // notes = snapshot.data()['notes'],}
    // documentID = snapshot.id,
    // saved = snapshot.data()['saved'],
    // ledger = snapshot.data()['ledger'];

    // formatting for upload to Firbase when creating the trip

    // Map<String, Icon> types({color = Colors.black}) => {
    //       "car": Icon(Icons.directions_car, size: 50, color: color),
    //       "bus": Icon(Icons.directions_bus, size: 50, color: color),
    //       "train": Icon(Icons.train, size: 50, color: color),
    //       "plane": Icon(Icons.airplanemode_active, size: 50, color: color),
    //       "ship": Icon(Icons.directions_boat, size: 50, color: color),
    //       "other": Icon(Icons.directions, size: 50, color: color),
  }

  // return the google places image
  Image getLocationImage() {
    const baseUrl = "https://maps.googleapis.com/maps/api/place/photo";
    const maxWidth = "1000";
    final url =
        "$baseUrl?maxwidth=$maxWidth&photoreference=$photoReference&key=$PLACES_API_KEY";
    return Image.network(url, fit: BoxFit.cover);
  }

  int getTotalTripDays() {
    int total = endDate!.difference(startDate!).inDays;
    if (total < 1) {
      total = 1;
    }
    return total;
  }

  int getDaysUntilTrip() {
    int diff = startDate!.difference(DateTime.now()).inDays;
    if (diff < 0) {
      diff = 0;
    }
    return diff;
  }

//   int getCurrentDailyBudget() {
//     if (saved == 0 || saved == null) {
//       return 0;
//     } else {
//       return (saved / getTotalTripDays()).floor();
//     }
//   }

//   Map<String, dynamic> ledgerItem(String amount, String type) {
//     var amountDouble = double.parse(amount);
//     if (type == "spent") {
//       amountDouble = double.parse("-" + amount);
//     }
//     return {
//       'ledger': FieldValue.arrayUnion([
//         {
//           "date": DateTime.now(),
//           "amount": amountDouble,
//         },
//       ]),
//       'saved': FieldValue.increment(amountDouble)
//     };
}
