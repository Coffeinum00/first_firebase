import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/home/data/models/cars_model.dart';

class CarModal extends StatefulWidget {
  CarModal({Key? key, this.car, this.docID}) : super(key: key);

  final Cars? car;
  final String? docID;

  @override
  State<CarModal> createState() => _CarModalState();
}

class _CarModalState extends State<CarModal> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _brandController;
  TextEditingController? _modelController;
  Cars? _car;

  @override
  void initState() {
    _car = widget.car!;
    _brandController = TextEditingController(text: _car!.brand);
    _modelController = TextEditingController(text: _car!.model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                onChanged: (v) {
                  setState(() {
                    _car!.brand = v;
                  });
                },
                controller: _brandController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter brand';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                onChanged: (v) {
                  setState(() {
                    _car!.model = v;
                  });
                },
                controller: _modelController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter model';
                  }
                  return null;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (widget.docID == '') {
                          FirebaseFirestore.instance
                              .collection('cars')
                              .add(_car!.toJson())
                              .whenComplete(() => Navigator.of(context).pop());
                        } else {
                          FirebaseFirestore.instance
                              .collection('cars')
                              .doc(widget.docID)
                              .update(_car!.toJson())
                              .whenComplete(() => Navigator.of(context).pop());
                        }
                      }
                    },
                    child: const Text('Save')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
