import 'package:concierge/screens/models/trip.dart';
import 'package:flutter/material.dart';

class DaysUntilTrip extends StatelessWidget {
  const DaysUntilTrip(this.trip);
  final Trip trip;

 int getDaysUntilTrip() {
    int diff = trip.startDate!.difference(DateTime.now()).inDays;
    if (diff < 0) {
      diff = 0;
    }
    return diff;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          gradient: const LinearGradient(
            colors: [Colors.lightBlue, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text("${getDaysUntilTrip()}", style: TextStyle(fontSize: 60, color: Colors.white)),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text("days until your trip",
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
