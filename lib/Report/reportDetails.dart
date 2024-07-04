import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ticket_management_system/Report/upDateServiceProvider.dart';
import 'package:ticket_management_system/utils/colors.dart';

class ReportDetails extends StatefulWidget {
  const ReportDetails({super.key});

  @override
  State<ReportDetails> createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
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
  List<String> allTicketData = [];
  List<String> ticketNumberList = [];
  @override
  void initState() {
    getdata();
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
      body: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        width: MediaQuery.of(context).size.width * 0.99,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                  padding: const EdgeInsets.all(2.0),
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width * 0.99,
                  child: Row(children: [
                    GridView.builder(
                        itemCount: ticketNumberList.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                        ),
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 150,
                                width: 200,
                                child: Card(
                                    elevation: 10,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(children: [
                                          Text(ticketNumberList[index]),
                                          Text(allTicketData[index]),
                                          Text(allTicketData[index + 1]),
                                          Text(allTicketData[index + 2]),
                                          Text(allTicketData[index + 3]),
                                          Text(allTicketData[index + 4]),
                                          Text(allTicketData[index + 5]),
                                          Text(allTicketData[index + 6]),
                                          Text(allTicketData[index + 7]),
                                          Text(allTicketData[index + 8]),
                                          Text(allTicketData[index + 9]),
                                          Text(allTicketData[index + 10]),
                                          Text(allTicketData[index + 11]),
                                          Text(allTicketData[index + 12]),
                                          Text(allTicketData[index + 13]),
                                          Text(allTicketData[index + 14]),
                                        ]))),
                              ));
                        })
                  ])),
            )
          ],
        ),
      ),
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

  Future<void> getTicketNumberList() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('raisedTickets').get();

      if (querySnapshot.docs.isNotEmpty) {
        // Extract document IDs from the QuerySnapshot
        List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();

        // Update your ticketNumberList
        ticketNumberList = tempData;
        allTicketData = tempData;
        print(ticketNumberList);
      }
    } catch (e) {
      print("Error getting ticket numbers: $e");
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
