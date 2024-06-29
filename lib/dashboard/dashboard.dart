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
  String eightToFourteenTicket = '';
  String fifteenToTwentyOneTicket = '';
  String twentyTwoToTwentyEightTicket = '';
  String moreThanTwentyEightTicket = '';
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
                                  height: 50,
                                  width: 170,
                                  color: purple,
                                  child: const Center(
                                    child: Text(
                                      'Tickets \nRaised On',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: 170,
                                  color: purple,
                                  child: Center(
                                    child: Text(
                                      currentDate,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white),
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
                                  height: 50,
                                  width: 170,
                                  color: purple,
                                  child: const Center(
                                    child: Text(
                                      'Pending For',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: 170,
                                  color: purple,
                                  child: Center(
                                    child: Text(
                                      ticketList.length.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white),
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
                                  height: 50,
                                  width: 170,
                                  color: purple,
                                  child: const Center(
                                    child: Text(
                                      'For Less\nThan 01 Day',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: 170,
                                  color: purple,
                                  child: Center(
                                    child: Text(
                                      todayTicket.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white),
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
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20.0),
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
                                  height: 50,
                                  width: 170,
                                  color: purple,
                                  child: const Center(
                                    child: Text(
                                      '1 - 7 Days',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: 170,
                                  color: purple,
                                  child: Center(
                                    child: Text(
                                      oneToSevenTicket.length.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white),
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
                                  height: 50,
                                  width: 170,
                                  color: purple,
                                  child: const Center(
                                    child: Text(
                                      '8 - 14 Days',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: 170,
                                  color: purple,
                                  child: Center(
                                    child: Text(
                                      eightToFourteenTicket,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white),
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
                                  height: 50,
                                  width: 170,
                                  color: purple,
                                  child: const Center(
                                    child: Text(
                                      '15 - 21',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: 170,
                                  color: purple,
                                  child: Center(
                                    child: Text(
                                      fifteenToTwentyOneTicket,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white),
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
                                  height: 50,
                                  width: 170,
                                  color: purple,
                                  child: const Center(
                                    child: Text(
                                      '22 - 28 Days',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: 170,
                                  color: purple,
                                  child: Center(
                                    child: Text(
                                      twentyTwoToTwentyEightTicket,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white),
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
                                  height: 50,
                                  width: 170,
                                  color: purple,
                                  child: const Center(
                                    child: Text(
                                      'More Than 28 Days',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: 170,
                                  color: purple,
                                  child: Center(
                                    child: Text(
                                      moreThanTwentyEightTicket,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white),
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
    Map<String, dynamic> data = Map();

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
      print('convertedDate $convertedDate');

      // Index = 2
      if (currentDate == date) {
        todayTicket = ticketList.length.toString();
      } else {
        todayTicket = '0';
      }

      // Index = 3

      for (int i = 1; i < 7; i++) {
        DateTime newdate = today.add(Duration(days: i));
        DateFormat formatter = DateFormat('dd-MM-yyyy');

        if (newdate.isAfter(DateTime.parse(convertedDate)) == true) {
          datelist.add(formatter.format(newdate));
          oneToSevenTicket.add(ticketList.length.toString());
        } else {
          oneToSevenTicket.add('0');
        }
      }
      print('oneToSevenTicket $oneToSevenTicket');

      // Index = 4
      for (int i = 7; i < 15; i++) {
        DateTime newdate = today.add(Duration(days: i));
        DateFormat formatter = DateFormat('dd-MM-yyyy');
        if (newdate.isAfter(DateTime.parse(convertedDate))) {
          datelist.add(formatter.format(newdate));
          eightToFourteenTicket = ticketList.length.toString();
        } else {
          eightToFourteenTicket = '0';
        }
      }

      print('eightToFourteenTicket $eightToFourteenTicket');

      // Index = 5
      for (int i = 15; i < 22; i++) {
        DateTime newdate = today.add(Duration(days: i));
        DateFormat formatter = DateFormat('dd-MM-yyyy');
        if (newdate.isAfter(DateTime.parse(convertedDate))) {
          datelist.add(formatter.format(newdate));
          fifteenToTwentyOneTicket = ticketList.length.toString();
        } else {
          fifteenToTwentyOneTicket = '0';
        }
      }

      print('fifteenToTwentyOneTicket $fifteenToTwentyOneTicket');

      // Index = 6
      for (int i = 22; i < 29; i++) {
        DateTime newdate = today.add(Duration(days: i));
        DateFormat formatter = DateFormat('dd-MM-yyyy');
        if (newdate.isAfter(DateTime.parse(convertedDate))) {
          datelist.add(formatter.format(newdate));
          twentyTwoToTwentyEightTicket = ticketList.length.toString();
        } else {
          twentyTwoToTwentyEightTicket = '0';
        }
      }

      print('twentyTwoToTwentyEightTicket $twentyTwoToTwentyEightTicket');

      // Index = 7
      for (int i = 29; i <= 31; i++) {
        DateTime newdate = today.add(Duration(days: i));
        DateFormat formatter = DateFormat('dd-MM-yyyy');
        if (newdate.isAfter(DateTime.parse(convertedDate))) {
          datelist.add(formatter.format(newdate));
          moreThanTwentyEightTicket = ticketList.length.toString();
        } else {
          moreThanTwentyEightTicket = '0';
        }
      }

      print('moreThanTwentyEightTicket $moreThanTwentyEightTicket');
    }
  }
}
