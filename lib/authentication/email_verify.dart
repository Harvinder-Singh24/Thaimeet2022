import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:thaimeet/Screens/inappscreens/mainscreen.dart';

import '../services/authservice.dart';

class EmailVerify extends StatefulWidget {
  final user_email;
  const EmailVerify({Key? key, required this.user_email}) : super(key: key);

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  final TextEditingController _controller = TextEditingController();
  AuthService _authService = AuthService();
  EmailOTP myauth = EmailOTP();
  bool _isLoading = false;
  bool _isVerified = false;

  @override
  void initState() {
    sendOtp();
    super.initState();
  }

  void sendOtp() {
    Future.delayed(Duration.zero, () async {
      myauth.setConfig(
          appEmail: "support@walldeco.com",
          appName: "Email OTP",
          userEmail: widget.user_email,
          otpLength: 6,
          otpType: OTPType.digitsOnly);

      if (await myauth.sendOTP() == true) {
        setState(() {
          _isLoading = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("OTP has been sent"),
        ));
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Oops, OTP send failed"),
        ));
        Navigator.pop(context);
        _authService.signOut();
        print("Sign Out Done");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: emailverifyUI(context),
    );
  }

  Widget emailverifyUI(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: ShowUpAnimation(
              animationDuration: const Duration(seconds: 1),
              curve: Curves.bounceIn,
              direction: Direction.horizontal,
              offset: 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Confirm your email",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                  ),
                  const Text(
                    "Plz Enter the code sent on your email",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  PinCodeTextField(
                    controller: _controller,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      inactiveColor: Colors.indigo[600],
                      inactiveFillColor: Colors.indigo[600],
                      selectedFillColor: Colors.white,
                      selectedColor: Colors.indigo[600],
                      activeFillColor: Colors.white,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    keyboardType: TextInputType.number,
                    onCompleted: (v) async {
                      SharedPreferences sharedpreference =
                          await SharedPreferences.getInstance();
                      print("Value got after completed");
                      if (await myauth.verifyOTP(otp: _controller.text) ==
                          true) {
                        setState(() {
                          _isLoading = false;
                        });
                        sharedpreference.setBool('islogin', true);
                        print("Shared Value Set");
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("OTP is verified"),
                        ));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen()));
                      } else {
                        setState(() {
                          _isLoading = false;
                        });
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Invalid OTP"),
                        ));
                      }
                    },
                    onChanged: (value) {},
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                    appContext: context,
                  ),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      sendOtp();
                    },
                    child: Container(
                      width: 349,
                      height: 66,
                      decoration: BoxDecoration(
                        color: Colors.indigo[600],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                            : Text(_isVerified ? "Verified" : "Verify",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Sending OTP"),
                      ));
                      sendOtp();
                    },
                    child: const SizedBox(
                      child: Text(
                        "Resend Otp ?",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
