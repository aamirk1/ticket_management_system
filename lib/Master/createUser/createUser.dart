import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_management_system/Master/createUser/editUserForm.dart';
import 'package:ticket_management_system/Master/createUser/userDetails.dart';
import 'package:ticket_management_system/Master/createUser/userForm.dart';
import 'package:ticket_management_system/providers/userProvider.dart';
import 'package:ticket_management_system/utils/colors.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key, required this.adminId});
  final String adminId;

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  bool isLoading = true;
  String messageForSocietyMember = '';
  List<String> userList = [];
  List<String> workList = [];
  @override
  void initState() {
    fetchData().whenComplete(() => setState(() {
          isLoading = false;
        }));
    getWorks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.purple, Colors.deepPurple])),
        ),
        title: const Center(
          child: Text(
            'Create User',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(child:
              Consumer<AllUserProvider>(builder: (context, value, child) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Card(
                  elevation: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.userList.length,
                                itemBuilder: (item, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => UserDetails(
                                                adminId: widget.adminId,
                                                userId: value.userList[index],
                                              ),
                                            ),
                                          );
                                        },
                                        title: Text(
                                          value.userList[index],
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.edit,
                                                color: black,
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditUserForm(
                                                      userId:
                                                          value.userList[index],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                deleteUser(
                                                  value.userList[index],
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.black,
                                      )
                                    ],
                                  );
                                }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton(
                            backgroundColor: Colors.deepPurple,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const UserForm()));
                            },
                            child: const Icon(Icons.add, color: white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            })),
    );
  }

  Future<void> fetchData() async {
    final provider = Provider.of<AllUserProvider>(context, listen: false);
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('members').get();
    if (querySnapshot.docs.isNotEmpty) {
      List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();
      userList = tempData;
      if (kDebugMode) {
        print(userList);
      }
    }

    provider.setBuilderList(userList);
  }

  Future<void> deleteUser(String userId) async {
    final provider = Provider.of<AllUserProvider>(context, listen: false);
    await FirebaseFirestore.instance.collection('members').doc(userId).delete();
    provider.removeData(userList.indexOf(userId));
  }

  Future<void> editUser(String userId) async {
    final provider = Provider.of<AllUserProvider>(context, listen: false);
    await FirebaseFirestore.instance.collection('members').doc(userId).delete();
    provider.removeData(userList.indexOf(userId));
  }


  Future<void> getWorks() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('works').get();
    if (querySnapshot.docs.isNotEmpty) {
      List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();
      setState(() {
        workList = tempData;
      });
    }
  }
}
