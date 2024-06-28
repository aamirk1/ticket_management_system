
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_management_system/Master/itemMaster/listOfAsset.dart';
import 'package:ticket_management_system/providers/roomProvider.dart';
import 'package:ticket_management_system/utils/colors.dart';

class RoomList extends StatefulWidget {
  const RoomList(
      {super.key, required this.floorNumber, required this.buildingNumber});
  final String floorNumber;
  final String buildingNumber;

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  TextEditingController roomNumberController = TextEditingController();
  List<String> roomNumberList = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData(widget.buildingNumber, widget.floorNumber).whenComplete(
      () => setState(
        () {
          isLoading = false;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room List',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.purple, Colors.deepPurple])),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(child:
              Consumer<AllRoomProvider>(builder: (context, value, child) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Card(
                  elevation: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.roomList.length,
                                itemBuilder: (item, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ListOfAsset(
                                                buildingNumber:
                                                    widget.buildingNumber,
                                                floorNumber: widget.floorNumber,
                                                roomNumber:
                                                    value.roomList[index],
                                              ),
                                            ),
                                          );
                                        },
                                        title: Text(
                                          value.roomList[index],
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        trailing: IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            deleteroomNumber(
                                                value.roomList[index],
                                                widget.buildingNumber,
                                                widget.floorNumber);
                                          },
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.black,
                                      )
                                    ],
                                  );
                                }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton(
                            backgroundColor: Colors.deepPurple,
                            onPressed: () {
                              addroomNumber();
                            },
                            child: const Icon(Icons.add, color: white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            })),
    );
  }

  Future storeData(
      String roomNumber, String buildingNumber, String floorNumber) async {
    final provider = Provider.of<AllRoomProvider>(context, listen: false);
    await FirebaseFirestore.instance
        .collection('buildingNumbers')
        .doc(buildingNumber)
        .collection('floorNumbers')
        .doc(floorNumber)
        .collection('roomNumbers')
        .doc(roomNumber)
        .set({
      'roomNumber': roomNumber,
    });
    provider.addSingleList({'roomNumber': roomNumber});
  }

  Future<void> fetchData(String buildingNumber, String floorNumber) async {
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
      print(roomNumberList);
      provider.setBuilderList(roomNumberList);
    }
  }

  Future<void> deleteroomNumber(
      String roomNumber, String buildingNumber, String floorNumber) async {
    final provider = Provider.of<AllRoomProvider>(context, listen: false);
    await FirebaseFirestore.instance
        .collection('buildingNumbers')
        .doc(buildingNumber)
        .collection('floorNumbers')
        .doc(floorNumber)
        .collection('roomNumbers')
        .doc(roomNumber)
        .delete();
    provider.removeData(roomNumberList.indexOf(roomNumber));
  }

  void addroomNumber() {
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
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              expands: true,
                              maxLines: null,
                              controller: roomNumberController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Add Room No',
                                hintStyle: const TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
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
                                  storeData(
                                          roomNumberController.text,
                                          widget.buildingNumber,
                                          widget.floorNumber)
                                      .whenComplete(() {
                                    popupmessage(
                                        'Room No. added successfully!!');
                                  });
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

  void popupmessage(String msg) {
    final provider = Provider.of<AllRoomProvider>(context, listen: false);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: AlertDialog(
              content: Text(
                msg,
                style: const TextStyle(fontSize: 14, color: Colors.green),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      fetchData(widget.buildingNumber, widget.floorNumber)
                          .whenComplete(() {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        roomNumberController.clear();
                        provider.setLoadWidget(false);
                      });
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
}
