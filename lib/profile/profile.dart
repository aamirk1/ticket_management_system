import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.adminId});
  final String adminId;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String firstName = '';
  String lastName = '';
  String mobile = '';
  String adminId = '';
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getProfile(widget.adminId).whenComplete(() => setState(() {
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
                                    'My Profile',
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
                                          'Admin Id: ${widget.adminId}',
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

  Future<void> getProfile(String adminId) async {
    DocumentSnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('admins')
        .doc(adminId)
        .get();
    if (querySnapshot.exists && querySnapshot.data() != null) {
      Map<String, dynamic> data = querySnapshot.data() as Map<String, dynamic>;
      firstName = data['firstName'] ?? '';
      lastName = data['lastName'] ?? '';
      mobile = data['mobile'] ?? '';
      adminId = data['adminId'] ?? '';
    }

    setState(() {});
  }
}
