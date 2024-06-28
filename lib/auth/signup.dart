
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ticket_management_system/auth/login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  double? height, width;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: height! * .5,
                  decoration: const BoxDecoration(
                      // color: Colors.blue,
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.blue,
                            Color.fromARGB(255, 220, 137, 234)
                          ]),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: const CircleAvatar(
                    child: Icon(
                      Icons.home,
                      color: Colors.blue,
                      size: 40,
                    ),
                    radius: 50,
                    backgroundColor: Colors.white,
                  ),
                ),
                Container(
                  height: height! * .5,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Positioned(
                top: 20,
                left: 6,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ))),
            Positioned(
              bottom: 70,
              child: Card(
                elevation: 10,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.53,
                  width: MediaQuery.of(context).size.width * 0.35,
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Center(
                            child: Text(
                          'SIGN UP',
                          style: TextStyle(letterSpacing: 2, fontSize: 20),
                        )),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: firstNameController,
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                            hintText: 'Enter your first name ',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: lastNameController,
                          decoration: const InputDecoration(
                            labelText: 'Last name',
                            hintText: 'Enter your last name',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: mobileController,
                          decoration: const InputDecoration(
                            labelText: 'Mobile number',
                            hintText: 'Enter you mobile number',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter you password',
                          ),
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                      ],
                    ),
                  ),
                  alignment: Alignment.center,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue,
                ),
                height: 50,
                width: 200,
                child: InkWell(
                  onTap: () {
                    signup(firstNameController.text, lastNameController.text,
                        mobileController.text, passwordController.text);
                  },
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void signup(
      String firstName, String lastName, String mobile, String password) {
    String firstInitial = firstName[0][0].trim().toUpperCase();
    String lastInitial = lastName[0][0].trim().toUpperCase();
    String mobileLastFour = mobile.substring(mobile.length - 4);
    String fullName = '$firstName $lastName';

    String adminId = '$firstInitial$lastInitial$mobileLastFour';
    FirebaseFirestore.instance.collection('admins').doc(adminId).set(
      {
        'adminId': adminId,
        'firstName': firstName,
        'lastName': lastName,
        'fullName': fullName,
        'mobile': mobile,
        'password': password
      },
    );

    alertbox(adminId, context);
  }

  alertbox(String adminId, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              actions: [
                TextButton(
                    onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        ),
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.black),
                    )),
              ],
              title: Text(
                'Your User ID is: $adminId',
                style: const TextStyle(color: Colors.black),
              ));
        });
  }
}
