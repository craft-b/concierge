
import 'package:concierge/screens/trip_list.dart';
import 'package:concierge/utilities/db_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/trip.dart';

class MyForm extends StatefulWidget {
  final Trip trip;

  const MyForm({Key? key, required this.trip}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  static List<String> friendsList = [""];
  // Trip? trip;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        tripDetails(),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Your Itinerary',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        ..._getFriends(),
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                            child: const Text(
                              'Save',
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                DatabaseMaganger.addTrip(Trip(
                                  title: widget.trip.title,
                                  // documentID: '',
                                  endDate: widget.trip.endDate!,
                                  itenerary: friendsList,
                                  photoReference: '',
                                  startDate: widget.trip.startDate!,
                                  // travelType: ''
                                ));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostsList()),
                                );
                              }
                            }),
                      ]))),
        ));
  }

  Widget tripDetails() {
    return Card(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.trip.title!,
                  style: TextStyle(fontSize: 30, color: Colors.yellow[800]),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Text(
                    "${DateFormat('MMM dd, yyyy').format(widget.trip.startDate!).toString()} - ${DateFormat('MMM dd, yyyy').format(widget.trip.endDate!).toString()}"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// get firends text-fields
  List<Widget> _getFriends() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < friendsList.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: FriendTextFields(i)),
            const SizedBox(
              width: 16,
            ),
            _addRemoveButton(i == friendsList.length - 1, i),
          ],
        ),
      ));
    }
    return friendsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          friendsList.insert(0, "");
        } else {
          friendsList.removeAt(index);
        }
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.black : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.yellow[600],
          size: 25,
        ),
      ),
    );
  }
}

class FriendTextFields extends StatefulWidget {
  final int index;
  const FriendTextFields(this.index, {Key? key}) : super(key: key);
  @override
  _FriendTextFieldsState createState() => _FriendTextFieldsState();
}

class _FriendTextFieldsState extends State<FriendTextFields> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _nameController.text = _MyFormState.friendsList[widget.index];
    });

    return TextFormField(
      controller: _nameController,
      onChanged: (v) => _MyFormState.friendsList[widget.index] = v,
      decoration: const InputDecoration(hintText: 'Add something exciting'),
      validator: (v) {
        if (v!.trim().isEmpty) return 'Don\'t leave me empty';
        return null;
      },
    );
  }
}
