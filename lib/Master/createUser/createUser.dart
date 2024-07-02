import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  List<String> designationList = [];
  @override
  void initState() {
    fetchData().whenComplete(() => setState(() {
          isLoading = false;
        }));
    getDesignations();
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
        title: const Center(
          child:  Text(
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
      print(userList);
    }

    provider.setBuilderList(userList);
  }

  Future<void> deleteUser(String userId) async {
    final provider = Provider.of<AllUserProvider>(context, listen: false);
    await FirebaseFirestore.instance.collection('members').doc(userId).delete();
    provider.removeData(userList.indexOf(userId));
  }

  // void addUser() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           actions: [
  //             Center(
  //               child: Container(
  //                 margin: const EdgeInsets.only(top: 20),
  //                 height: MediaQuery.of(context).size.height * 0.80,
  //                 child: Column(
  //                   // mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(
  //                           horizontal: 10, vertical: 2),
  //                       child: Container(
  //                         color: Colors.white,
  //                         height: 45,
  //                         width: MediaQuery.of(context).size.width * 0.30,
  //                         child: TextFormField(
  //                           textInputAction: TextInputAction.next,
  //                           expands: true,
  //                           maxLines: null,
  //                           controller: fnameController,
  //                           decoration: InputDecoration(
  //                             isDense: true,
  //                             contentPadding: const EdgeInsets.symmetric(
  //                               horizontal: 10,
  //                               vertical: 8,
  //                             ),
  //                             label: const Text('First Name'),
  //                             hintText: 'Enter First Name',
  //                             hintStyle: const TextStyle(fontSize: 12),
  //                             border: OutlineInputBorder(
  //                               borderRadius: BorderRadius.circular(8),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 4,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(
  //                           horizontal: 10, vertical: 2),
  //                       child: Container(
  //                         color: Colors.white,
  //                         height: 45,
  //                         width: MediaQuery.of(context).size.width * 0.30,
  //                         child: TextFormField(
  //                           textInputAction: TextInputAction.next,
  //                           expands: true,
  //                           maxLines: null,
  //                           controller: lnameController,
  //                           decoration: InputDecoration(
  //                             isDense: true,
  //                             contentPadding: const EdgeInsets.symmetric(
  //                               horizontal: 10,
  //                               vertical: 8,
  //                             ),
  //                             label: const Text('Last Name'),
  //                             hintText: 'Enter Last Name',
  //                             hintStyle: const TextStyle(fontSize: 12),
  //                             border: OutlineInputBorder(
  //                               borderRadius: BorderRadius.circular(8),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 4,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(
  //                           horizontal: 10, vertical: 2),
  //                       child: Container(
  //                         color: Colors.white,
  //                         height: 55,
  //                         width: MediaQuery.of(context).size.width * 0.30,
  //                         child: TextFormField(
  //                           maxLength: 10,
  //                           keyboardType: TextInputType.number,
  //                           textInputAction: TextInputAction.next,
  //                           expands: true,
  //                           maxLines: null,
  //                           controller: mobileController,
  //                           decoration: InputDecoration(
  //                             isDense: true,
  //                             contentPadding: const EdgeInsets.symmetric(
  //                               horizontal: 10,
  //                               vertical: 8,
  //                             ),
  //                             label: const Text('Mobile Number'),
  //                             hintText: 'Enter Mobile Number',
  //                             hintStyle: const TextStyle(fontSize: 12),
  //                             border: OutlineInputBorder(
  //                               borderRadius: BorderRadius.circular(8),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 4,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(
  //                           horizontal: 10, vertical: 2),
  //                       child: Container(
  //                         color: Colors.white,
  //                         height: 45,
  //                         width: MediaQuery.of(context).size.width * 0.30,
  //                         child: TextFormField(
  //                           textInputAction: TextInputAction.next,
  //                           expands: true,
  //                           maxLines: null,
  //                           controller: passwordController,
  //                           decoration: InputDecoration(
  //                             isDense: true,
  //                             contentPadding: const EdgeInsets.symmetric(
  //                               horizontal: 10,
  //                               vertical: 8,
  //                             ),
  //                             label: const Text('Password'),
  //                             hintText: 'Enter Password',
  //                             hintStyle: const TextStyle(fontSize: 12),
  //                             border: OutlineInputBorder(
  //                               borderRadius: BorderRadius.circular(8),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 6,
  //                     ),
  //                     Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Column(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             customDropDown(
  //                               'Select Designation',
  //                               true,
  //                               designationList,
  //                               "Search Designation",
  //                             ),
  //                             Container(),
  //                           ],
  //                         ),
  //                         customShowBox(
  //                           selectedDesignationList,
  //                           0.35,
  //                         ),
  //                       ],
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                       children: [
  //                         TextButton(
  //                             onPressed: () {
  //                               Navigator.pop(context);
  //                             },
  //                             child: const Text('Cancel')),
  //                         ElevatedButton(
  //                             onPressed: () {
  //                               storeData(
  //                                       fnameController.text,
  //                                       lnameController.text,
  //                                       mobileController.text,
  //                                       passwordController.text,
  //                                       selectedServiceProvider!)
  //                                   .whenComplete(() {
  //                                 popupmessage('User created successfully!!');
  //                               });
  //                             },
  //                             child: const Text('Save'))
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             )
  //           ],
  //         );
  //       });
  // }

  Future<void> storeData(String fname, String lname, String mobile,
      String password, String role) async {
    String firstInitial = fname[0][0].trim().toUpperCase();
    String lastInitial = lname[0][0].trim().toUpperCase();
    String mobileLastFour = mobile.substring(mobile.length - 4);
    String fullName = '$fname $lname';

    String userId = '$firstInitial$lastInitial$mobileLastFour';
    final provider = Provider.of<AllUserProvider>(context, listen: false);
    await FirebaseFirestore.instance.collection('members').doc(userId).set({
      'userId': userId,
      'fullName': fullName,
      'fName': fname,
      'lName': lname,
      'mobile': mobile,
      'password': password,
      'role': role,
    });
    provider.addSingleList({
      'userId': userId,
      'fullName': fullName,
      'fName': fname,
      'lName': lname,
      'mobile': mobile,
      'password': password,
      'role': role,
    });
  }

  Future<void> getDesignations() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('designations').get();
    if (querySnapshot.docs.isNotEmpty) {
      List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();
      setState(() {
        designationList = tempData;
      });
    }
  }
}
