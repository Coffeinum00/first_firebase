import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/auth/data/providers/auth_state.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthState>(context, listen: false).signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return listItem('Brand', index.toString());
              }),
        ),
      ),
    );
  }

  Widget listItem(brand, model) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd ||
            direction == DismissDirection.endToStart) print('Delete');
      },
      child: ListTile(
        title: Text(brand),
        subtitle: Text(model),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {},
        ),
      ),
    );
  }
}
