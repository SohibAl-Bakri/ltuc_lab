import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:semifinal/component/custom_button.dart';
import 'package:semifinal/component/rich_text.dart';
import 'package:semifinal/component/text_field.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: Text("abed"),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/1.png")),
                      ),
                    ),
                    const rich_text(),
                    const SizedBox(
                      height: 50,
                    ),
                    Text_Field(
                      obscure: false,
                      TypeInput: "UserName",
                      prefixIcon: const Icon(Icons.verified_user),
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
                              showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          prefixIcon: const Icon(LineIcons.doubleCheck),
                          hintText: 'enter youre pass',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: 'password',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 20),
                          hintStyle:
                              TextStyle(color: Colors.black87, fontSize: 20),
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
                    const SizedBox(
                      height: 20,
                    ),
                    MyButton(
                        onTap: () async {
                          try {
                            var authin = FirebaseAuth.instance;
                            UserCredential user =
                                await authin.createUserWithEmailAndPassword(
                                    email: email.text, password: password.text);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("its added")));
                            Navigator.pushNamed(context, "login");
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "sorry try to change the pass and the email")));
                          }
                        },
                        text: "Register Now"),
                    SizedBox(height: height * .14),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
