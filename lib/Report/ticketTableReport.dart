import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_management_system/Report/reportDetails.dart';
import 'package:ticket_management_system/providers/assetsProvider.dart';
import 'package:ticket_management_system/providers/buildingProvider.dart';
import 'package:ticket_management_system/providers/floorProvider.dart';
import 'package:ticket_management_system/providers/roomProvider.dart';
import 'package:ticket_management_system/providers/workProvider.dart';
import 'package:ticket_management_system/utils/colors.dart';

class TicketTableReport extends StatefulWidget {
  const TicketTableReport({super.key});

  @override
  State<TicketTableReport> createState() => _TicketTableReportState();
}

class _TicketTableReportState extends State<TicketTableReport> {
  TextEditingController assetController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController workController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController ticketController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  List<String> buildingList = [];
  List<String> floorList = [];
  List<String> roomList = [];
  List<String> assetList = [];
  List<String> userList = [];
  List<String> allTicketList = [];
  List<String> workList = [];
  String? selectedAsset;
  String? selectedFloor;
  String? selectedRoom;
  String selectedDate = '';
  String? selectedUser;
  String? selectedTicket;
  String? selectedbuilding;
  String? selectedWork;
  String? selectedStatus;
  List<String> floorNumberList = [];
  List<dynamic> allData = [];
  List<dynamic> serviceProviderList = [];
  String? selectedTicketNumber;
  List<String> allDateData = [];
  List<String> allTicketData = [];
  List<String> allAssetData = [];
  List<String> allUserData = [];
  List<String> buildingNumberList = [];
  List<String> allFloorData = [];
  List<String> allWorkData = [];
  List<String> allRoomData = [];
  List<String> allStatusData = ['All', 'Open', 'Close'];

  List<String> ticketList = [];

  List<String> serviceProvider = [];

  String? selectedServiceProvider;
  List<String> roomNumberList = [];
  List<String> ticketNumberList = [];
  bool isLoading = true;
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2020, 01, 01),
    end: DateTime(2025, 01, 01),
  );

  DateTime rangeStartDate = DateTime.now();
  DateTime? rangeEndDate = DateTime.now();
  @override
  void initState() {
    getTicketList();
    getWorkList();
    getBuilding();
    fetchServiceProvider();
    fetchUser();
    setState(() {
      isLoading = false;
    });

    super.initState();
  }

  TextEditingController ticketnumberController = TextEditingController();
  TextEditingController serviceProviderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'All Tickets Report',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        //  backgroundColor: Colors.deepPurple,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.purple, Colors.deepPurple])),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.power_settings_new_outlined,
                  size: 30,
                  color: white,
                )),
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: customDropDown('Select Status', allStatusData,
                              "Search Status", 8),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: customDropDown(
                            'Select Ticket Number',
                            ticketList,
                            "Search Ticket Number",
                            1,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Card(
                                elevation: 5,
                                child: SizedBox(
                                  width: 250,
                                  height: 50,
                                  child: TextButton(
                                    onPressed: () {
                                      pickDateRange();
                                      setState(() {});
                                    },
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        // Text(
                                        //   textAlign: TextAlign.justify,
                                        //   'Search Date: \n $selectedDate',
                                        //   style: const TextStyle(
                                        //       color: Colors.black,
                                        //       fontSize: 16),
                                        // ),
                                        child: RichText(
                                            text: TextSpan(
                                                text: 'Search Date: \n',
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                children: [
                                              TextSpan(
                                                  text: selectedDate,
                                                  style: const TextStyle(
                                                      backgroundColor: purple,
                                                      color: Colors.white)),
                                            ])),
                                      ),
                                    ),
                                  ),
                                ))),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: customDropDown(
                            'Select Work',
                            allWorkData,
                            "Search Work",
                            9,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: customDropDown('Select Building',
                              buildingNumberList, "Search Building Number", 2),
                        ),
                      ]),
                      Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: customDropDown('Select Floor', floorNumberList,
                              "Search Floor Number", 3),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: customDropDown('Select Room', roomNumberList,
                              "Search Room Number", 4),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: customDropDown(
                              'Select Asset', assetList, "Search Asset", 6),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: customDropDown(
                              'Select User', userList, "Search User", 5),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: customDropDown('Select Service Provider',
                              serviceProvider, "Search Service Provider", 7),
                        ),
                      ]),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          allFilterData().whenComplete(() {
                            setState(() {});
                          });
                        },
                        child: const Text('Get Report'),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Future<void> fetchUser() async {
    List<String> tempData = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('members').get();

    if (querySnapshot.docs.isNotEmpty) {
      tempData = querySnapshot.docs.map((e) => e.id).toList();
    }
    for (var i = 0; i < tempData.length; i++) {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('members')
          .doc(tempData[i])
          .get();
      if (documentSnapshot.data() != null) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        String fullName = data['fullName'] + " " + data['userId'];
        // print(fullName);
        userList.add(fullName);
      }
    }

    setState(() {});
  }

  Future<void> fetchServiceProvider() async {
    List<String> tempData = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('members')
        .where('role', isNotEqualTo: null)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      tempData = querySnapshot.docs.map((e) => e.id).toList();
    }
    for (var i = 0; i < tempData.length; i++) {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('members')
          .doc(tempData[i])
          .get();
      if (documentSnapshot.data() != null) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        serviceProvider.add(data['fullName']);
      }
    }
    setState(() {});
  }

  Future<void> getTicketList() async {
    final provider = Provider.of<AllRoomProvider>(context, listen: false);
    provider.setBuilderList([]);
    try {
      ticketList.clear();
      int currentYear = DateTime.now().year;

      QuerySnapshot monthQuery = await FirebaseFirestore.instance
          .collection("raisedTickets")
          .doc(currentYear.toString())
          .collection('months')
          .get();
      List<dynamic> months = monthQuery.docs.map((e) => e.id).toList();
      for (int i = 0; i < months.length; i++) {
        QuerySnapshot dateQuery = await FirebaseFirestore.instance
            .collection("raisedTickets")
            .doc(currentYear.toString())
            .collection('months')
            .doc(months[i])
            .collection('date')
            .get();
        List<dynamic> dateList = dateQuery.docs.map((e) => e.id).toList();
        for (int j = 0; j < dateList.length; j++) {
          List<String> temp = [];
          QuerySnapshot ticketQuery = await FirebaseFirestore.instance
              .collection("raisedTickets")
              .doc(currentYear.toString())
              .collection('months')
              .doc(months[i])
              .collection('date')
              .doc(dateList[j])
              .collection('tickets')
              .get();
          temp = ticketQuery.docs.map((e) => e.id).toList();
          ticketList = ticketList + temp;
        }
      }
    } catch (e) {
      print(e);
    }
    provider.setBuilderList(ticketList);
    setState(() {});
  }

  Future<void> getBuilding() async {
    final provider = Provider.of<AllBuildingProvider>(context, listen: false);
    provider.setBuilderList([]);
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('buildingNumbers').get();
    if (querySnapshot.docs.isNotEmpty) {
      List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();
      buildingNumberList = tempData;
      provider.setBuilderList(buildingNumberList);
    }
    setState(() {});
  }

  Future<void> getFloor(String buildingNumber) async {
    final provider = Provider.of<AllFloorProvider>(context, listen: false);
    provider.setBuilderList([]);
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('buildingNumbers')
        .doc(buildingNumber)
        .collection('floorNumbers')
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();
      floorNumberList = tempData;
      provider.setBuilderList(floorNumberList);
    }
    setState(() {});
  }

  Future<void> getRoom(String buildingNumber, String floorNumber) async {
    final provider = Provider.of<AllRoomProvider>(context, listen: false);
    provider.setBuilderList([]);
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('buildingNumbers')
        .doc(buildingNumber)
        .collection('floorNumbers')
        .doc(floorNumber)
        .collection('roomNumbers')
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();
      roomNumberList = tempData;
      provider.setBuilderList(roomNumberList);
    }
    setState(() {});
  }

  Future<void> getAsset(
      String buildingNumber, String floorNumber, String roomNumber) async {
    final provider = Provider.of<AllAssetProvider>(context, listen: false);
    provider.setBuilderList([]);
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('buildingNumbers')
        .doc(buildingNumber)
        .collection('floorNumbers')
        .doc(floorNumber)
        .collection('roomNumbers')
        .doc(roomNumber)
        .collection('assets')
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();
      assetList = tempData;
      provider.setBuilderList(assetList);
    }
    setState(() {});
  }

  Future<void> getWorkList() async {
    final provider = Provider.of<AllWorkProvider>(context, listen: false);
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('works').get();
    if (querySnapshot.docs.isNotEmpty) {
      List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();
      allWorkData = tempData;
    }

    provider.setBuilderList(allWorkData);
    setState(() {});
  }

  Widget customDropDown(String title, List<String> customDropDownList,
      String hintText, int index) {
    return Card(
      elevation: 5.0,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            hintText,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          items: customDropDownList
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ))
              .toList(),
          value: index == 0
              ? selectedDate
              : index == 1
                  ? selectedTicket
                  : index == 2
                      ? selectedbuilding
                      : index == 3
                          ? selectedFloor
                          : index == 4
                              ? selectedRoom
                              : index == 5
                                  ? selectedUser
                                  : index == 6
                                      ? selectedAsset
                                      : index == 7
                                          ? selectedServiceProvider
                                          : index == 8
                                              ? selectedStatus
                                              : selectedWork,
          onChanged: (value) async {
            setState(() {
              index == 0
                  ? selectedDate = value!
                  : index == 1
                      ? selectedTicket = value
                      : index == 2
                          ? selectedbuilding = value
                          : index == 3
                              ? selectedFloor = value
                              : index == 4
                                  ? selectedRoom = value
                                  : index == 5
                                      ? selectedUser = value
                                      : index == 6
                                          ? selectedAsset = value
                                          : index == 7
                                              ? selectedServiceProvider = value
                                              : index == 8
                                                  ? selectedStatus = value
                                                  : selectedWork = value;
            });
            await getFloor(selectedbuilding!).whenComplete(() {
              setState(() {
                getRoom(selectedbuilding!, selectedFloor!).whenComplete(() {
                  setState(() {
                    getAsset(selectedbuilding!, selectedFloor!, selectedRoom!);
                  });
                });
              });
            });
          },
          buttonStyleData: const ButtonStyleData(
            decoration: BoxDecoration(),
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 50,
            width: 250,
          ),
          dropdownStyleData: const DropdownStyleData(
            maxHeight: 200,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
          dropdownSearchData: DropdownSearchData(
            searchController: index == 0
                ? dateController
                : index == 1
                    ? ticketController
                    : index == 2
                        ? buildingController
                        : index == 3
                            ? floorController
                            : index == 4
                                ? roomController
                                : index == 5
                                    ? userController
                                    : index == 6
                                        ? assetController
                                        : index == 7
                                            ? serviceProviderController
                                            : index == 8
                                                ? statusController
                                                : workController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              height: 50,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: index == 0
                    ? dateController
                    : index == 1
                        ? ticketController
                        : index == 2
                            ? buildingController
                            : index == 3
                                ? floorController
                                : index == 4
                                    ? roomController
                                    : index == 5
                                        ? userController
                                        : index == 6
                                            ? assetController
                                            : serviceProviderController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: hintText,
                  hintStyle: const TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              return item.value.toString().contains(searchValue);
            },
          ),
          //This to clear the search value when you close the menu
          onMenuStateChange: (isOpen) {
            if (!isOpen) {}
          },
        ),
      ),
    );
  }

  Future<void> pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2100));
    if (newDateRange == null) return;
    setState(() {
      dateRange = newDateRange;
      rangeStartDate = dateRange.start;
      rangeEndDate = dateRange.end;

      selectedDate =
          "${rangeStartDate.day}/${rangeStartDate.month}/${rangeStartDate.year} TO ${rangeEndDate!.day}/${rangeEndDate!.month}/${rangeEndDate!.year}";
    });
  }

  Future<void> allFilterData() async {
    List<dynamic> allData = [];
    allData.add(selectedDate);
    allData.add(selectedTicket);
    allData.add(selectedbuilding);
    allData.add(selectedFloor);
    allData.add(selectedRoom);
    allData.add(selectedUser.toString().split(' ')[2]);
    allData.add(selectedAsset);
    allData.add(selectedServiceProvider);
    allData.add(selectedStatus);
    allData.add(selectedWork);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        // print(selectedUser);
        selectedWork = null;
        selectedServiceProvider = null;
        selectedStatus = null;
        selectedAsset = null;
        selectedUser = null;
        selectedRoom = null;
        selectedFloor = null;
        selectedbuilding = null;
        selectedTicket = null;
        selectedDate = '';

        return ReportDetails(
          dateFilter: allData[0],
          ticketFilter: allData[1],
          buildingFilter: allData[2],
          floorFilter: allData[3],
          roomFilter: allData[4],
          userFilter: allData[5],
          assetFilter: allData[6],
          serviceProvider: allData[7],
          statusFilter: allData[8],
          workFilter: allData[9],
        );
      }),
    );
  }
}
