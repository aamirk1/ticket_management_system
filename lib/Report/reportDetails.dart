import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:ticket_management_system/Report/imageScreen.dart';
import 'package:ticket_management_system/Report/upDateServiceProvider.dart';
import 'package:ticket_management_system/utils/colors.dart';

// ignore: must_be_immutable
class ReportDetails extends StatefulWidget {
  ReportDetails({super.key, required this.data});
  List<dynamic> data;
  @override
  State<ReportDetails> createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  List<List<String>> rowData = [];
  List<String> assetList = [];
  List<String> floorList = [];
  List<String> buildingList = [];
  List<String> roomList = [];
  List<String> dateList = [];
  List<String> dateClosedList = [];
  List<String> workList = [];
  List<String> serviceList = [];
  List<String> tatList = [];
  List<String> statusList = [];
  List<String> userList = [];
  List<String> remarkList = [];
  List<String> pictureList = [];
  List<String> assignList = [];
  List<String> reviveList = [];
  List<String> ticketNumList = [];

  List<dynamic> ticketList = [];
  List<String> ticketNumberList = [];
  List<String> yearList = [];
  List<String> monthList = [];
  List<String> dayList = [];

  List<String> serviceProvider = [];
  List<dynamic> allData = [];
  String? selectedServiceProvider;
  List<String> allTicketData = [];
  bool isLoading = true;

  String asset = '';
  String building = '';
  String floor = '';
  String remark = '';
  String room = '';
  String work = '';
  String serviceprovider = '';
  List<dynamic> ticketListData = [];
  @override
  void initState() {
    getdata().whenComplete(() => setState(() {
          isLoading = false;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Report Details',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.purple, Colors.deepPurple])),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.95,
                  width: MediaQuery.of(context).size.width * 0.99,
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: ticketList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: 0.9,
                              crossAxisCount: 3),
                      itemBuilder: (
                        context,
                        index,
                      ) {
                        List<String> imageFilePaths = List<String>.from(
                            ticketListData[index]['imageFilePaths'] ?? []);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      ticketCard(
                                          Icons.work,
                                          "Status: ",
                                          ticketListData[index]['status'] ??
                                              "N/A",
                                          index)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      ticketCard(Icons.work, "Ticket No.: ",
                                          ticketList[index] ?? "N/A", index)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      ticketCard(
                                          Icons.work,
                                          "Date (Opened): ",
                                          ticketListData[index]['date'] ??
                                              "N/A",
                                          index)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      ticketCard(
                                          Icons.work,
                                          "Date (Closed): ",
                                          ticketListData[index]['dateClosed'] ??
                                              "N/A",
                                          index)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      ticketCard(
                                          Icons.business,
                                          'Tat: ',
                                          ticketListData[index]['tat'] ?? "N/A",
                                          index)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      ticketCard(
                                          Icons.business,
                                          'Work: ',
                                          ticketListData[index]['work'] ??
                                              "N/A",
                                          index)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      ticketCard(
                                          Icons.layers,
                                          "Building: ",
                                          ticketListData[index]['building']
                                              .toString(),
                                          index)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      ticketCard(
                                          Icons.layers,
                                          "Floor: ",
                                          ticketListData[index]['floor']
                                              .toString(),
                                          index)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      ticketCard(
                                          Icons.room,
                                          'Room: ',
                                          ticketListData[index]['room'] ??
                                              "N/A",
                                          index)
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      ticketCard(
                                          Icons.account_balance,
                                          "Asset: ",
                                          ticketListData[index]['asset'] ??
                                              "N/A",
                                          index)
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      ticketCard(
                                          Icons.build,
                                          'User: ',
                                          ticketListData[index]['user'] ??
                                              "N/A",
                                          index)
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      ticketCard(
                                          Icons.build,
                                          'ServiceProvider: ',
                                          ticketListData[index]
                                                  ['serviceProvider'] ??
                                              "N/A",
                                          index)
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Row(children: [
                                    ticketCard(
                                        Icons.comment,
                                        'Remark: ',
                                        ticketListData[index]['remark'] ??
                                            "N/A",
                                        index)
                                  ]),
                                  const SizedBox(height: 2),
                                  SizedBox(
                                    height: 50,
                                    child: ListView.builder(
                                      itemCount: imageFilePaths.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index2) =>
                                          SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: isLoading
                                            ? const CircularProgressIndicator()
                                            : kIsWeb
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: ImageNetwork(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ImageScreen(
                                                                          pageTitle:
                                                                              'Report Page',
                                                                          imageFiles:
                                                                              imageFilePaths,
                                                                          initialIndex:
                                                                              index2,
                                                                          imageFile:
                                                                              imageFilePaths[index2],
                                                                          ticketId:
                                                                              ticketList[index],
                                                                        )));
                                                      },
                                                      image: imageFilePaths[
                                                          index2],
                                                      // put a height and width because they are required
                                                      height: 50,
                                                      width: 50,
                                                      curve: Curves.easeIn,
                                                      fitWeb: BoxFitWeb.cover,
                                                      onLoading:
                                                          const CircularProgressIndicator(
                                                        color:
                                                            Colors.indigoAccent,
                                                      ),
                                                      onError: const Icon(
                                                        Icons.error,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  )
                                                // Padding(
                                                //     padding:
                                                //         const EdgeInsets
                                                //             .all(8.0),
                                                //     child: Image.network(
                                                //       height: 50,
                                                //       fit: BoxFit.cover,
                                                //       imageFilePaths[
                                                //           index2],
                                                //     ),
                                                //   )
                                                : const Icon(
                                                    Icons.image,
                                                    color: black,
                                                    size: 50,
                                                  ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Row(children: [
                                    const Text('Revive: ',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 100),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return  UpdateServiceProvider(
                                                year:   ticketListData[index]['year']
                                                      .toString(),
                                                month:   ticketListData[index]
                                                      ['month'],
                                                 day:  ticketListData[index]['date'],
                                                ticketId:  ticketList[index]);
                                            }),
                                          );
                                        },
                                        child: const Text('Re Assign'))
                                  ]),
                                  const SizedBox(height: 2),
                                  Row(children: [
                                    const Text('Revive: ',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 100),
                                    ElevatedButton(
                                        onPressed: () {
                                          if (ticketListData[index]['status'] ==
                                              'Close') {
                                            updateTicketStatus(
                                                ticketListData[index]['year']
                                                    .toString(),
                                                ticketListData[index]['month'],
                                                ticketListData[index]['date'],
                                                ticketList[index]);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Center(
                                                    child: Text(
                                                        'Ticket Already Open'),
                                                  )),
                                            );
                                          }
                                        },
                                        child: const Text('Revive'))
                                  ]),
                                ],
                              ),
                            ),
                          ),
                        );

                        // Row(
                        //   children: [
                        //     Container(
                        //       margin: const EdgeInsets.only(top: 10),
                        //       height: 360,
                        //       width: 350,
                        //       child: Card(
                        //           elevation: 10,
                        //           child: Padding(
                        //             padding: const EdgeInsets.all(8.0),
                        //             child: Column(
                        //               children: [
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceAround,
                        //                   children: [
                        //                     const Text(
                        //                       'Status ',
                        //                       style: TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                     Text(
                        //                       ticketListData[index]['status'],
                        //                       style:
                        //                           const TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceAround,
                        //                   children: [
                        //                     const Text(
                        //                       'Ticket No.: ',
                        //                       style: TextStyle(
                        //                         color: black,
                        //                       ),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                     Text(
                        //                       ticketListData[index],
                        //                       style: const TextStyle(
                        //                         color: black,
                        //                       ),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 const SizedBox(
                        //                   height: 10,
                        //                 ),
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceAround,
                        //                   children: [
                        //                     const Text(
                        //                       'Date (Opened)',
                        //                       style: TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                     Text(
                        //                       ticketListData[index]['date'],
                        //                       style:
                        //                           const TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceAround,
                        //                   children: [
                        //                     const Text(
                        //                       'Date (Closed)',
                        //                       style: TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                     Text(
                        //                       ticketListData[index]['closed'],
                        //                       style:
                        //                           const TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceAround,
                        //                   children: [
                        //                     const Text(
                        //                       'TAT ',
                        //                       style: TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                     Text(
                        //                       ticketListData[index]['tat'],
                        //                       style:
                        //                           const TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceAround,
                        //                   children: [
                        //                     const Text(
                        //                       'Work ',
                        //                       style: TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                     Text(
                        //                       ticketListData[index]['work'],
                        //                       style:
                        //                           const TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceAround,
                        //                   children: [
                        //                     const Text(
                        //                       'Building ',
                        //                       style: TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                     Text(
                        //                       ticketListData[index]['building'],
                        //                       style:
                        //                           const TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceAround,
                        //                   children: [
                        //                     const Text(
                        //                       'Floor No. ',
                        //                       style: TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                     Text(
                        //                       ticketListData[index]['floor'],
                        //                       style:
                        //                           const TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceAround,
                        //                   children: [
                        //                     const Text(
                        //                       'Room No. ',
                        //                       style: TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                     Text(
                        //                       ticketListData[index]['room'],
                        //                       style:
                        //                           const TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceAround,
                        //                   children: [
                        //                     const Text(
                        //                       'Asset',
                        //                       style: TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                     Text(
                        //                       ticketListData[index][asset],
                        //                       style:
                        //                           const TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceAround,
                        //                   children: [
                        //                     const Text(
                        //                       'User',
                        //                       style: TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                     Text(
                        //                       ticketListData[index]['user'],
                        //                       style:
                        //                           const TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceAround,
                        //                   children: [
                        //                     const Text(
                        //                       'Service Provider ',
                        //                       style: TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                     Text(
                        //                       ticketListData[index]
                        //                           ['serviceProvider'],
                        //                       style:
                        //                           const TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceAround,
                        //                   children: [
                        //                     const Text(
                        //                       'Remarks',
                        //                       style: TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                     Text(
                        //                       ticketListData[index]['remark'],
                        //                       style:
                        //                           const TextStyle(color: black),
                        //                       textAlign: TextAlign.justify,
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceAround,
                        //                   children: [
                        //                     const Text(
                        //                       'Re-Assign ',
                        //                       style: TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                     Text(
                        //                       ticketListData[index]['reAssign'],
                        //                       style:
                        //                           const TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceAround,
                        //                   children: [
                        //                     const Text(
                        //                       'Revive ',
                        //                       style: TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                     Text(
                        //                       ticketListData[index]['revive'],
                        //                       style:
                        //                           const TextStyle(color: black),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ],
                        //             ),
                        //           )),
                        //     ),
                        //   ],
                        // );
                      }))
            ]),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context) {
      //       return const UpdateServiceProvider();
      //     }));
      //   },
      //   backgroundColor: Colors.deepPurple,
      //   child: const Icon(Icons.add, color: white),
      // ),
    );
  }

  Future<void> getYearList() async {
    // final provider = Provider.of<AllRoomProvider>(context, listen: false);
    // provider.setBuilderList([]);
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('raisedTickets').get();
    if (querySnapshot.docs.isNotEmpty) {
      List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();
      yearList = tempData;
    }
    setState(() {});
  }

  Future<void> getMonthList() async {
    // final provider = Provider.of<AllRoomProvider>(context, listen: false);
    // provider.setBuilderList([]);
    for (var i = 0; i < yearList.length; i++) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('raisedTickets')
          .doc(yearList[i])
          .collection('months')
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();
        monthList = tempData;
      }
      setState(() {});
    }
  }

  Future<void> getDayList() async {
    // final provider = Provider.of<AllRoomProvider>(context, listen: false);
    // provider.setBuilderList([]);
    for (var i = 0; i < yearList.length; i++) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('raisedTickets')
          .doc(yearList[i])
          .collection('months')
          .doc(monthList[i])
          .collection('date')
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();
        dayList = tempData;
      }
      setState(() {});
    }
  }

  // Future<void> getTicketList() async {
  //   // final provider = Provider.of<AllRoomProvider>(context, listen: false);
  //   // provider.setBuilderList([]);
  //   for (var i = 0; i < yearList.length; i++) {
  //     for (var j = 0; j < monthList.length; j++) {
  //       for (var k = 0; k < dayList.length; k++) {
  //         QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //             .collection('raisedTickets')
  //             .doc(yearList[i])
  //             .collection('months')
  //             .doc(monthList[j])
  //             .collection('date')
  //             .doc(dayList[k])
  //             .collection('tickets')
  //             .get();
  //         if (querySnapshot.docs.isNotEmpty) {
  //           List<String> tempData =
  //               querySnapshot.docs.map((e) => e.id).toList();
  //           ticketList = tempData;
  //         }
  //         ticketNumList.add(ticketList.toString());
  //         setState(() {});
  //         print('ticketList: $ticketList');
  //       }
  //     }
  //   }
  // }

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
          List<dynamic> temp = [];
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
              asset = mapData['asset'] ?? "N/A";
              building = mapData['building'] ?? "N/A";
              floor = mapData['floor'] ?? "N/A";
              remark = mapData['remark'] ?? "N/A";
              room = mapData['room'] ?? "N/A";
              work = mapData['work'] ?? "N/A";
              serviceprovider = mapData['serviceProvider'] ?? "";
              ticketListData.add(mapData);
              // print('$mapData abc');
            }
          }
        }
      }
    } catch (e) {
      print("Error Fetching tickets: $e");
    }
  }

  Widget ticketCard(
      IconData icons, String title, String ticketListData, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Icon(icons, color: Colors.deepPurple),
        // const SizedBox(width: 20),
        Text(title,
            textAlign: TextAlign.start,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 100),
        Text(ticketListData)
      ],
    );
  }

  Future<void> updateTicketStatus(
      String year, String month, String date, String ticketId) async {
    await FirebaseFirestore.instance
        .collection("raisedTickets")
        .doc(year)
        .collection('months')
        .doc(month)
        .collection('date')
        .doc(date)
        .collection('tickets')
        .doc(ticketId)
        .update({'status': 'Open'}).whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.green,
            content: Center(
              child: Text('Ticket Revived'),
            )),
      );
    });
  }
}
