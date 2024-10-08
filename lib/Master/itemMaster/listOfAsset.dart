import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_management_system/Master/itemMaster/editAssetForm.dart';
import 'package:ticket_management_system/providers/assetsProvider.dart';
import 'package:ticket_management_system/utils/colors.dart';

class ListOfAsset extends StatefulWidget {
  const ListOfAsset(
      {super.key,
      required this.buildingNumber,
      required this.floorNumber,
      required this.roomNumber});
  final String buildingNumber;
  final String floorNumber;
  final String roomNumber;

  @override
  State<ListOfAsset> createState() => _ListOfAssetState();
}

class _ListOfAssetState extends State<ListOfAsset> {
  TextEditingController assetController = TextEditingController();
  bool isLoading = true;
  List<String> assetList = [];
  @override
  void initState() {
    fetchData().whenComplete(() => setState(() {
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
          'List of Asset',
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
              Consumer<AllAssetProvider>(builder: (context, value, child) {
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
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.assetList.length,
                                itemBuilder: (item, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        // onTap: () {
                                        //   Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //       builder: (context) => RoomList(
                                        //         floorNumber:
                                        //             value.roomList[index],
                                        //         buildingNumber:
                                        //             widget.buildingNumber,
                                        //       ),
                                        //     ),
                                        //   );
                                        // },
                                        title: Text(
                                          value.assetList[index],
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.edit,
                                                color: black,
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditAssetForm(
                                                      assetId: value
                                                          .assetList[index],
                                                    ),
                                                  ),
                                                ).whenComplete(() {
                                                  setState(() {
                                                    fetchData();
                                                    isLoading = false;
                                                  });
                                                });
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                deleteAsset(
                                                  widget.buildingNumber,
                                                  widget.floorNumber,
                                                  widget.roomNumber,
                                                  value.assetList[index],
                                                );
                                              },
                                            ),
                                          ],
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
                              addAsset();
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

  Future<void> fetchData() async {
    final provider = Provider.of<AllAssetProvider>(context, listen: false);
    provider.setBuilderList([]);
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('buildingNumbers')
        .doc(widget.buildingNumber)
        .collection('floorNumbers')
        .doc(widget.floorNumber)
        .collection('roomNumbers')
        .doc(widget.roomNumber)
        .collection('assets')
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();
      assetList = tempData;
      provider.setBuilderList(assetList);
    }
  }

  Future<void> deleteAsset(String buildingNumber, String floorNumber,
      String roomNumber, String asset) async {
    final provider = Provider.of<AllAssetProvider>(context, listen: false);
    await FirebaseFirestore.instance
        .collection('buildingNumbers')
        .doc(buildingNumber)
        .collection('floorNumbers')
        .doc(floorNumber)
        .collection('roomNumbers')
        .doc(roomNumber)
        .collection('assets')
        .doc(asset)
        .delete();
    // print('successfully deleted');

    // provider.removeData(assetList.indexOf(asset));
    provider.removeData(assetList.indexOf(asset));
    print('successfully deletedw');
  }

  void addAsset() {
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
                              controller: assetController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Add Asset',
                                hintStyle: const TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(10),
                        //   child: Container(
                        //       color: Colors.white,
                        //       height: 40,
                        //       width: MediaQuery.of(context).size.width * 0.25,
                        //       child: Column(children: [
                        //         TextFormField(
                        //           expands: true,
                        //           maxLines: null,
                        //           controller: serviceProviderController,
                        //           decoration: InputDecoration(
                        //             isDense: true,
                        //             contentPadding: const EdgeInsets.symmetric(
                        //               horizontal: 10,
                        //               vertical: 8,
                        //             ),
                        //             hintText: 'Search flat no...',
                        //             hintStyle: const TextStyle(fontSize: 12),
                        //             border: OutlineInputBorder(
                        //               borderRadius: BorderRadius.circular(8),
                        //             ),
                        //           ),
                        //         ),
                        //       ])),
                        // ),
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
                                          widget.buildingNumber,
                                          widget.floorNumber,
                                          widget.roomNumber,
                                          assetController.text)
                                      .whenComplete(() {
                                    popupmessage('Asset added successfully!!');
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

  Future storeData(String buildingNumber, String floorNumber, String roomNumber,
      String asset) async {
    final provider = Provider.of<AllAssetProvider>(context, listen: false);
    await FirebaseFirestore.instance
        .collection('buildingNumbers')
        .doc(buildingNumber)
        .collection('floorNumbers')
        .doc(floorNumber)
        .collection('roomNumbers')
        .doc(roomNumber)
        .collection('assets')
        .doc(asset)
        .set({
      'asset': asset,
    });

    provider.addSingleList({
      'asset': asset,
    });
  }

  void popupmessage(String msg) {
    final provider = Provider.of<AllAssetProvider>(context, listen: false);
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
                        assetController.clear();
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
