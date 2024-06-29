import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_management_system/assignRoll/menu_screen/assigned_user.dart';
import 'package:ticket_management_system/providers/designationProvider.dart';
import 'package:ticket_management_system/providers/menuUserPageProvider.dart';
import 'package:ticket_management_system/providers/role_page_totalNum_provider.dart';

// ignore: must_be_immutable
class RoleScreen extends StatefulWidget {
  // String society;
  RoleScreen({super.key, required this.adminId});
  final String adminId;

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  bool isSelectAllDepots = false;
  int assignedUsers = 0;
  List<String> assignedUserList = [];
  int totalUsers = 0;
  List<dynamic> unAssignedUserList = [];
  TextEditingController unAssignedUserController = TextEditingController();
  String selectedUserId = '';
  bool isLoading = true;
  List<String> unAssignedUsersList = [];
  List<String> memberList = [];
  String selectedUserName = '';
  List<String> role = [];

  final TextEditingController citiesController = TextEditingController();
  final TextEditingController reportingManagerController =
      TextEditingController();
  final TextEditingController selectedUserController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController depotController = TextEditingController();
  String messageForSocietyMember = '';

  List<String> gridTabLabels = [
    'Assigned',
  ];

  List<String> designationList = [];

  String? selectedUser;
  String? selectedCity;
  String? selectedDesignation;
  String? selectedReportingManager;
  String? selectedDepot;

  List<String> selectedDesignationList = [];
  List<String> selectedCitiesList = [];
  List<String> selectedDepotList = [];
  int unAssignedUser = 0;

  List<String> allUserList = [];
  List<String> allCityList = [];
  List<String> allDepotList = [];

  @override
  void initState() {
    fetchCompleteUserList().whenComplete(() async {
      await getMemberList();
      await getTotalUsers();
      await fetchData();
      setState(() {
        isLoading = false;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    citiesController.dispose();
    reportingManagerController.dispose();
    selectedUserController.dispose();
    designationController.dispose();
    depotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String selectedAdmin = widget.adminId;
    final provider = Provider.of<MenuUserPageProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          "Role Management",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //EV PMIS

                    Container(
                      margin: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(
                              255,
                              52,
                              91,
                              199,
                            ),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(
                          5.0,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 8.0),
                            child: const Text(
                              "TMS Users",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(
                                    255,
                                    52,
                                    91,
                                    199,
                                  ),
                                  letterSpacing: 1.0),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.all(5.0),
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 120,
                            child: GridView.builder(
                                itemCount: 3,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio: 3.5,
                                ),
                                itemBuilder: (context, index) {
                                  return Consumer<
                                      RolePageTotalNumProviderAdmin>(
                                    builder: (context, value, child) {
                                      return gridTabs(
                                        index,
                                        const Color.fromARGB(
                                          255,
                                          52,
                                          91,
                                          199,
                                        ),
                                        assignedUsers,
                                        AssignedUser(
                                          adminId: widget.adminId,
                                        ),
                                      );
                                    },
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                  ),
                  padding: const EdgeInsets.all(
                    10.0,
                  ),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(
                      255,
                      208,
                      232,
                      253,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Card(
                            elevation: 5.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  3.0,
                                ),
                              ),
                              alignment: Alignment.center,
                              height: 35,
                              width: 180,
                              child: const Text(
                                "Select Service Provider:",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [
                                customDropDown('Select Service Provider', false,
                                    memberList, "Search user", 0),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    messageForSocietyMember,
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              customDropDown(
                                'Select Designation',
                                true,
                                designationList,
                                "Search Designation",
                                2,
                              ),
                              Container(),
                            ],
                          ),
                          customShowBox(
                            selectedDesignationList,
                            0.6,
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 50.0,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 5.0),
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Color.fromARGB(
                                    255,
                                    47,
                                    173,
                                    74,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                for (int i = 0; i < assignedUsers; i++) {
                                  if (assignedUserList[i] == selectedUserName) {
                                    // isDefined = true;
                                  }
                                }

                                if (selectedUserName != selectedAdmin) {
                                  selectedDesignationList.isEmpty
                                      ? customAlertBox(
                                          'Please Select Designation')
                                      : storeAssignData(selectedUserName);
                                  getTotalUsers().whenComplete(() async {
                                    DocumentReference documentReference =
                                        FirebaseFirestore.instance
                                            .collection('unAssignedRole')
                                            .doc(selectedUserName);

                                    await documentReference.delete();

                                    provider.setLoadWidget(true);
                                  });
                                } else {
                                  customAlertBox(
                                      'Reporting Manager and User cannot be same');
                                }
                              },
                              child: const Text(
                                'Assign Role',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }

  Future<void> fetchCompleteUserList() async {
    // QuerySnapshot adminQuery =
    //     await FirebaseFirestore.instance.collection('Admin').get();
    // List<String> adminList = adminQuery.docs.map((e) => e.id).toList();

    QuerySnapshot userQuery =
        await FirebaseFirestore.instance.collection('members').get();
    List<String> userList = userQuery.docs.map((e) => e.id).toList();

    allUserList = userList;
  }

  Widget gridTabs(int index, Color cardColor, int headerNum, Widget screen) {
    final totalValueProvider =
        Provider.of<RolePageTotalNumProviderAdmin>(context, listen: false);

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
      child: Card(
        color: cardColor,
        elevation: 5,
        child: Column(
          children: [
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
              margin: const EdgeInsets.only(
                  left: 8.0, right: 8.0, bottom: 8.0, top: 3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        headerNum.toString(), //O&M value
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                      Text(
                        gridTabLabels[index],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 13),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: Card(
                      elevation: 5.0,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => screen,
                            ),
                          ).whenComplete(() {
                            getTotalUsers().whenComplete(() {
                              totalValueProvider.reloadTotalNum(true);
                            });
                          });
                        },
                        child: Text(
                          'More Info',
                          style: TextStyle(fontSize: 12, color: cardColor),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customDropDown(String title, bool isMultiCheckbox,
      List<String> customDropDownList, String hintText, int index) {
    return Card(
      elevation: 5.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.blue,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(
            3.0,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 180,
              height: 30,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  dropdownSearchData: DropdownSearchData(
                    searchController: index == 0
                        ? selectedUserController
                        : index == 2
                            ? designationController
                            : index == 3
                                ? citiesController
                                : depotController,
                    searchInnerWidgetHeight: 50,
                    searchInnerWidget: SizedBox(
                      height: index == 4 ? 90 : 42,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            width: 160,
                            height: 30,
                            child: TextFormField(
                              expands: true,
                              maxLines: null,
                              controller: index == 0
                                  ? selectedUserController
                                  : index == 2
                                      ? designationController
                                      : index == 3
                                          ? citiesController
                                          : depotController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 2,
                                ),
                                hintText: hintText,
                                hintStyle: const TextStyle(
                                  fontSize: 11,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  value: index == 0
                      ? selectedUser
                      : index == 2
                          ? selectedDesignation
                          : Container(),
                  isExpanded: true,
                  onMenuStateChange: (isOpen) {
                    if (index == 0) messageForSocietyMember = "";
                    index == 3
                        ? selectedCitiesList.isEmpty
                            ? allDepotList.clear()
                            : () {}
                        : () {};
                    setState(() {});
                  },
                  // selectedItemBuilder: (context) {
                  //   return [
                  //     Text(
                  //       title,
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.w400,
                  //         fontSize: 11,
                  //         color: white,
                  //       ),
                  //       textAlign: TextAlign.left,
                  //     ),
                  //   ];
                  // },
                  hint: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.blue,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  items: isMultiCheckbox
                      ? customDropDownList.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            enabled: false,
                            child: StatefulBuilder(
                              builder: (context, menuSetState) {
                                bool isSelected = index == 2
                                    ? selectedDesignationList.contains(item)
                                    : index == 3
                                        ? selectedCitiesList.contains(item)
                                        : selectedDepotList.contains(item);

                                return InkWell(
                                  onTap: () async {
                                    switch (isSelected) {
                                      case true:
                                        if (isSelectAllDepots) {
                                          isSelectAllDepots =
                                              !isSelectAllDepots;
                                        }
                                        index == 2
                                            ? selectedDesignationList
                                                .remove(item)
                                            : index == 3
                                                ? selectedCitiesList
                                                    .remove(item)
                                                : selectedDepotList
                                                    .remove(item);
                                        break;
                                      case false:
                                        index == 2
                                            ? selectedDesignationList.add(item)
                                            : index == 3
                                                ? selectedCitiesList.add(item)
                                                : selectedDepotList.add(item);
                                        break;
                                    }

                                    setState(() {});
                                    menuSetState(() {});
                                  },
                                  child: SizedBox(
                                    height: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        isSelected
                                            ? const Icon(
                                                Icons.check_box_outlined,
                                                size: 20,
                                              )
                                            : const Icon(
                                                Icons.check_box_outline_blank,
                                                size: 20,
                                              ),
                                        const SizedBox(width: 3),
                                        Expanded(
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }).toList()
                      : customDropDownList
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                          .toList(),
                  style: const TextStyle(fontSize: 10, color: Colors.blue),
                  dropdownStyleData: const DropdownStyleData(
                    maxHeight: 300,
                  ),
                  onChanged: (value) {
                    index == 0
                        ? selectedUser = value
                        : index == 2
                            ? selectedDesignation = value
                            : selectedCity = value;
                    if (index == 1) {
                    } else if (index == 0) {
                      messageForSocietyMember = 'Service Provider Selected ✔';
                    }
                  },
                  iconStyleData: const IconStyleData(
                    iconDisabledColor: Colors.blue,
                    iconEnabledColor: Colors.blue,
                  ),
                  buttonStyleData: const ButtonStyleData(
                    elevation: 5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  customAlertBox(String message) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 10,
            backgroundColor: Colors.white,
            icon: const Icon(
              Icons.warning_amber,
              size: 45,
              color: Colors.red,
            ),
            title: Text(
              message,
              style: const TextStyle(
                  color: Colors.grey, fontSize: 14, letterSpacing: 2),
            ),
          );
        });
  }

  Future customAlert() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsPadding: const EdgeInsets.all(5.0),
            iconPadding: const EdgeInsets.all(5.0),
            contentPadding: const EdgeInsets.all(10.0),
            elevation: 10,
            content: const Text(
              "Please Select Admin as Designation to Approve",
              style: TextStyle(color: Colors.blue, fontSize: 14),
            ),
            backgroundColor: Colors.white,
            icon: const Icon(
              Icons.warning_amber,
              size: 60.0,
              color: Colors.blue,
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
                child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Ok',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              )
            ],
          );
        });
  }

  //Storing data in firebase
  Widget customShowBox(List<String> buildList, double widhtSize) {
    return Container(
      margin: const EdgeInsets.only(
        left: 10.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          5.0,
        ),
        border: Border.all(
          color: Colors.blue,
        ),
      ),
      height:
          buildList.length > 6 ? MediaQuery.of(context).size.height * 0.13 : 40,
      width: MediaQuery.of(context).size.width * widhtSize,
      child: GridView.builder(
          itemCount: buildList.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            childAspectRatio: 4.5,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 3.0,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      2.0,
                    ),
                    border: Border.all(
                      color: Colors.blue,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    buildList[index],
                    style: const TextStyle(
                        fontSize: 11,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future<void> storeAssignData(String userName) async {
    await FirebaseFirestore.instance
        .collection('AssignedRole')
        .doc(userName)
        .set({
      "fullName": 'shashank',
      'alphabet': userName[0][0].toUpperCase(),
      'position': 'Assigned',
      'roles': selectedDesignationList,
      // 'depots': selectedDepo,
      'adminId': widget.adminId, // 'societyname': widget.society,
      // 'cities': selectedCity,
    }).whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Center(child: Text('Role Assigned Successfully')),
      ));
    });

    await FirebaseFirestore.instance
        .collection('TotalUsers')
        .doc(selectedUserName)
        .set({
      // 'userId': selectedUserId,
      'alphabet': selectedUserName[0][0].toUpperCase(),
      'position': 'Assigned',
      'roles': role,
      // 'depots': selectedDepo,
      'adminId': widget.adminId, // 'societyname': widget.society,
      // 'cities': selectedCity,
    });
  }

  Future getPhoneNumber(String selectedUser) async {
    String phoneNum = '';
    QuerySnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection("members").get();

    if (documentSnapshot.docs.isNotEmpty) {
      Map<String, dynamic> allUserMapData =
          documentSnapshot.docs.first.data() as Map<String, dynamic>;
      List<dynamic> allUserData = allUserMapData["fName"];

      for (int i = 0; i < allUserData.length; i++) {
        if (allUserData[i]['fName'] == selectedUser) {
          phoneNum = allUserData[i]['fName'];
        }
      }
    }
  }

  //Calculating Total users for additional screen
  Future<void> getTotalUsers() async {
    await getAssignedUsers();
    await getUnAssignedUser();
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('TotalUsers').get();
    totalUsers = querySnapshot.docs.length;
  }

  Future<void> getUnAssignedUser() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('unAssignedRole').get();
    unAssignedUserList = querySnapshot.docs.map((e) => e.id).toList();
    unAssignedUser = querySnapshot.docs.length;

    unAssignedUserController.text = unAssignedUser.toString();
  }

  Future<List<dynamic>> getAssignedUsers() async {
    assignedUserList.clear();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('AssignedRole')
        .where('adminId', isEqualTo: widget.adminId)
        .get();
    assignedUserList = querySnapshot.docs.map((e) => e.id).toList();
    assignedUsers = querySnapshot.docs.length;
    // print("assignedUser - $assignedUsers");
    // print('aasasasasasasasa -  $assignedUsers');
    return assignedUserList;
  }

  Future<void> getMemberList() async {
    QuerySnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('members').get();
    memberList = documentSnapshot.docs.map((e) => e.id).toList();
  }

  Future<void> fetchData() async {
    final provider =
        Provider.of<AllDesignationProvider>(context, listen: false);
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('designations').get();
    if (querySnapshot.docs.isNotEmpty) {
      List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();
      designationList = tempData;
      print(designationList);
    }

    provider.setBuilderList(designationList);
  }
}
