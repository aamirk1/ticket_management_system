
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_management_system/Master/itemMaster/floorList.dart';
import 'package:ticket_management_system/providers/buildingProvider.dart';

class ItemMaster extends StatefulWidget {
  const ItemMaster({super.key});

  @override
  State<ItemMaster> createState() => _ItemMasterState();
}

class _ItemMasterState extends State<ItemMaster> {
  TextEditingController buildingNumberController = TextEditingController();
  List<String> buildingNumberList = [];

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData().whenComplete(() => setState(() {
          isLoading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Building Number List',
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
          : Center(child:
              Consumer<AllBuildingProvider>(builder: (context, value, child) {
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
                                itemCount: value.buildingList.length,
                                itemBuilder: (item, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => FloorList(
                                                buildingNumber:
                                                    value.buildingList[index],
                                              ),
                                            ),
                                          );
                                        },
                                        title: Text(
                                          value.buildingList[index],
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        trailing: IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            deletebuildingNumber(
                                                value.buildingList[index]);
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
                              addbuildingNumber();
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

  Future<void> fetchData() async {
    final provider = Provider.of<AllBuildingProvider>(context, listen: false);
    provider.setBuilderList([]);
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('buildingNumbers').get();
    if (querySnapshot.docs.isNotEmpty) {
      List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();
      buildingNumberList = tempData;
      provider.setBuilderList(buildingNumberList);
    }
  }

  Future<void> deletebuildingNumber(String buildingNumber) async {
    final provider = Provider.of<AllBuildingProvider>(context, listen: false);
    await FirebaseFirestore.instance
        .collection('buildingNumbers')
        .doc(buildingNumber)
        .delete();
    provider.removeData(buildingNumberList.indexOf(buildingNumber));
  }

  void addbuildingNumber() {
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
                              controller: buildingNumberController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Add Building No',
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
                                storeData(buildingNumberController.text)
                                    .whenComplete(() {
                                  popupmessage(
                                      'Building No. added successfully!!');
                                });
                              },
                              child: const Text('Save'),
                            )
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

  Future storeData(String buildingNumber) async {
    final provider = Provider.of<AllBuildingProvider>(context, listen: false);
    try {
      await FirebaseFirestore.instance
          .collection('buildingNumbers')
          .doc(buildingNumber)
          .set({
        'buildingNumber': buildingNumber,
      });
      provider.addSingleList({'buildingNumber': buildingNumber});
      // ignore: nullable_type_in_catch_clause
    } catch (e) {
      print('Error storing data: $e');
    }
  }

  void popupmessage(String msg) {
    final provider = Provider.of<AllBuildingProvider>(context, listen: false);
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
                      fetchData().whenComplete(() {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        buildingNumberController.clear();
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
