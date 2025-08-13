import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user.dart';

class profileDome extends StatelessWidget {
  const profileDome({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
                "Name: ${userProvider.getUser().name.toString()}",
              style: TextStyle(fontSize: 30),
            ),
            Text(""
                "Phone: ${userProvider.getUser().phone.toString()}",
              style: TextStyle(fontSize: 30),
            ),
            Text(""
                "Email: ${userProvider.getUser().email.toString()}",
              style: TextStyle(fontSize: 30),
            ),
            Text(""
                "address: ${userProvider.getUser().address.toString()}",
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
