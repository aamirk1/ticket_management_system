import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class TicketTableReport extends StatefulWidget {
  const TicketTableReport({super.key});

  @override
  State<TicketTableReport> createState() => _TicketTableReportState();
}

class _TicketTableReportState extends State<TicketTableReport> {
  List<dynamic> allData = [];
  List<dynamic> serviceProviderList = [];
  String? selectedTicketNumber;
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
  // List<List<String>> rowData = [
  //   [
  //     '02/03/2024',
  //     '90 min',
  //     '1234',
  //     'Open',
  //     'Cleaning',
  //     'C',
  //     '6',
  //     '601',
  //     'coridor',
  //     'John',
  //     'Jack',
  //     'Remark',
  //     'Picture',
  //     'Re-Assign',
  //     'Revive'
  //   ],
  // ];

  List<String> serviceProvider = [];

  String? selectedServiceProvider;
  bool isServiceProviderSelected = true;

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
    print(columnName.length);
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
                )),
          )
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                padding: const EdgeInsets.all(2.0),
                height: MediaQuery.of(context).size.height * 0.85,
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
          // selectedTicketNumber = '';
          // selectedServiceProvider = '';
          updateServiceProvider();
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }

  void updateServiceProvider() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              Center(
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            color: Colors.white,
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: const Text(
                                  'Select Ticket Number',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                                items: ticketNumberList
                                    .map((item) => DropdownMenuItem(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                        ))
                                    .toList(),
                                value: selectedTicketNumber,
                                onChanged: (value) async {
                                  serviceProviderList.clear();
                                  serviceProviderController.clear();
                                  selectedServiceProvider = '';
                                  selectedTicketNumber = value;
                                  // await getflatno(selectedSocietyName!);
                                  setState(() {
                                    selectedTicketNumber = value;
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      border: Border(
                                          right: BorderSide(
                                            color: Colors.grey,
                                          ),
                                          left: BorderSide(color: Colors.grey),
                                          top: BorderSide(color: Colors.grey),
                                          bottom: BorderSide(
                                            color: Colors.grey,
                                          ))),
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  height: 40,
                                  width: 200,
                                ),
                                dropdownStyleData: const DropdownStyleData(
                                  maxHeight: 200,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                                dropdownSearchData: DropdownSearchData(
                                  searchController: ticketnumberController,
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
                                      controller: ticketnumberController,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        hintText: 'Search Ticket Number',
                                        hintStyle:
                                            const TextStyle(fontSize: 12),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  searchMatchFn: (item, searchValue) {
                                    return item.value
                                        .toString()
                                        .contains(searchValue);
                                  },
                                ),
                                //This to clear the search value when you close the menu
                                onMenuStateChange: (isOpen) {
                                  if (!isOpen) {
                                    ticketnumberController.clear();
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            color: Colors.white,
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: const Text(
                                  'Select Service provider.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                                items: serviceProvider
                                    .map((item) => DropdownMenuItem(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                        ))
                                    .toList(),
                                value: selectedTicketNumber,
                                onChanged: (value) {
                                  isServiceProviderSelected = false;
                                  selectedServiceProvider = value;
                                  setState(() {
                                    selectedServiceProvider = value;
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      border: Border(
                                          right: BorderSide(
                                            color: Colors.grey,
                                          ),
                                          left: BorderSide(color: Colors.grey),
                                          top: BorderSide(color: Colors.grey),
                                          bottom: BorderSide(
                                            color: Colors.grey,
                                          ))),
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  height: 40,
                                  width: 200,
                                ),
                                dropdownStyleData: const DropdownStyleData(
                                  maxHeight: 200,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                                dropdownSearchData: DropdownSearchData(
                                  searchController: serviceProviderController,
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
                                      controller: serviceProviderController,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        hintText: 'Search service provider',
                                        hintStyle:
                                            const TextStyle(fontSize: 12),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  searchMatchFn: (item, searchValue) {
                                    return item.value
                                        .toString()
                                        .contains(searchValue);
                                  },
                                ),
                                //This to clear the search value when you close the menu
                                onMenuStateChange: (isOpen) {
                                  if (!isOpen) {
                                    serviceProvider.clear();
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                                  updateData()
                                      .whenComplete(() => popupmessage());
                                },
                                child: const Text('Save'))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  void popupmessage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: AlertDialog(
              content: const Text(
                'Changes saved successfully!!',
                style: TextStyle(fontSize: 14, color: Colors.green),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
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
}
