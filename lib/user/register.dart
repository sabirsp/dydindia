import 'package:dydindia/services/network_helper.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import '../homepage.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue,Colors.lightBlueAccent,Colors.deepPurple],
            begin: Alignment.topCenter,
            stops: [0,150,300],
          ),

        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: RegisterForm(),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool showSpiner= false;
  bool otpFieldVisibility = false;
  bool gobuttonVisibility = true;
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _professionController = TextEditingController();
  final _interestController = TextEditingController();


  final _formKey = GlobalKey<FormState>();


  // TODO: Check Whether Mobile Registered or not



  void nextScreen() async {
    HTTPHelper helper = HTTPHelper(
        'http://dydindia.com/admin/examlist/getexamdata');
    int rowCount = 0;
    var examData = await helper.getResponse();
    for (var k in examData) {
      rowCount++;
    }

    print(examData);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return HomePage(
              examData: examData,
              rowCount: rowCount,
            );
          }
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image(
                  image: NetworkImage('http://dydindia.com/admin/image/Logo.png'),
                  width: 100,
                  height: 100,
                ),
                Text('Registration Form',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.white
                ),),
                SizedBox(height: 30,),
                CustomInputField(
                  controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Your Email',
                obscureText: false,
                icon: Icons.email,
                maxLength: 150,),
                CustomInputField(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  hintText: 'Your Password...',
                obscureText: true,
                maxLength: 50,
                icon: Icons.lock_outline,),
                CustomInputField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  hintText: 'Your Mobile No',
                obscureText: false,
                icon: Icons.phone,
                maxLength: 10,),
                CustomInputField(
                  controller: _professionController,
                  keyboardType: TextInputType.text,
                  hintText: 'Your Current Profession..',
                  obscureText: false,
                  icon: Icons.phone,
                  maxLength: 200,),
                CustomInputField(
                  controller: _interestController,
                  keyboardType: TextInputType.text,
                  hintText: 'Your Area of Interest',
                  obscureText: false,
                  icon: Icons.phone,
                  maxLength: 200,),
                RaisedButton(
                  onPressed: (){

                  },
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text('Submit'),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CustomInputField extends StatelessWidget {

  final TextInputType keyboardType;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final int maxLength;
  final IconData icon;
  const CustomInputField({this.icon,this.maxLength,this.obscureText,this.keyboardType, this.hintText, this.controller}) ;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      keyboardType: keyboardType,
      controller: controller,
      maxLength: maxLength,
      obscureText: obscureText,
      decoration: InputDecoration(

        prefixIcon: Icon(
          icon,
          color: Colors.blueGrey,
        ),
        hintText: hintText,
        hintStyle: TextStyle(

        ),
        fillColor: Colors.white70,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        )
      ),

    );
  }
}

