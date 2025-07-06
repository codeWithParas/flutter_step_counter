

import 'package:flutter/material.dart';
import 'package:flutter_ws_tb/step_counter/HomePageScreen.dart';

import 'note_app/NoteAppScreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController uController = TextEditingController();
  TextEditingController pController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var uName = "qwerty";
  var pName = "1234";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: uController,
                decoration: InputDecoration(labelText: "Enter Username"),
                validator: (String? value) {
                  if(value == null || value.isEmpty || uName != value) {
                    return "Please enter correct username.";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: pController,
                decoration: InputDecoration(labelText: "Enter Password"),
                validator: (String? value) {
                  if(value == null || value.isEmpty) {
                    return "Please enter correct password.";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(onPressed: () {
                // Your thread run here

                if(_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Login Successfully."))
                  );

                  // Switch to homepage

                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => const StepCounterScreen())
                    MaterialPageRoute(builder: (context) => const NoteAppScreen())
                  );

                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Login Failed."))
                  );
                }

              }, child: Text("Login")),
            )
          ],
        ),
      ),
    );
  }
}
