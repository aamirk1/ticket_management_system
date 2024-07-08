import 'package:cloud_firestore/cloud_firestore.dart';
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
  @override
  void initState() {
    super.initState();
    // getdate();
    getTicketList().whenComplete(() {
      getdata().whenComplete(() {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  List<String> ticketList = [];
  String todayTicket = '';
  List<String> oneToSevenTicket = [];
  List<String> eightToFourteenTicket = [];
  List<String> fifteenToTwentyOneTicket = [];
  List<String> twentyTwoToTwentyEightTicket = [];
  List<String> moreThanTwentyEightTicket = [];
  // List<String> columnName = [
  //   'Report Generated\n On Date',
  //   'Pending For\n (Days)',
  //   'For Less\nThan 01 Day',
  //   'Between\n 01 to 07',
  //   'Between\n 08 to 14',
  //   'Between\n 15 to 21',
  //   'Between\n 22 to 28',
  //   'For More Than\n 28 Days',
  // ];
  List<dynamic> rowData = [];
  String asset = '';
  String floor = '';
  String building = '';
  String room = '';
  String date = '';
  String convertedDate = '';
  String work = '';
  String serviceProvider = '';
  // String remark = '';
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  List<String> datelist = [];
  DateTime today = DateTime.now();
  //DateTime targetDate = today.add(Duration(days: 1));
  String day = '';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                    width: MediaQuery.of(context).size.width * 0.99,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card(
                          elevation: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 45,
                                  width: 100,
                                  color: purple,
                                  child: const Center(
                                    child: Text(
                                      'Tickets \nRaised On',
                                      style:
                                          TextStyle(fontSize: 16, color: white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 45,
                                  width: 100,
                                  color: purple,
                                  child: Center(
                                    child: Text(
                                      currentDate,
                                      style: const TextStyle(
                                          fontSize: 16, color: white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 45,
                                  width: 100,
                                  color: purple,
                                  child: const Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 5.0),
                                      child: Text(
                                        'Total Pending',
                                        style: TextStyle(
                                            fontSize: 16, color: white),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 45,
                                  width: 100,
                                  color: purple,
                                  child: Center(
                                    child: Text(
                                      ticketList.length.toString(),
                                      style: const TextStyle(
                                          fontSize: 16, color: white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 45,
                                  width: 100,
                                  color: purple,
                                  child: const Center(
                                    child: Text(
                                      'For Less\nThan 01 Day',
                                      style:
                                          TextStyle(fontSize: 16, color: white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 45,
                                  width: 100,
                                  color: purple,
                                  child: Center(
                                    child: Text(
                                      todayTicket.toString(),
                                      style: const TextStyle(
                                          fontSize: 16, color: white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 45,
                                  width: 100,
                                  color: purple,
                                  child: const Center(
                                    child: Text(
                                      '1 - 7 Days',
                                      style:
                                          TextStyle(fontSize: 16, color: white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 45,
                                  width: 100,
                                  color: purple,
                                  child: Center(
                                    child: Text(
                                      oneToSevenTicket.length.toString(),
                                      style: const TextStyle(
                                          fontSize: 16, color: white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 45,
                                  width: 100,
                                  color: purple,
                                  child: const Center(
                                    child: Text(
                                      '8 - 14 Days',
                                      style:
                                          TextStyle(fontSize: 16, color: white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 45,
                                  width: 100,
                                  color: purple,
                                  child: Center(
                                    child: Text(
                                      eightToFourteenTicket.length.toString(),
                                      style: const TextStyle(
                                          fontSize: 16, color: white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 45,
                                  width: 100,
                                  color: purple,
                                  child: const Center(
                                    child: Text(
                                      '15 - 21',
                                      style:
                                          TextStyle(fontSize: 16, color: white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 45,
                                  width: 100,
                                  color: purple,
                                  child: Center(
                                    child: Text(
                                      fifteenToTwentyOneTicket.length
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 16, color: white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 45,
                                  width: 100,
                                  color: purple,
                                  child: const Center(
                                    child: Text(
                                      '22 - 28 Days',
                                      style:
                                          TextStyle(fontSize: 16, color: white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 45,
                                  width: 100,
                                  color: purple,
                                  child: Center(
                                    child: Text(
                                      twentyTwoToTwentyEightTicket.length
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 16, color: white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 45,
                                  width: 100,
                                  color: purple,
                                  child: const Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 5.0),
                                      child: Text(
                                        'More Than 28 Days',
                                        style: TextStyle(
                                            fontSize: 16, color: white),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 45,
                                  width: 100,
                                  color: purple,
                                  child: Center(
                                    child: Text(
                                      moreThanTwentyEightTicket.length
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 16, color: white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 2,
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
                        )),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> getTicketList() async {
    // final provider = Provider.of<AllRoomProvider>(context, listen: false);
    // provider.setBuilderList([]);
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('raisedTickets').get();
    if (querySnapshot.docs.isNotEmpty) {
      List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();
      ticketList = tempData;
    }
  }

  Future<void> getdata() async {
    Map<String, dynamic> data = {};

    for (var i = 0; i < ticketList.length; i++) {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('raisedTickets')
          .doc(ticketList[i])
          .get();

      if (documentSnapshot.data() != null) {
        data = documentSnapshot.data() as Map<String, dynamic>;
      }
      date = data['date'] ?? 'N/A';
      convertedDate = date.split('-').reversed.join('-');

      // Index = 2
      if (currentDate == date) {
        todayTicket = ticketList.length.toString();
      } else {
        todayTicket = '0';
      }

      // Index = 3

      if ((i == 1) && (i < 7)) {
        for (int i = 1; i < 7; i++) {
          DateTime newdate = today.add(Duration(days: i));
          DateTime sevendays = newdate.add(const Duration(days: 6));
          DateFormat formatter = DateFormat('dd-MM-yyyy');

          if (newdate.isAfter(DateTime.parse(convertedDate)) == true) {
            datelist.add(formatter.format(newdate));
            for (int j = 0; j < datelist.length; j++) {
              // print('sevenday - ${newdate.isBefore(sevendays)}');
              // print(datelist[j]);
              newdate.add(const Duration(days: 1));
              // ignore: unrelated_type_equality_checks
              if (newdate.isBefore(sevendays) == datelist[j]) {
                oneToSevenTicket.add(ticketList[j].toString());
              }
            }
          } else {
            oneToSevenTicket.add('0');
          }
          oneToSevenTicket.add(ticketList.length.toString());
        }
        break;
      } else if ((i == 7) && (i < 15)) {
        for (int i = 7; i < 15; i++) {
          DateTime newdate = today.add(Duration(days: i));
          DateTime fifteendays = newdate.add(const Duration(days: 15));
          DateFormat formatter = DateFormat('dd-MM-yyyy');
          if (newdate.isAfter(DateTime.parse(convertedDate)) == true) {
            datelist.add(formatter.format(newdate));
            for (int j = 0; j < datelist.length; j++) {
              // print('sevenday - ${newdate.isBefore(sevendays)}');
              // print(datelist[j]);
              newdate.add(const Duration(days: 1));
              // ignore: unrelated_type_equality_checks
              if (newdate.isBefore(fifteendays) == datelist[j]) {
                eightToFourteenTicket.add(ticketList[j].toString());
              }
            }
          } else {
            eightToFourteenTicket.add('0');
          }
          eightToFourteenTicket.add(ticketList.length.toString());
        }
        break;
      } else if ((i == 15) && (i < 22)) {
        for (int i = 15; i < 22; i++) {
          DateTime newdate = today.add(Duration(days: i));
          DateTime twentyOnedays = newdate.add(const Duration(days: 21));
          DateFormat formatter = DateFormat('dd-MM-yyyy');
          if (newdate.isAfter(DateTime.parse(convertedDate)) == true) {
            datelist.add(formatter.format(newdate));
            for (int j = 0; j < datelist.length; j++) {
              // print('sevenday - ${newdate.isBefore(sevendays)}');
              // print(datelist[j]);
              newdate.add(const Duration(days: 1));
              // ignore: unrelated_type_equality_checks
              if (newdate.isBefore(twentyOnedays) == datelist[j]) {
                fifteenToTwentyOneTicket.add(ticketList[j].toString());
              }
            }
          } else {
            fifteenToTwentyOneTicket.add('0');
          }
          fifteenToTwentyOneTicket.add(ticketList.length.toString());
        }
      } else if ((i == 22) && (i < 29)) {
        for (int i = 22; i < 29; i++) {
          DateTime newdate = today.add(Duration(days: i));
          DateTime twentyEightdays = newdate.add(const Duration(days: 28));
          DateFormat formatter = DateFormat('dd-MM-yyyy');
          if (newdate.isAfter(DateTime.parse(convertedDate)) == true) {
            datelist.add(formatter.format(newdate));
            for (int j = 0; j < datelist.length; j++) {
              // print('sevenday - ${newdate.isBefore(sevendays)}');
              // print(datelist[j]);
              newdate.add(const Duration(days: 1));
              // ignore: unrelated_type_equality_checks
              if (newdate.isBefore(twentyEightdays) == datelist[j]) {
                twentyTwoToTwentyEightTicket.add(ticketList[j].toString());
              }
            }
          } else {
            twentyTwoToTwentyEightTicket.add('0');
          }
          twentyTwoToTwentyEightTicket.add(ticketList.length.toString());
        }
      } else if ((i == 29) && (i < 31)) {
        for (int i = 29; i < 31; i++) {
          DateTime newdate = today.add(Duration(days: i));
          DateTime moretwentyEightdays = newdate.add(const Duration(days: 31));
          DateFormat formatter = DateFormat('dd-MM-yyyy');
          if (newdate.isAfter(DateTime.parse(convertedDate)) == true) {
            datelist.add(formatter.format(newdate));
            for (int j = 0; j < datelist.length; j++) {
              // print('sevenday - ${newdate.isBefore(sevendays)}');
              // print(datelist[j]);
              newdate.add(const Duration(days: 1));
              // ignore: unrelated_type_equality_checks
              if (newdate.isBefore(moretwentyEightdays) == datelist[j]) {
                moreThanTwentyEightTicket.add(ticketList[j].toString());
              }
            }
          } else {
            moreThanTwentyEightTicket.add('0');
          }
          moreThanTwentyEightTicket.add(ticketList.length.toString());
        }
      }
    }
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

  //       // if (documentSnapshot.data() != null) {
  //       //   Timestamp timestamp =
  //       //       documentSnapshot['date']; // Assuming 'date' is the field name
  //       //   DateTime docDate = timestamp.toDate();

  //       //   if (docDate.isAfter(today) &&
  //       //       docDate.isBefore(today.add(Duration(days: 8)))) {
  //       //     list1to7.add(timestamp.toString());
  //       //   } else if (docDate.isAfter(today.add(Duration(days: 7))) &&
  //       //       docDate.isBefore(today.add(Duration(days: 16)))) {
  //       //     list8to15.add(timestamp.toString());
  //       //   }
  //       // }

  //       // querySnapshot.docs.forEach((doc) {

  //       // });

  //       // Print or use the categorized lists as needed
  //       // print('Documents from 1 to 7 days: ${list1to7.length}');
  //       // print('Documents from 8 to 15 days: ${list8to15.length}');

  //       // Example of using the lists:
  //       // list1to7.forEach((doc) {
  //       //   print('Document ID: ${doc.id}, Date: ${doc['date'].toDate()}');
  //       // });
  //       // list8to15.forEach((doc) {
  //       //   print('Document ID: ${doc.id}, Date: ${doc['date'].toDate()}');
  //       // });
  //     }
  //   } catch (e) {
  //     print('Error fetching documents: $e');
  //   }
  // }
}
