import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:semifinal/component/custom_button.dart';
import 'package:semifinal/component/text_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController? Email = TextEditingController();
  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: Email!.text.trim());
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Send To Your Email ")));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Your Email isn't defined")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 212, 113, 83),
        elevation: 30,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Container(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Enter your Email to Reset Password",
                  style: Theme.of(context).textTheme.headline5!,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text_Field(
                  TypeInput: "Email",
                  prefixIcon: const Icon(Icons.email),
                  controller: Email,
                  obscure: false,
                ),

                //------------------------------------------------------------------------------

                MyButton(
                  onTap: () {
                    passwordReset();
                  },
                  text: "Reset",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
