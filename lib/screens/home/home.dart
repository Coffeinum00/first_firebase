import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/auth/data/providers/auth_state.dart';
import 'package:flutter_firebase/screens/home/widgets/car_modal.dart';
import 'package:provider/provider.dart';

import 'data/models/cars_model.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  List<String> documentsID = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthState>(context, listen: false).signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('cars').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<Cars> _listOfCars =
                      snapshot.data!.docs.map((DocumentSnapshot e) {
                    Map<String, dynamic> data =
                        e.data()! as Map<String, dynamic>;

                    return Cars.fromJson(data);
                  }).toList();

                  documentsID =
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    return document.id;
                  }).toList();

                  return ListView.builder(
                      itemCount: _listOfCars.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Cars _car = _listOfCars[index];
                        return listItem(_car, documentsID[index], context);
                      });
                }
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Cars data = Cars(model: 'Camry', brand: 'Toyota');
          FirebaseFirestore.instance.collection('cars').add(data.toJson());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget listItem(Cars car, documentID, context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd ||
            direction == DismissDirection.endToStart) {
          FirebaseFirestore.instance
              .collection('cars')
              .doc(documentID)
              .delete();
        }
      },
      child: ListTile(
        title: Text(car.brand!),
        subtitle: Text(car.model!),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => Dialog(
                child: CarModal(
                  car: car,
                  docID: documentID,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
