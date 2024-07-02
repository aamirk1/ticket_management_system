import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ticket_management_system/Report/upDateServiceProvider.dart';
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
  String? selectedDate;
  String? selectedUser;
  String? selectedTicket;
  String? selectedbuilding;

  List<dynamic> allData = [];
  List<dynamic> serviceProviderList = [];
  String? selectedTicketNumber;
  List<String> allDateData = [];
  List<String> allTicketData = [];
  List<String> allAssetData = [];
  List<String> allUserData = [];
  List<String> allBuildingData = [];
  List<String> allFloorData = [];
  List<String> allWorkData = [];
  List<String> allRoomData = [];
  List<String> columnName = [
    'Date',
    'TAT',
    'Ticket No',
    'Status',
    'Work',
    'Building',
    'Floor',
    'Room',
    'Asset',
    'User',
    'Service Provider',
    'Remarks',
    // 'Picture',
    'Re-Assign (From/To)',
    'Revive',
  ];
  List<List<String>> rowData = [];
  String asset = '';
  String floor = '';
  String building = '';
  String room = '';
  String date = '';
  String work = '';
  String service = '';
  String tat = '';
  String status = '';
  String user = '';
  String remark = '';
  String picture = '';
  String assign = '';
  String revive = '';

  List<String> ticketList = [];

  List<String> serviceProvider = [];

  String? selectedServiceProvider;

  List<String> ticketNumberList = [];
  @override
  void initState() {
    getTicketNumberList();
    fetchData();
    getTicketList().whenComplete(() {
      getdata().whenComplete(() {
        setState(() {});
      });
    });
    getBuilding();

    super.initState();
  }

  TextEditingController ticketnumberController = TextEditingController();
  TextEditingController serviceProviderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: customDropDown(
                      'Select Date',
                      allDateData,
                      "Search Date",
                      0,
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: customDropDown(
                      'Select Ticket Number',
                      allTicketData,
                      "Search Ticket Number",
                      1,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customDropDown('Select Building', buildingList,
                      "Search Building Number", 2),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customDropDown(
                      'Select Floor', floorList, "Search Floor Number", 3),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customDropDown(
                      'Select Room', roomList, "Search Room Number", 4),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      customDropDown('Select User', userList, "Search User", 5),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customDropDown(
                      'Select Asset', assetList, "Search Asset", 6),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                padding: const EdgeInsets.all(2.0),
                height: MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width * 0.99,
                child: DataTable2(
                  minWidth: 5500,
                  border: TableBorder.all(color: Colors.black),
                  headingRowColor:
                      const MaterialStatePropertyAll(Colors.purple),
                  headingTextStyle:
                      const TextStyle(color: Colors.white, fontSize: 50.0),
                  columnSpacing: 3.0,
                  columns: List.generate(columnName.length, (index) {
                    return DataColumn2(
                      fixedWidth: 150,
                      // fixedWidth: index == 10 ? 300 : 110,
                      label: Align(
                        alignment: Alignment.center,
                        child: Text(
                          columnName[index],
                          style: const TextStyle(
                              // overflow: TextOverflow.ellipsis,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }),
                  rows: List.generate(
                    growable: true,
                    rowData.length, //change column name to row data
                    (index1) => DataRow2(
                      cells: List.generate(columnName.length, (index2) {
                        return DataCell(Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              rowData[index1][index2].toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ));
                      }),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return UpdateServiceProvider();
          }));
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: white),
      ),
    );
  }

  Future<void> getTicketNumberList() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('raisedTickets').get();

      if (querySnapshot.docs.isNotEmpty) {
        // Extract document IDs from the QuerySnapshot
        List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();

        // Update your ticketNumberList
        ticketNumberList = tempData;
        print(ticketNumberList);
      }
    } catch (e) {
      print("Error getting ticket numbers: $e");
    }
  }

  Future<void> fetchData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('designations').get();
    if (querySnapshot.docs.isNotEmpty) {
      List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();
      serviceProvider = tempData;
      print(serviceProvider);
    }
  }

  Future updateData() async {
    await FirebaseFirestore.instance
        .collection('raisedTickets')
        .doc(selectedTicketNumber)
        .update({
      'designation': selectedServiceProvider,
    });
  }

  Future<void> getTicketList() async {
    // final provider = Provider.of<AllRoomProvider>(context, listen: false);
    // provider.setBuilderList([]);
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('raisedTickets').get();
    if (querySnapshot.docs.isNotEmpty) {
      List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();
      ticketList = tempData;
      print(ticketList);
    }
  }

  Future<void> getdata() async {
    Map<String, dynamic> data = Map();

    for (var i = 0; i < ticketList.length; i++) {
      List<String> allData = [];
      print('lll${ticketList[i]}');
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('raisedTickets')
          .doc(ticketList[i])
          .get();

      if (documentSnapshot.data() != null) {
        data = documentSnapshot.data() as Map<String, dynamic>;

        asset = data['asset'] ?? '';
        building = data['building'] ?? '';
        date = data['date'] ?? '';
        floor = data['floor'] ?? '';
        room = data['room'] ?? '';
        service = data['serviceProvider'] ?? '';
        work = data['work'] ?? '';
        tat = data['tat'] ?? 'tat';
        status = data['open'] ?? 'open';
        user = data['user'] ?? 'user11';
        remark = data['remark'] ?? 'remark';
        // picture = data['picture'] ?? 'picture';
        assign = data['assign'] ?? 'assign';
        revive = data['revive'] ?? 'revive';
      }
      allData.add(date);
      allData.add(tat);
      allData.add(ticketList[i]);
      allData.add(status);
      allData.add(work);
      allData.add(building);
      allData.add(floor);
      allData.add(room);
      allData.add(asset);
      allData.add(user);
      allData.add(service);
      allData.add(remark);
      // allData.add(picture);
      allData.add(assign);
      allData.add(revive);
      rowData.add(allData);
    }
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
                                  : selectedAsset,
          onChanged: (value) {
            setState(() {
              index == 0
                  ? selectedDate = value
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
                                      : selectedAsset = value;
            });
            // fetchMemberName(selectedFlatNo!);
          },
          buttonStyleData: const ButtonStyleData(
            decoration: BoxDecoration(),
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            width: 150,
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
                                    : assetController,
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
                                        : assetController,
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
            if (!isOpen) {
              // textEditingController.clear();
            }
          },
        ),
      ),
    );
  }

  Future<void> getBuilding() async {
    Map<String, dynamic> data = Map();

    for (var i = 0; i < ticketList.length; i++) {
      print('lll${ticketList[i]}');
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('raisedTickets')
          .doc(ticketList[i])
          .get();

      if (documentSnapshot.data() != null) {
        data = documentSnapshot.data() as Map<String, dynamic>;

        asset = data['asset'] ?? '';
        building = data['building'] ?? '';
        date = data['date'] ?? '';
        floor = data['floor'] ?? '';
        room = data['room'] ?? '';
        work = data['work'] ?? '';
        user = data['user'] ?? 'user11';
      }
      allDateData.add(date);
      allTicketData.add(ticketList[i]);

      allRoomData.add(work);
      allBuildingData.add(building);
      allFloorData.add(floor);
      allRoomData.add(room);
      allAssetData.add(asset);
      allUserData.add(user);
      allWorkData.add(work);
    }
  }
}
