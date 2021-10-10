import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_code/screens/auth/auth_view_model/auth_view_model.dart';
import 'package:flutter_default_code/services/global_methods.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatefulWidget {
  static const routeName = '/ForgetPassword';

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String _emailAddress = '';
  final _formKey = GlobalKey<FormState>();
  late AuthViewModel authViewModel;

  @override
  void initState() {
    super.initState();
    authViewModel = Provider.of<AuthViewModel>(context, listen: false);
  }

  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      try {
        await authViewModel.forgotPasswordWithEmail(
            email: _emailAddress.trim().toLowerCase());
        Fluttertoast.showToast(
            msg: "A mail has been sent.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pop(context);
      } on FirebaseAuthException catch (error) {
        authViewModel.setLoading(false);
        GlobalMethods.authErrorHandle(
            error.message ?? 'Something went wrong', context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Forget password',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                key: ValueKey('email'),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email Address',
                    fillColor: Theme.of(context).backgroundColor),
                onSaved: (value) {
                  _emailAddress = value!;
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Consumer<AuthViewModel>(builder: (context, authViewModel, child) {
            return (authViewModel.isLoading == true)
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side:
                                BorderSide(color: Theme.of(context).cardColor),
                          ),
                        )),
                        onPressed: _submitForm,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Reset password',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 17),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Ionicons.key,
                              size: 18,
                            )
                          ],
                        )),
                  );
          }),
        ],
      ),
    );
  }
}
