import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class loginScreen extends StatelessWidget {
  static const String _title = 'Sustainable City Management';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool _credentials_invalid = false;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
      Container(
      alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
      ),
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Enter credentials',
            style: TextStyle(fontSize: 20),
          )),
      Container(
        padding: const EdgeInsets.all(10),
        child: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'User Name',
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: TextField(
          obscureText: true,
          controller: passwordController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
          ),
        ),
      ),
      /* TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text('Forgot Password',),
            ),*/
      Container(
          height: 50,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: ElevatedButton(
            child: const Text('Login'),
            onPressed: () {
              if (nameController.text.isEmpty || passwordController.text.isEmpty) {
                _credentials_invalid = true;
              }
              else{
                _credentials_invalid = false;
              }

              try {
                Future<UserCredential> userCredential =  FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: nameController.text,
                    password: passwordController.text,
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  print('No user found for that email.');
                } else if (e.code == 'wrong-password') {
                  print('Wrong password provided for that user.');
                }
                else {
                  Navigator.of(context).pushNamed('/dublinBikesMap');
                }
              }

             // print(passwordController.text);
              /*var client = new http.Client();
                    try {
                      print(await client.get('https://flutter.dev/'));
                    }
                    finally {
                    client.close();
                    }*/
            },
          )
      ),
      Container(
        height:100,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 40),
        child: (_credentials_invalid == true) ?
        Text('Username or password cannot be empty') : Text('any'),

      ),
    ])
    );
  }
}
