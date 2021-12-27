import 'package:concierge/screens/models/trip.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  HomeHeader(this.trip);
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [Colors.deepPurple, Colors.blueAccent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                // child: Text("\$${(trip.saved ?? 0.0).floor()}", style: TextStyle(color: Colors.white, fontSize: 65)),
              ),
            ),
            Text("Total Saved", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
