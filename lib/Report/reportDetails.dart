import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  List<String> ticketList = [];

  List<String> serviceProvider = [];
  List<dynamic> allData = [];
  String? selectedServiceProvider;
  List<String> allTicketData = [];
  bool isLoading = true;
  @override
  void initState() {
    getTicketList().whenComplete(() async {
      getdata();
      allFilterData().whenComplete(() {
        setState(() {
          isLoading = false;
        });
      });
      // ticketNumList =
      //     ticketNumList.where((e) => widget.data.contains(e)).toList();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      itemCount: ticketNumList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: 1.3,
                              crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: 360,
                              width: 350,
                              child: Card(
                                  elevation: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text(
                                              'Ticket No.: ',
                                              style: TextStyle(
                                                  color: black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              ticketList[index],
                                              style: const TextStyle(
                                                  color: black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text(
                                              'Date ',
                                              style: TextStyle(color: black),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              dateList[index],
                                              style:
                                                  const TextStyle(color: black),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text(
                                              'Building ',
                                              style: TextStyle(color: black),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              buildingList[index],
                                              style:
                                                  const TextStyle(color: black),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text(
                                              'Floor No. ',
                                              style: TextStyle(color: black),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              floorList[index],
                                              style:
                                                  const TextStyle(color: black),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text(
                                              'Room No. ',
                                              style: TextStyle(color: black),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              roomList[index],
                                              style:
                                                  const TextStyle(color: black),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text(
                                              'Work ',
                                              style: TextStyle(color: black),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              workList[index],
                                              style:
                                                  const TextStyle(color: black),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text(
                                              'Service Provider ',
                                              style: TextStyle(color: black),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              serviceList[index],
                                              style:
                                                  const TextStyle(color: black),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text(
                                              'TAT ',
                                              style: TextStyle(color: black),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              tatList[index],
                                              style:
                                                  const TextStyle(color: black),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text(
                                              'Status ',
                                              style: TextStyle(color: black),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              statusList[index],
                                              style:
                                                  const TextStyle(color: black),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text(
                                              'Remark ',
                                              style: TextStyle(color: black),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              remarkList[index],
                                              style:
                                                  const TextStyle(color: black),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text(
                                              'Re-Assign ',
                                              style: TextStyle(color: black),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              assignList[index],
                                              style:
                                                  const TextStyle(color: black),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text(
                                              'Revive ',
                                              style: TextStyle(color: black),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              reviveList[index],
                                              style:
                                                  const TextStyle(color: black),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        );
                      }))
            ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const UpdateServiceProvider();
          }));
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: white),
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
    setState(() {});
  }

  Future<void> getdata() async {
    String asset = '';
    String building = '';
    String date = '';
    String floor = '';
    String room = '';
    String service = '';
    String work = '';
    String tat = '';
    String status = '';
    String user = '';
    String remark = '';
    String assign = '';
    String revive = '';
    Map<String, dynamic> data = {};

    for (var i = 0; i < ticketList.length; i++) {
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
        status = data['status'] ?? 'open';
        user = data['user'] ?? 'user11';
        remark = data['remark'] ?? 'remark';
        // picture = data['picture'] ?? 'picture';
        assign = data['assign'] ?? 'assign';
        revive = data['revive'] ?? 'revive';
      }
      setState(() {});
      dateList.add(date);
      tatList.add(tat);
      ticketNumList.add(ticketList[i]);
      statusList.add(status);
      workList.add(work);
      buildingList.add(building);
      floorList.add(floor);
      roomList.add(room);
      assetList.add(asset);
      userList.add(user);
      serviceList.add(service);
      remarkList.add(remark);
      // allData.add(picture);
      assignList.add(assign);
      reviveList.add(revive);
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> allFilterData() async {
    // List<dynamic> fiterTicketData = [];
    if (widget.data[0] != null) {
      dateList = dateList.where((e) => widget.data.contains(e)).toList();
    } else if (widget.data[1] != null) {
      ticketList = ticketList.where((e) => widget.data.contains(e)).toList();
    } else if (widget.data[2] != null) {
      buildingList =
          buildingList.where((e) => widget.data.contains(e)).toList();
    } else if (widget.data[3] != null) {
      floorList = floorList.where((e) => widget.data.contains(e)).toList();
    } else if (widget.data[4] != null) {
      roomList = roomList.where((e) => widget.data.contains(e)).toList();
    } else if (widget.data[5] != null) {
      userList = userList.where((e) => widget.data.contains(e)).toList();
    } else if (widget.data[6] != null) {
      assetList = assetList.where((e) => widget.data.contains(e)).toList();
    } else if (widget.data[7] != null) {
      serviceList = serviceList.where((e) => widget.data.contains(e)).toList();
    } else if (widget.data[8] != null) {
      statusList = statusList.where((e) => widget.data.contains(e)).toList();
    } else if (widget.data[9] != null) {
      workList = workList.where((e) => widget.data.contains(e)).toList();
    } else {
      getdata().whenComplete(() {
        setState(() {
          isLoading = false;
        });
      });
    }
    print('ticketList $ticketList');
  }
}
