import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/constant/constant.validate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:scipro_website/view/colors/colors.dart';
// import 'package:scipro_website/view/constant/const.dart';
// import 'package:scipro_website/view/constant/constant.validate.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColorBlue,
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 16.0),
              const Text(
                'Please enter your email address to reset your password:',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    border: OutlineInputBorder(),
                  ),
                  validator: checkFieldEmailIsValid),
              const SizedBox(height: 32.0),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: themeColorGreen),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await resetPassword(_emailController.text.trim());
                    }
                  },
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Reset Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> resetPassword(String email) async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) {
        showToast(msg: "Password has been sent to your email address");
        _emailController.clear();
        setState(() {
          isLoading = false;
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast(msg: 'No user found for that email.');
      } else if (e.code == 'invalid-email') {
        showToast(msg: 'Invalid email address format.');
      } else {
        showToast(
            msg:
                'An error occurred while attempting to reset password. Please try again later.');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      showToast(
          msg:
              'An error occurred while attempting to reset password. Please try again later.');
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }
}