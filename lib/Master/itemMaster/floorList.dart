
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_management_system/Master/itemMaster/roomList.dart';
import 'package:ticket_management_system/providers/floorProvider.dart';

class FloorList extends StatefulWidget {
  const FloorList({super.key, required this.buildingNumber});
  final String buildingNumber;

  @override
  State<FloorList> createState() => _FloorListState();
}

class _FloorListState extends State<FloorList> {
  TextEditingController floorNumberController = TextEditingController();
  List<String> floorNumberList = [];

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData(widget.buildingNumber).whenComplete(() => setState(() {
          isLoading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Floor List',
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
              Consumer<AllFloorProvider>(builder: (context, value, child) {
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
                                itemCount: value.floorList.length,
                                itemBuilder: (item, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => RoomList(
                                                floorNumber:
                                                    value.floorList[index],
                                                buildingNumber:
                                                    widget.buildingNumber,
                                              ),
                                            ),
                                          );
                                        },
                                        title: Text(
                                          value.floorList[index],
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        trailing: IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            deletefloorNumber(
                                                value.floorList[index],
                                                widget.buildingNumber);
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
                              addfloorNumber();
                            },
                            child: const Icon(Icons.add),
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

  Future storeData(String floorNumber, String buildingNumber) async {
    final provider = Provider.of<AllFloorProvider>(context, listen: false);
    await FirebaseFirestore.instance
        .collection('buildingNumbers')
        .doc(buildingNumber)
        .collection('floorNumbers')
        .doc(floorNumber)
        .set({
      'floorNumber': floorNumber,
    });
    provider.addSingleList({'floorNumber': floorNumber});
  }

  Future<void> fetchData(String buildingNumber) async {
    final provider = Provider.of<AllFloorProvider>(context, listen: false);
    provider.setBuilderList([]);
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('buildingNumbers')
        .doc(buildingNumber)
        .collection('floorNumbers')
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();
      floorNumberList = tempData;
      print(floorNumberList);
      provider.setBuilderList(floorNumberList);
    }
  }

  Future<void> deletefloorNumber(
      String floorNumber, String buildingNumber) async {
    final provider = Provider.of<AllFloorProvider>(context, listen: false);
    await FirebaseFirestore.instance
        .collection('buildingNumbers')
        .doc(buildingNumber)
        .collection('floorNumbers')
        .doc(floorNumber)
        .delete();
    provider.removeData(floorNumberList.indexOf(floorNumber));
  }

  void addfloorNumber() {
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
                              controller: floorNumberController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Add Floor No',
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
                                  storeData(floorNumberController.text,
                                          widget.buildingNumber)
                                      .whenComplete(() {
                                    popupmessage(
                                        'Floor No. added successfully!!');
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
    final provider = Provider.of<AllFloorProvider>(context, listen: false);
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
                      fetchData(widget.buildingNumber).whenComplete(() {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        floorNumberController.clear();
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
