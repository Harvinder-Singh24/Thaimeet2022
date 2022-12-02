import 'package:flutter/material.dart';
import 'package:thaimeet/authentication/email_verify.dart';
import 'package:thaimeet/services/authservice.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool _isVisible = true;
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async => false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headText(),
                _image(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black54),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "name is required";
                            }
                          },
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              prefixIcon:
                                  Icon(Icons.person, color: Colors.grey[500]),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Name",
                              fillColor: Colors.white,
                              hintStyle: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 14,
                              ),
                              filled: true),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _emailController,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black54),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email is required";
                            }
                          },
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              prefixIcon:
                                  Icon(Icons.email, color: Colors.grey[500]),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "email",
                              hintStyle: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 14,
                              ),
                              fillColor: Colors.white,
                              filled: true),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _phoneController,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black54),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Phone number is required";
                            }
                          },
                          maxLength: 10,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              prefixIcon:
                                  Icon(Icons.phone, color: Colors.grey[500]),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "+91 phone number",
                              hintStyle: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 14,
                              ),
                              fillColor: Colors.white,
                              filled: true),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    register();
                  },
                  child: Container(
                    width: 349,
                    height: 66,
                    decoration: BoxDecoration(
                      color: Colors.indigo[600],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text("Confirm",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  register() {
    if (_key.currentState!.validate()) {
      _authService
          .signUp(
            email: _emailController.text,
            password: _phoneController.text,
            name: _nameController.text,
            number: int.parse(_phoneController.text),
          )
          .then((value) => {
                if (value == true)
                  {
                    print("Registered"),
                    setState(() {
                      _authService.isLoading = false;
                    }),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmailVerify(
                          user_email: _emailController.text,
                        ),
                      ),
                    ),
                  }
                else
                  {
                    setState(() {
                      _authService.isLoading = false;
                    }),
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        value,
                        style: const TextStyle(fontSize: 16),
                      ),
                    )),
                  }
              });
    }
  }
}

Widget _headText() {
  return Container(
      child: Column(
    children: const [
      Text(
        "Sign Up \nThaimeet 2022",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      )
    ],
  ));
}

Widget _image() {
  return Image.asset("assets/signup.jpg");
}
