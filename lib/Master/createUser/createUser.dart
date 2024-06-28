import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_management_system/Master/createUser/userDetails.dart';
import 'package:ticket_management_system/providers/userProvider.dart';
import 'package:ticket_management_system/utils/colors.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = true;
  List<String> userList = [];
  @override
  void initState() {
    fetchData().whenComplete(() => setState(() {
          isLoading = false;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.purple, Colors.deepPurple])),
        ),
        title: const Text(
          'Create User',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                          child: Container(
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
                                        trailing: IconButton(
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
                              addUser();
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
      print(userList);
    }

    provider.setBuilderList(userList);
  }

  Future<void> deleteUser(String userId) async {
    final provider = Provider.of<AllUserProvider>(context, listen: false);
    await FirebaseFirestore.instance.collection('members').doc(userId).delete();
    provider.removeData(userList.indexOf(userId));
  }

  void addUser() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        color: Colors.white,
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          expands: true,
                          maxLines: null,
                          controller: fnameController,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            label: const Text('First Name'),
                            hintText: 'Enter First Name',
                            hintStyle: const TextStyle(fontSize: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        color: Colors.white,
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          expands: true,
                          maxLines: null,
                          controller: lnameController,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            label: const Text('Last Name'),
                            hintText: 'Enter Last Name',
                            hintStyle: const TextStyle(fontSize: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        color: Colors.white,
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: TextFormField(
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          expands: true,
                          maxLines: null,
                          controller: mobileController,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            label: const Text('Mobile Number'),
                            hintText: 'Enter Mobile Number',
                            hintStyle: const TextStyle(fontSize: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        color: Colors.white,
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          expands: true,
                          maxLines: null,
                          controller: passwordController,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            label: const Text('Password'),
                            hintText: 'Enter Password',
                            hintStyle: const TextStyle(fontSize: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                        ElevatedButton(
                            onPressed: () {
                              storeData(
                                      fnameController.text,
                                      lnameController.text,
                                      mobileController.text,
                                      passwordController.text)
                                  .whenComplete(() {
                                popupmessage('User created successfully!!');
                              });
                            },
                            child: const Text('Save'))
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  Future<void> storeData(
      String fname, String lname, String mobile, String password) async {
    String firstInitial = fname[0][0].trim().toUpperCase();
    String lastInitial = lname[0][0].trim().toUpperCase();
    String mobileLastFour = mobile.substring(mobile.length - 4);
    String fullName = '$fname $lname';

    String userId = '$firstInitial$lastInitial$mobileLastFour';
    final provider = Provider.of<AllUserProvider>(context, listen: false);
    await FirebaseFirestore.instance.collection('members').doc(userId).set({
      'userId': userId,
      'fName': fname,
      'lName': lname,
      'mobile': mobile,
      'password': password,
    });
    provider.addSingleList({
      'userId': userId,
      'fName': fname,
      'lName': lname,
      'mobile': mobile,
      'password': password,
    });
  }

  void popupmessage(String msg) {
    final provider = Provider.of<AllUserProvider>(context, listen: false);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: AlertDialog(
              content: Text(
                msg,
                style: const TextStyle(fontSize: 14, color: Colors.green),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      fetchData().whenComplete(() {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        fnameController.clear();
                        lnameController.clear();
                        mobileController.clear();
                        passwordController.clear();
                        provider.setLoadWidget(false);
                      });
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.green),
                    ))
              ],
            ),
          );
        });
  }
}
