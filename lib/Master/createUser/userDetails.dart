import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key, required this.userId});
  final String userId;

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  String firstName = '';
  String lastName = '';
  String mobile = '';
  String userId = '';
  String password = '';
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getUserDetails(widget.userId).whenComplete(() => setState(() {
          isLoading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const Center(
                                  child: Text(
                                    'User Details',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'First Name: $firstName',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'Last Name: $lastName',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'Mobile: $mobile',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'User Id: ${widget.userId}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                      ]),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> getUserDetails(String userId) async {
    DocumentSnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('members')
        .doc(userId)
        .get();
    if (querySnapshot.exists && querySnapshot.data() != null) {
      Map<String, dynamic> data = querySnapshot.data() as Map<String, dynamic>;
      firstName = data['fName'] ?? '';
      lastName = data['lName'] ?? '';
      mobile = data['mobile'] ?? '';
      userId = data['userId'] ?? '';
      password = data['password'] ?? '';
    }

    setState(() {});
  }
}
