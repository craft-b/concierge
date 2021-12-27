import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'itinerary_entries.dart';
import 'models/trip.dart';

class NewTripDateView extends StatefulWidget {
  final Trip trip;

  NewTripDateView({Key? key, required this.trip}) : super(key: key);

  @override
  _NewTripDateViewState createState() => _NewTripDateViewState();
}

class _NewTripDateViewState extends State<NewTripDateView> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 7));
  // TextEditingController _searchController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   _searchController.addListener(() {
  //     widget.trip.title = _searchController.text;
  //   });
  // }

  // @override
  // void dispose() {
  //   _searchController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(''),
              backgroundColor: Colors.black,
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
                background: widget.trip.getLocationImage(),
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 200.00,
              delegate: SliverChildListDelegate([
                buildSelectedDetails(context, widget.trip),
                buildButtons(),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget buildButtons() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 8.0),
          //   child: TextField(
          //     // controller: _searchController,
          //     decoration: const InputDecoration(
          //       hintText: 'Destination',
          //       prefixIcon: Icon(Icons.search),
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 25),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: ElevatedButton(
                    child: const Text("Start Date"),
                    onPressed: () async {
                      _selectDate(context);
                    },
                  ),
                ),
                const SizedBox(width: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: ElevatedButton(
                    child: const Text("End Date"),
                    onPressed: () async {
                      _selectdDate(context);
                    },
                  ),
                ),
              ]),
          const SizedBox(height: 20),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: ElevatedButton(
                  child: const Text('Continue'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black)),
                  onPressed: () async {
                    widget.trip.startDate = _startDate;
                    widget.trip.endDate = _endDate;
                    // widget.trip.title = _searchController.text;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyForm(trip: widget.trip)),
                    );
                  }))
        ]);
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _startDate,
        firstDate: DateTime(2019, 8),
        lastDate: DateTime(2100));
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
        // widget.trip.startDate = _startDate;
      });
    }
  }

  _selectdDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _endDate,
        firstDate: DateTime(2019, 8),
        lastDate: DateTime(2100));
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  Widget buildingSelectedDates() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Start Date"),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "${DateFormat('MM-dd').format(_startDate).toString()}",
                    style:
                        const TextStyle(fontSize: 35, color: Colors.deepPurple),
                  ),
                ),
                Text(
                  "${DateFormat('yyyy').format(_startDate).toString()}",
                  style: const TextStyle(color: Colors.deepPurple),
                ),
              ],
            ),
            Container(
                child: const Icon(
              Icons.arrow_forward,
              color: Colors.deepOrange,
              size: 45,
            )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("End Date"),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "${DateFormat('MM-dd').format(_endDate).toString()}",
                    style: TextStyle(fontSize: 35, color: Colors.deepPurple),
                  ),
                ),
                Text(
                  "${DateFormat('yyyy').format(_endDate).toString()}",
                  style: TextStyle(color: Colors.deepPurple),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSelectedDetails(BuildContext context, Trip trip) {
    return Hero(
      tag: "SelectedTrip-${trip.title}",
      transitionOnUserGestures: true,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
          ),
          child: SingleChildScrollView(
            child: Card(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 16.0, bottom: 16.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(trip.title!,
                                    maxLines: 3,
                                    style: const TextStyle(fontSize: 25.0)),
                              ),
                            ],
                          ),
                          buildingSelectedDates(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
