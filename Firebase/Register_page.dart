
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'LoginWith.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> fromSate = GlobalKey<FormState>();
  bool _isObscure =true;
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text("Register")),
        body: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: fromSate,
              child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(80.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      TextFormField(
                        validator: (value) => validateString(value),
                        controller: txtEmail,
                        decoration: InputDecoration(label: Text("Email")),
                      ),
                      TextFormField(
                        validator: (value) => validateString(value),
                        obscureText: _isObscure,
                        controller: txtPass,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                            label: Text("Password")),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            bool? validate = fromSate.currentState?.validate();
                            if(validate == true){
                              registerEmailPassword(email: txtEmail.text, password: txtPass.text);
                            }
                          },
                          child: Row(
                            children: [
                              Icon(Icons.vpn_key),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Register"),
                              SizedBox(height: 24,),
                            ],

                          )
                      ),
                      SizedBox(height: 24,),
                    ]),
                  )),
            )));
  }
  validateString(String? value) {
    return value ==null || value.isEmpty ? "Bạn chưa nhập dữ liệu" : null;
  }
}
