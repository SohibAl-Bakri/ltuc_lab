import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:line_icons/line_icons.dart';
import 'package:semifinal/component/custom_button.dart';
import 'package:semifinal/component/google_sign_in.dart';
import 'package:semifinal/component/rich_text.dart';
import 'package:semifinal/component/text_field.dart';
import 'package:ionicons/ionicons.dart';
import 'package:semifinal/screens/User.dart';
import 'package:semifinal/screens/admin.dart';

CollectionReference userR = FirebaseFirestore.instance.collection('users');
CollectionReference adminR = FirebaseFirestore.instance.collection('admin');

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const rich_text(),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Sign in',
                style: TextStyle(
                    fontSize: 30,
                    color: Color(0xffe46b10),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/1.png"))),
            ),
            Text_Field(
              obscure: false,
              controller: email,
              TypeInput: "Email",
              prefixIcon: const Icon(Icons.email),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                obscureText: showPassword,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      showPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  prefixIcon: const Icon(LineIcons.doubleCheck),
                  hintText: 'Enter Your Password.',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'password',
                  labelStyle:
                      const TextStyle(color: Colors.black, fontSize: 15),
                  hintStyle:
                      const TextStyle(color: Colors.black87, fontSize: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                controller: password,
                maxLines: 1,
                maxLength: 40,
                cursorColor: Colors.black,
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "forget_password");
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(
                    color: Color(0xffe46b10), fontStyle: FontStyle.italic),
              ),
            ),
            MyButton(
                onTap: () async {
                  try {
                    var authin = FirebaseAuth.instance;
                    //* user
                    UserCredential user =
                        await authin.signInWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                    if (authin.currentUser!.email == 'h@gmail.com') {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Logined in")));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => AdminPage())));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Logined in")));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => UserPage())));
                    }
                  } catch (e) {
                    if (email.text.isEmpty && password.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Please Enter Your Email and password "),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Sorry Invalid Email Or Password"),
                        ),
                      );
                    }
                  }
                },
                text: "Login"),
            Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "sign_up");
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sign in With google account"),
                  IconButton(
                      onPressed: () {
                        GoogleLogin().googlelogin();
                      },
                      icon: Icon(Ionicons.logo_google))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
