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
        serviceProviderData().whenComplete(() {
          setState(() {
            isLoading = false;
          });
        });

        // onetose();
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
                            return const Home(
                                // adminId: widget.adminId,
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
            allServiceProviderDataList = allServiceProviderList;

            // print('all Service Provider $allServiceProviderList');
          }
          // openTicketSP.add(serviceProvider);
          // openTicketBySP.add(ticketList.length);
        }

        // if (currentticketList.isNotEmpty) {}
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

  Future<void> serviceProviderData() async {
    for (var x = 0; x < serviceProviderList.length; x++) {
      allServiceProviderList.clear();
      rowData.add(serviceProviderList[x]);

//start

      if (allServiceProviderList.isNotEmpty) {
        Map<String, int> providerCounts = {};

        // Iterate through the list and count occurrences
        for (String provider in allServiceProviderList) {
          if (providerCounts.containsKey(provider)) {
            providerCounts[provider] = providerCounts[provider]! + 1;
          } else {
            providerCounts[provider] = 1;
          }

          // Print the counts
          print(
              providerCounts); // Output: {Sushil Bagve: 3, Sanket Raut: 1, Krishna Murthy: 2, Vinayak Pashte: 1, : 1}

          // Get the count for a specific provider
          int sushilBagveCount = providerCounts["Sushil Bagve"] ?? 0;
          print(
              "Sushil Bagve count: $sushilBagveCount"); // Output: Sushil Bagve count: 3
        }
      }

//end

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
    }
  }
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
