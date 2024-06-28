
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_management_system/providers/designationProvider.dart';
import 'package:ticket_management_system/utils/colors.dart';

class ListOfDesignation extends StatefulWidget {
  const ListOfDesignation({super.key});

  @override
  State<ListOfDesignation> createState() => _ListOfDesignationState();
}

class _ListOfDesignationState extends State<ListOfDesignation> {
  TextEditingController designationController = TextEditingController();
  bool isLoading = true;
  List<String> designationList = [];
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
        title: const Text('List of Designation',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.purple, Colors.deepPurple])),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(child: Consumer<AllDesignationProvider>(
              builder: (context, value, child) {
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
                                itemCount: value.designationList.length,
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
                                          value.designationList[index],
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        trailing: IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            deleteDesignation(
                                              value.designationList[index],
                                            );
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
                              addDesignation();
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
    final provider =
        Provider.of<AllDesignationProvider>(context, listen: false);
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('designations').get();
    if (querySnapshot.docs.isNotEmpty) {
      List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();
      designationList = tempData;
      print(designationList);
    }

    provider.setBuilderList(designationList);
  }

  Future<void> deleteDesignation(String designation) async {
    final provider =
        Provider.of<AllDesignationProvider>(context, listen: false);
    await FirebaseFirestore.instance
        .collection('designations')
        .doc(designation)
        .delete();

    provider.removeData(provider.designationList.indexOf(designation));
  }

  void addDesignation() {
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
                              controller: designationController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Add Designation',
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
                                  storeData(designationController.text)
                                      .whenComplete(() {
                                    popupmessage(
                                        'Designation added successfully!!');
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

  Future storeData(String designation) async {
    final provider =
        Provider.of<AllDesignationProvider>(context, listen: false);
    await FirebaseFirestore.instance
        .collection('designations')
        .doc(designation)
        .set({
      'designation': designation,
    });
    provider.addSingleList({
      'designation': designation,
    });
  }

  void popupmessage(String msg) {
    final provider =
        Provider.of<AllDesignationProvider>(context, listen: false);
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
                        designationController.clear();
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
