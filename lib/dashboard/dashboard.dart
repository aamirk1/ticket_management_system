import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticket_management_system/Homescreen.dart';
import 'package:ticket_management_system/utils/colors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.adminId});
  final String adminId;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<dynamic> data = [];
  @override
  void initState() {
    super.initState();
    fetchServiceProvider().whenComplete(() {
      getdata().whenComplete(() {
        for (var x = 0; x < serviceProviderList.length; x++) {
          allServiceProviderList.clear();
          rowData.add(serviceProviderList[x]);
          print(serviceProviderList);
          rowData.add(ticketList.length);
          rowData.add(allCurrentticketList.length);
          rowData.add(16);
          rowData.add(5);
          rowData.add(6);
          rowData.add(4);
          rowData.add(2);
        }
        allServiceProviderList.add(rowData);
        int k = 0;
        int l = 8;
        for (var m = 0; m < allServiceProviderList[0].length; m++) {
          var data = [];

          for (var j = k; j < l; j++) {
            data.add(allServiceProviderList[0][j]);
          }
          allRowData.add(data);
          k = l;
          l = l + 8;
          if (allServiceProviderList[0].length < l) {
            break;
          }
          print('latest dataq $allRowData');
          print('ticketListLength ${ticketList.length}');
        }

        setState(() {
          isLoading = false;
        });
      });
    });
  }

  List<dynamic> ticketList = [];
  List<dynamic> allDateList = [];
  String todayTicket = '';
  List<dynamic> serviceProviderList = [];
  List<dynamic> allServiceProviderList = [];
  List<dynamic> allServiceProviderDataList = [];
  List<String> oneToSevenTicket = [];
  List<String> eightToFourteenTicket = [];
  List<String> fifteenToTwentyOneTicket = [];
  List<String> twentyTwoToTwentyEightTicket = [];
  List<String> moreThanTwentyEightTicket = [];
  List<dynamic> temp = [];
  List<String> columnName = [
    'Name Of \nService Provider',
    'Tickets Pending\n Total ',
    'For Less\nThan 01 Day',
    'Between\n 01 to 07',
    'Between\n 08 to 14',
    'Between\n 15 to 21',
    'Between\n 22 to 28',
    'For More Than\n 28 Days',
  ];
  List<dynamic> rowData = [];
  List<dynamic> allRowData = [];
  String asset = '';
  String floor = '';
  String building = '';
  String room = '';
  String date = '';
  String convertedDate = '';
  String work = '';
  String serviceProvider = '';
  String remark = '';
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  List<dynamic> ticketDataList = [];
  List<dynamic> openTicketList = [];
  List<dynamic> allCurrentticketList = [];
  List<dynamic> openTicketSP = [];
  List<dynamic> openTicketBySP = [];
  DateTime today = DateTime.now();
  //DateTime targetDate = today.add(Duration(days: 1));
  String day = '';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Center(
          child: Text(
            'Dashboard',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.purple, Colors.deepPurple])),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Center(
                  child: Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      width: MediaQuery.of(context).size.width * 0.90,
                      height: MediaQuery.of(context).size.height * 0.70,
                      child: DataTable2(
                        minWidth: 5000,
                        border: TableBorder.all(color: Colors.black),
                        headingRowColor: const WidgetStatePropertyAll(purple),
                        headingTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 50.0,
                        ),
                        columnSpacing: 5.0,
                        columns: List.generate(columnName.length, (index) {
                          return DataColumn2(
                            fixedWidth:
                                columnName[index] == 'Service Provider \n Name'
                                    ? 260
                                    : 110,
                            label: Container(
                              alignment: Alignment.center,
                              child: Text(
                                columnName[index].toString(),
                                style: const TextStyle(
                                    // overflow: TextOverflow.ellipsis,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        }),
                        rows: List.generate(
                          growable: true,
                          allRowData.length,
                          (index1) => DataRow2(
                            cells: List.generate(growable: true, 8, (index2) {
                              return DataCell(Padding(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                child: Center(
                                    child: Text(
                                        allRowData[index1][index2].toString())),
                              ));
                            }),
                          ),
                        ),
                      )

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     Card(
                      //       elevation: 20,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(20.0),
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //           children: [
                      //             Container(
                      //               height: 45,
                      //               width: 100,
                      //               color: purple,
                      //               child: const Center(
                      //                 child: Text(
                      //                   'Tickets \nRaised On',
                      //                   style:
                      //                       TextStyle(fontSize: 16, color: white),
                      //                 ),
                      //               ),
                      //             ),
                      //             const SizedBox(
                      //               height: 10,
                      //             ),
                      //             Container(
                      //               height: 45,
                      //               width: 100,
                      //               color: purple,
                      //               child: Center(
                      //                 child: Text(
                      //                   currentDate,
                      //                   style: const TextStyle(
                      //                       fontSize: 16, color: white),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     Card(
                      //       elevation: 20,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(20.0),
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //           children: [
                      //             Container(
                      //               height: 45,
                      //               width: 100,
                      //               color: purple,
                      //               child: const Center(
                      //                 child: Padding(
                      //                   padding: EdgeInsets.only(left: 5.0),
                      //                   child: Text(
                      //                     'Total Pending',
                      //                     style: TextStyle(
                      //                         fontSize: 16, color: white),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             const SizedBox(
                      //               height: 10,
                      //             ),
                      //             Container(
                      //               height: 45,
                      //               width: 100,
                      //               color: purple,
                      //               child: Center(
                      //                 child: Text(
                      //                   ticketList.length.toString(),
                      //                   style: const TextStyle(
                      //                       fontSize: 16, color: white),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     Card(
                      //       elevation: 20,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(20.0),
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //           children: [
                      //             Container(
                      //               height: 45,
                      //               width: 100,
                      //               color: purple,
                      //               child: const Center(
                      //                 child: Text(
                      //                   'For Less\nThan 01 Day',
                      //                   style:
                      //                       TextStyle(fontSize: 16, color: white),
                      //                 ),
                      //               ),
                      //             ),
                      //             const SizedBox(
                      //               height: 10,
                      //             ),
                      //             Container(
                      //               height: 45,
                      //               width: 100,
                      //               color: purple,
                      //               child: Center(
                      //                 child: Text(
                      //                   todayTicket.toString(),
                      //                   style: const TextStyle(
                      //                       fontSize: 16, color: white),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     Card(
                      //       elevation: 20,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(20.0),
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //           children: [
                      //             Container(
                      //               height: 45,
                      //               width: 100,
                      //               color: purple,
                      //               child: const Center(
                      //                 child: Text(
                      //                   '1 - 7 Days',
                      //                   style:
                      //                       TextStyle(fontSize: 16, color: white),
                      //                 ),
                      //               ),
                      //             ),
                      //             const SizedBox(
                      //               height: 10,
                      //             ),
                      //             Container(
                      //               height: 45,
                      //               width: 100,
                      //               color: purple,
                      //               child: Center(
                      //                 child: Text(
                      //                   oneToSevenTicket.length.toString(),
                      //                   style: const TextStyle(
                      //                       fontSize: 16, color: white),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     Card(
                      //       elevation: 20,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(20.0),
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //           children: [
                      //             Container(
                      //               height: 45,
                      //               width: 100,
                      //               color: purple,
                      //               child: const Center(
                      //                 child: Text(
                      //                   '8 - 14 Days',
                      //                   style:
                      //                       TextStyle(fontSize: 16, color: white),
                      //                 ),
                      //               ),
                      //             ),
                      //             const SizedBox(
                      //               height: 10,
                      //             ),
                      //             Container(
                      //               height: 45,
                      //               width: 100,
                      //               color: purple,
                      //               child: Center(
                      //                 child: Text(
                      //                   eightToFourteenTicket.length.toString(),
                      //                   style: const TextStyle(
                      //                       fontSize: 16, color: white),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     Card(
                      //       elevation: 20,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(20.0),
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //           children: [
                      //             Container(
                      //               height: 45,
                      //               width: 100,
                      //               color: purple,
                      //               child: const Center(
                      //                 child: Text(
                      //                   '15 - 21',
                      //                   style:
                      //                       TextStyle(fontSize: 16, color: white),
                      //                 ),
                      //               ),
                      //             ),
                      //             const SizedBox(
                      //               height: 10,
                      //             ),
                      //             Container(
                      //               height: 45,
                      //               width: 100,
                      //               color: purple,
                      //               child: Center(
                      //                 child: Text(
                      //                   fifteenToTwentyOneTicket.length
                      //                       .toString(),
                      //                   style: const TextStyle(
                      //                       fontSize: 16, color: white),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     Card(
                      //       elevation: 20,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(20.0),
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //           children: [
                      //             Container(
                      //               height: 45,
                      //               width: 100,
                      //               color: purple,
                      //               child: const Center(
                      //                 child: Text(
                      //                   '22 - 28 Days',
                      //                   style:
                      //                       TextStyle(fontSize: 16, color: white),
                      //                 ),
                      //               ),
                      //             ),
                      //             const SizedBox(
                      //               height: 10,
                      //             ),
                      //             Container(
                      //               height: 45,
                      //               width: 100,
                      //               color: purple,
                      //               child: Center(
                      //                 child: Text(
                      //                   twentyTwoToTwentyEightTicket.length
                      //                       .toString(),
                      //                   style: const TextStyle(
                      //                       fontSize: 16, color: white),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     Card(
                      //       elevation: 20,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(20.0),
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //           children: [
                      //             Container(
                      //               height: 45,
                      //               width: 100,
                      //               color: purple,
                      //               child: const Center(
                      //                 child: Padding(
                      //                   padding: EdgeInsets.only(left: 5.0),
                      //                   child: Text(
                      //                     'More Than 28 Days',
                      //                     style: TextStyle(
                      //                         fontSize: 16, color: white),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             const SizedBox(
                      //               height: 10,
                      //             ),
                      //             Container(
                      //               height: 45,
                      //               width: 100,
                      //               color: purple,
                      //               child: Center(
                      //                 child: Text(
                      //                   moreThanTwentyEightTicket.length
                      //                       .toString(),
                      //                   style: const TextStyle(
                      //                       fontSize: 16, color: white),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, left: 8.0, right: 25.0, bottom: 18),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: purple,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return Home(
                              adminId: widget.adminId,
                            );
                          }),
                        );
                      },
                      child: const Text(
                        'Proceed',
                        style: TextStyle(color: white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> fetchServiceProvider() async {
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
        // serviceProviderList.add(data['fullName']);
        serviceProviderList.add(data['fullName']);
      }
    }

    setState(() {});
  }

  Future<void> getdata() async {
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
          QuerySnapshot ticketQuery = await FirebaseFirestore.instance
              .collection("raisedTickets")
              .doc(currentYear.toString())
              .collection('months')
              .doc(months[i])
              .collection('date')
              .doc(dateList[j])
              .collection('tickets')
              .where('status', isEqualTo: 'Open')
              // .where('serviceProvider', isEqualTo: serviceProviderList[j])
              .get();

          for (DocumentSnapshot ticketDoc in ticketQuery.docs) {
            String? serviceProviderId = ticketDoc
                .get('serviceProvider'); // Use String? for nullable type

            // Handle null or empty serviceProviderId
            if (serviceProviderId != null && serviceProviderId.isNotEmpty) {
              if (!allServiceProviderList.contains(serviceProviderId)) {
                allServiceProviderList.add(serviceProviderId);
              }
            } else {
              print(
                  'Warning: Ticket ${ticketDoc.id} has a missing or empty serviceProvider field.');
            }
          }

          temp = ticketQuery.docs.map((e) => e.id).toList();
          ticketList = ticketList + temp;
          for (int k = 0; k < temp.length; k++) {
            DocumentSnapshot ticketDataQuery = await FirebaseFirestore.instance
                .collection("raisedTickets")
                .doc(currentYear.toString())
                .collection('months')
                .doc(months[i])
                .collection('date')
                .doc(dateList[j])
                .collection('tickets')
                .doc(temp[k])
                .get();
            if (ticketDataQuery.exists) {
              Map<String, dynamic> mapData =
                  ticketDataQuery.data() as Map<String, dynamic>;
              serviceProvider = mapData['serviceProvider'] ?? "";
            }

            allServiceProviderList.add(serviceProvider);

            print('all ServicepROVIDER $allServiceProviderList');
          }
          // openTicketSP.add(serviceProvider);
          // openTicketBySP.add(ticketList.length);
        }

        List<dynamic> currentticketList = [];

        String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
        for (int j = 0; j < dateList.length; j++) {
          QuerySnapshot ticketQuery = await FirebaseFirestore.instance
              .collection("raisedTickets")
              .doc(currentYear.toString())
              .collection('months')
              .doc(months[i])
              .collection('date')
              .doc(currentDate)
              .collection('tickets')
              // .where('serviceProvider', isEqualTo: serviceProviderList[j])
              .where('status', isEqualTo: 'Open')
              .get();
          temp = ticketQuery.docs.map((e) => e.id).toList();
          currentticketList = currentticketList + temp;
          allCurrentticketList = currentticketList;

          // serviceProviderList[j];
        }
        if (currentticketList.isNotEmpty) {}
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error Fetching tickets: $e");
      }
    }

    // Index = 3

    // if ((i == 1) && (i < 7)) {
    //   for (int i = 1; i < 7; i++) {
    //     DateTime newdate = today.add(Duration(days: i));
    //     DateTime sevendays = newdate.add(const Duration(days: 6));
    //     DateFormat formatter = DateFormat('dd-MM-yyyy');

    //     if (newdate.isAfter(DateTime.parse(convertedDate)) == true) {
    //       datelist.add(formatter.format(newdate));
    //       for (int j = 0; j < datelist.length; j++) {
    //         // print('sevenday - ${newdate.isBefore(sevendays)}');
    //         // print(datelist[j]);
    //         newdate.add(const Duration(days: 1));
    //         // ignore: unrelated_type_equality_checks
    //         if (newdate.isBefore(sevendays) == datelist[j]) {
    //           oneToSevenTicket.add(ticketList[j].toString());
    //         }
    //       }
    //     } else {
    //       oneToSevenTicket.add('0');
    //     }
    //     oneToSevenTicket.add(ticketList.length.toString());
    //   }
    //   break;
    // } else if ((i == 7) && (i < 15)) {
    //   for (int i = 7; i < 15; i++) {
    //     DateTime newdate = today.add(Duration(days: i));
    //     DateTime fifteendays = newdate.add(const Duration(days: 15));
    //     DateFormat formatter = DateFormat('dd-MM-yyyy');
    //     if (newdate.isAfter(DateTime.parse(convertedDate)) == true) {
    //       datelist.add(formatter.format(newdate));
    //       for (int j = 0; j < datelist.length; j++) {
    //         // print('sevenday - ${newdate.isBefore(sevendays)}');
    //         // print(datelist[j]);
    //         newdate.add(const Duration(days: 1));
    //         // ignore: unrelated_type_equality_checks
    //         if (newdate.isBefore(fifteendays) == datelist[j]) {
    //           eightToFourteenTicket.add(ticketList[j].toString());
    //         }
    //       }
    //     } else {
    //       eightToFourteenTicket.add('0');
    //     }
    //     eightToFourteenTicket.add(ticketList.length.toString());
    //   }
    //   break;
    // } else if ((i == 15) && (i < 22)) {
    //   for (int i = 15; i < 22; i++) {
    //     DateTime newdate = today.add(Duration(days: i));
    //     DateTime twentyOnedays = newdate.add(const Duration(days: 21));
    //     DateFormat formatter = DateFormat('dd-MM-yyyy');
    //     if (newdate.isAfter(DateTime.parse(convertedDate)) == true) {
    //       datelist.add(formatter.format(newdate));
    //       for (int j = 0; j < datelist.length; j++) {
    //          print('sevenday - ${newdate.isBefore(sevendays)}');
    //          print(datelist[j]);
    //         newdate.add(const Duration(days: 1));
    //         // ignore: unrelated_type_equality_checks
    //         if (newdate.isBefore(twentyOnedays) == datelist[j]) {
    //           fifteenToTwentyOneTicket.add(ticketList[j].toString());
    //         }
    //       }
    //     } else {
    //       fifteenToTwentyOneTicket.add('0');
    //     }
    //     fifteenToTwentyOneTicket.add(ticketList.length.toString());
    //   }
    // } else if ((i == 22) && (i < 29)) {
    //   for (int i = 22; i < 29; i++) {
    //     DateTime newdate = today.add(Duration(days: i));
    //     DateTime twentyEightdays = newdate.add(const Duration(days: 28));
    //     DateFormat formatter = DateFormat('dd-MM-yyyy');
    //     if (newdate.isAfter(DateTime.parse(convertedDate)) == true) {
    //       datelist.add(formatter.format(newdate));
    //       for (int j = 0; j < datelist.length; j++) {
    //         // print('sevenday - ${newdate.isBefore(sevendays)}');
    //         // print(datelist[j]);
    //         newdate.add(const Duration(days: 1));
    //         // ignore: unrelated_type_equality_checks
    //         if (newdate.isBefore(twentyEightdays) == datelist[j]) {
    //           twentyTwoToTwentyEightTicket.add(ticketList[j].toString());
    //         }
    //       }
    //     } else {
    //       twentyTwoToTwentyEightTicket.add('0');
    //     }
    //     twentyTwoToTwentyEightTicket.add(ticketList.length.toString());
    //   }
    // } else if ((i == 29) && (i < 31)) {
    //   for (int i = 29; i < 31; i++) {
    //     DateTime newdate = today.add(Duration(days: i));
    //     DateTime moretwentyEightdays = newdate.add(const Duration(days: 31));
    //     DateFormat formatter = DateFormat('dd-MM-yyyy');
    //     if (newdate.isAfter(DateTime.parse(convertedDate)) == true) {
    //       datelist.add(formatter.format(newdate));
    //       for (int j = 0; j < datelist.length; j++) {
    //         // print('sevenday - ${newdate.isBefore(sevendays)}');
    //         // print(datelist[j]);
    //         newdate.add(const Duration(days: 1));
    //         // ignore: unrelated_type_equality_checks
    //         if (newdate.isBefore(moretwentyEightdays) == datelist[j]) {
    //           moreThanTwentyEightTicket.add(ticketList[j].toString());
    //         }
    //       }
    //     } else {
    //       moreThanTwentyEightTicket.add('0');
    //     }
    //     moreThanTwentyEightTicket.add(ticketList.length.toString());
    //   }
    // }
    // }
  }

  // void getdate() async {
  //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //   try {
  //     // Fetch all documents from 'raisedTickets' collection

  //     QuerySnapshot querySnapshot =
  //         await _firestore.collection('raisedTickets').get();

  //     // Categorize documents based on date ranges
  //     List<String> list1to7 = [];
  //     List<String> list8to15 = [];

  //     DateTime now = DateTime.now();
  //     DateTime today = DateTime(now.year, now.month, now.day);

  //     if (querySnapshot.docs.isNotEmpty) {
  //       List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();
  //       ticketList = tempData;
  //     }

  //     for (var i = 0; i < ticketList.length; i++) {
  //       DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
  //           .collection('raisedTickets')
  //           .doc(ticketList[i])
  //           .get();

  // if (documentSnapshot.data() != null) {
  //   Timestamp timestamp =
  //       documentSnapshot['date']; // Assuming 'date' is the field name
  //   DateTime docDate = timestamp.toDate();

  //   if (docDate.isAfter(today) &&
  //       docDate.isBefore(today.add(Duration(days: 8)))) {
  //     list1to7.add(timestamp.toString());
  //   } else if (docDate.isAfter(today.add(Duration(days: 7))) &&
  //       docDate.isBefore(today.add(Duration(days: 16)))) {
  //     list8to15.add(timestamp.toString());
  //   }
  // }

  // querySnapshot.docs.forEach((doc) {

  // });

  // Print or use the categorized lists as needed
  // print('Documents from 1 to 7 days: ${list1to7.length}');
  // print('Documents from 8 to 15 days: ${list8to15.length}');

  // Example of using the lists:
  // list1to7.forEach((doc) {
  //   print('Document ID: ${doc.id}, Date: ${doc['date'].toDate()}');
  // });
  // list8to15.forEach((doc) {
  //   print('Document ID: ${doc.id}, Date: ${doc['date'].toDate()}');
  // });
  //     }
  //   } catch (e) {
  //     print('Error fetching documents: $e');
  //   }
  // }
}






























        // if ((i == 1) && (i < 7)) {
        //   for (int i = 1; i < 7; i++) {
        //     DateTime newdate = today.add(Duration(days: i));
        //     DateTime sevendays = newdate.add(const Duration(days: 6));
        //     DateFormat formatter = DateFormat('dd-MM-yyyy');

        //     if (newdate.isAfter(DateTime.parse(convertedDate)) == true) {
        //       allDateList.add(formatter.format(newdate));
        //       for (int j = 0; j < allDateList.length; j++) {
        //         // print('sevenday - ${newdate.isBefore(sevendays)}');
        //         // print(datelist[j]);
        //         newdate.add(const Duration(days: 1));
        //         // ignore: unrelated_type_equality_checks
        //         if (newdate.isBefore(sevendays) == allDateList[j]) {
        //           oneToSevenTicket.add(ticketList[j].toString());
        //         }
        //         print('oneToSevenTicket - $oneToSevenTicket');
        //       }
        //     } else {
        //       oneToSevenTicket.add('0');
        //     }
        //     oneToSevenTicket.add(ticketList.length.toString());
        //   }
        //   break;
        // } else if ((i == 7) && (i < 15)) {
        //   for (int i = 7; i < 15; i++) {
        //     DateTime newdate = today.add(Duration(days: i));
        //     DateTime fifteendays = newdate.add(const Duration(days: 15));
        //     DateFormat formatter = DateFormat('dd-MM-yyyy');
        //     if (newdate.isAfter(DateTime.parse(convertedDate)) == true) {
        //       allDateList.add(formatter.format(newdate));
        //       for (int j = 0; j < allDateList.length; j++) {
        //         // print('sevenday - ${newdate.isBefore(sevendays)}');
        //         // print(datelist[j]);
        //         newdate.add(const Duration(days: 1));
        //         // ignore: unrelated_type_equality_checks
        //         if (newdate.isBefore(fifteendays) == allDateList[j]) {
        //           eightToFourteenTicket.add(ticketList[j].toString());
        //         }
        //       }
        //     } else {
        //       eightToFourteenTicket.add('0');
        //     }
        //     eightToFourteenTicket.add(ticketList.length.toString());
        //   }
        //   break;
        // }