import 'package:dydindia/loading.dart';
import 'package:dydindia/services/network_helper.dart';
import 'package:dydindia/user/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../homepage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

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
            body: LoginForm(),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool showSpiner= false;
  bool otpFieldVisibility = false;
  bool gobuttonVisibility = true;
  bool verifybuttonVisibility = false;
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  String otpSessionId;


  final _formKey = GlobalKey<FormState>();
//  Future loginUser(String phone, BuildContext context) async {
//    FirebaseAuth _auth = FirebaseAuth.instance;
//    print(phone);
//    _auth.verifyPhoneNumber(
//        phoneNumber: phone,
//        timeout: Duration(seconds: 60),
//        verificationCompleted: (AuthCredential authCredential) async {
//          print('im here');
//          AuthResult result = await _auth.signInWithCredential(authCredential);
//          FirebaseUser user = result.user;
//         // _phoneController.text = authCredential.providerId;
//          if( user != null){
//            print('im here');
//           nextScreen();
//          }
//          else{
//            print('error');
//          }
//        },
//        verificationFailed: (AuthException authException){
//          print(authException.message);
//        },
//        codeSent: (String verificationId, [int forceResendingToken]){
//            print(verificationId);
//            print(forceResendingToken);
//        },
//        codeAutoRetrievalTimeout: null
//    );
//  }

  // TODO: Check Whether Mobile Registered or not

  void checkUser(String mobile) async {
   HTTPHelper helper = HTTPHelper('https://2factor.in/API/V1/800a94f7-9f7e-11ea-9fa5-0200cd936042/SMS/+91$mobile/AUTOGEN/login');
    var otpData = await helper.getResponse();
    if(otpData['Status'] == 'Success'){
      setState(() {
        showSpiner = false;
        otpFieldVisibility = true;
        otpSessionId = otpData['Details'];
        verifybuttonVisibility = true;

      });
    }

  }

  void verifyOTP() async {
    final otp = '${_otpController.text}';
    HTTPHelper helper = HTTPHelper('https://2factor.in/API/V1/800a94f7-9f7e-11ea-9fa5-0200cd936042/SMS/VERIFY/$otpSessionId/$otp');
    var verificationData = await helper.getResponse();
    if(verificationData['Status'] == 'Success'){
      signin();
    }
    else{
      showRegisterDialog(context,'Invalid OTP','Verification Status');
    }
  }

  void signin() async{
    String mobile = '${_phoneController.text}';
    print('Mobile::$mobile');
    HTTPHelper helper = HTTPHelper('http://dydindia.com/admin/api/signin/?&phone=$mobile');
    var data = await helper.getResponse();
    print(data);
    if(data['status']=='Success'){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return Loading();
      }));
    }
    else{
      setState(() {
        showSpiner = false;
      });
      Fluttertoast.showToast(msg: 'Mobile Verification failed',toastLength: Toast.LENGTH_SHORT);
    }
  }

  Future<bool> showRegisterDialog(BuildContext context, String msg, String header) async{
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text(msg),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context){
                    return Register();
                  }
                ));
              },
              child: Text(header),
            )
          ],
        );
      }
    );
  }

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
    return ModalProgressHUD(
      inAsyncCall: showSpiner,
      color: Colors.blueAccent,

      child: ListView(
        children: [Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: NetworkImage('http://dydindia.com/admin/image/Logo.png'),
                width: 200,
                height: 180,
              ),
              Text("Welcome to DYD's e-Academy",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 50,),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),

                child: TextFormField(
                 controller: _phoneController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    focusColor: Colors.green,
                    hoverColor: Colors.white,

                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.phone, color: Colors.white,),
                    prefix: Text('+91'),
                    hintText: 'Enter  Mobile No ',
                  ),
                  textAlign: TextAlign.center,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                  keyboardType: TextInputType.number,
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please Enter your mobile no';
                    }
                    else if(value.length<10){
                      return 'Invalid Mobile Number!';
                    }
                    return null;
                  },

                ),
              ),

              SizedBox(height: 20,),

              Visibility(
                visible: otpFieldVisibility,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),

                      child: TextFormField(
                        controller: _otpController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,

                          hintText: 'Enter 6 digit OTP',
                          hintStyle: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        textAlign: TextAlign.center,
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
                        keyboardType: TextInputType.number,


                      ),

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right:35.0),
                          child: FlatButton(
                              onPressed: (){},
                              child: Text('Resend OTP', style: TextStyle(color: Colors.white),)),
                        )
                      ],
                    ),
                  ],
                ),

              ),
              SizedBox(height: 50.0,),
              Visibility(
                visible: gobuttonVisibility,
                child: FloatingActionButton(
                  onPressed: (){
                    setState(() {
                      showSpiner = true;
                      otpFieldVisibility = true;
                      gobuttonVisibility = false;
                      final _phone = '${_phoneController.text}';
                      checkUser(_phone);
                    });
                  },
                  child: Text('GO', style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),

              Visibility(
                visible: verifybuttonVisibility,
                child: RaisedButton(
                  onPressed: (){
                    setState(() {
                      showSpiner = true;

                    });
                    verifyOTP();
                  },
                  child: Text('Verify', style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),),
                  color: Colors.green,
                ),
              ),

            ],
          ),
        ),],
      ),
    );
  }
}

