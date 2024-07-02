import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class UpdateServiceProvider extends StatefulWidget {
  const UpdateServiceProvider({super.key});

  @override
  State<UpdateServiceProvider> createState() => _UpdateServiceProviderState();
}

class _UpdateServiceProviderState extends State<UpdateServiceProvider> {
  bool isServiceProviderSelected = true;
  String? selectedServiceProvider;
  String? selectedTicketNumber;

  List<String> ticketList = [];
  List<String> ticketNumberList = [];
  List<String> serviceProvider = [];
  TextEditingController serviceProviderController = TextEditingController();
  TextEditingController ticketnumberController = TextEditingController();
  @override
  void initState() {
    getTicketList().whenComplete(() => setState(() {
          fetchData();
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Card(
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      color: Colors.white,
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: const Text(
                            'Select Ticket No.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          items: ticketList
                              .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ))
                              .toList(),
                          value: selectedTicketNumber,
                          onChanged: (value) {
                            setState(() {
                              selectedTicketNumber = value;
                            });
                          },
                          buttonStyleData: const ButtonStyleData(
                            decoration: BoxDecoration(),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 40,
                            width: 200,
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            maxHeight: 200,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                          dropdownSearchData: DropdownSearchData(
                            searchController: ticketnumberController,
                            searchInnerWidgetHeight: 50,
                            searchInnerWidget: Container(
                              height: 50,
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 4,
                                right: 8,
                                left: 8,
                              ),
                              child: TextFormField(
                                expands: true,
                                maxLines: null,
                                controller: ticketnumberController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  hintText: 'Search Ticket No.',
                                  hintStyle: const TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            searchMatchFn: (item, searchValue) {
                              return item.value
                                  .toString()
                                  .contains(searchValue);
                            },
                          ),
                          //This to clear the search value when you close the menu
                          onMenuStateChange: (isOpen) {
                            if (!isOpen) {
                              ticketnumberController.clear();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      color: Colors.white,
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: const Text(
                            'Select Service Provider',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          items: serviceProvider
                              .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ))
                              .toList(),
                          value: selectedServiceProvider,
                          onChanged: (value) {
                            setState(() {
                              selectedServiceProvider = value;
                            });
                          },
                          buttonStyleData: const ButtonStyleData(
                            decoration: BoxDecoration(),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 40,
                            width: 200,
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            maxHeight: 200,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                          dropdownSearchData: DropdownSearchData(
                            searchController: serviceProviderController,
                            searchInnerWidgetHeight: 50,
                            searchInnerWidget: Container(
                              height: 50,
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 4,
                                right: 8,
                                left: 8,
                              ),
                              child: TextFormField(
                                expands: true,
                                maxLines: null,
                                controller: serviceProviderController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  hintText: 'Search Service Provider',
                                  hintStyle: const TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            searchMatchFn: (item, searchValue) {
                              return item.value
                                  .toString()
                                  .contains(searchValue);
                            },
                          ),
                          //This to clear the search value when you close the menu
                          onMenuStateChange: (isOpen) {
                            if (!isOpen) {
                              serviceProviderController.clear();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10),
                  //   child: Container(
                  //     color: Colors.white,
                  //     height: 40,
                  //     width: MediaQuery.of(context).size.width * 0.25,
                  //     child: DropdownButtonHideUnderline(
                  //       child: DropdownButton2<String>(
                  //         isExpanded: true,
                  //         hint: const Text(
                  //           'Select Service provider.',
                  //           style: TextStyle(
                  //             color: Colors.black,
                  //             fontSize: 12,
                  //           ),
                  //         ),
                  //         items: serviceProvider
                  //             .map((item) => DropdownMenuItem(
                  //                   value: item,
                  //                   child: Text(
                  //                     item,
                  //                     style: const TextStyle(
                  //                         fontSize: 14, color: Colors.black),
                  //                   ),
                  //                 ))
                  //             .toList(),
                  //         value: selectedServiceProvider,
                  //         onChanged: (value) {
                  //           isServiceProviderSelected = false;
                  //           selectedServiceProvider = value;
                  //           setState(() {
                  //             selectedServiceProvider = value;
                  //           });
                  //         },
                  //         buttonStyleData: const ButtonStyleData(
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.all(
                  //                 Radius.circular(10),
                  //               ),
                  //               border: Border(
                  //                   right: BorderSide(
                  //                     color: Colors.grey,
                  //                   ),
                  //                   left: BorderSide(color: Colors.grey),
                  //                   top: BorderSide(color: Colors.grey),
                  //                   bottom: BorderSide(
                  //                     color: Colors.grey,
                  //                   ))),
                  //           padding: EdgeInsets.symmetric(horizontal: 20),
                  //           height: 40,
                  //           width: 200,
                  //         ),
                  //         dropdownStyleData: const DropdownStyleData(
                  //           maxHeight: 200,
                  //         ),
                  //         menuItemStyleData: const MenuItemStyleData(
                  //           height: 40,
                  //         ),
                  //         dropdownSearchData: DropdownSearchData(
                  //           searchController: serviceProviderController,
                  //           searchInnerWidgetHeight: 50,
                  //           searchInnerWidget: Container(
                  //             height: 50,
                  //             padding: const EdgeInsets.only(
                  //               top: 8,
                  //               bottom: 4,
                  //               right: 8,
                  //               left: 8,
                  //             ),
                  //             child: TextFormField(
                  //               expands: true,
                  //               maxLines: null,
                  //               controller: serviceProviderController,
                  //               decoration: InputDecoration(
                  //                 isDense: true,
                  //                 contentPadding: const EdgeInsets.symmetric(
                  //                   horizontal: 10,
                  //                   vertical: 8,
                  //                 ),
                  //                 hintText: 'Search service provider',
                  //                 hintStyle: const TextStyle(fontSize: 12),
                  //                 border: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //           searchMatchFn: (item, searchValue) {
                  //             return item.value
                  //                 .toString()
                  //                 .contains(searchValue);
                  //           },
                  //         ),
                  //         //This to clear the search value when you close the menu
                  //         onMenuStateChange: (isOpen) {
                  //           if (!isOpen) {
                  //             serviceProvider.clear();
                  //           }
                  //         },
                  //       ),
                  //     ),
                  //   ),
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
                            updateData().whenComplete(() => popupmessage());
                          },
                          child: const Text('Save'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
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
        print(ticketNumberList);
      }
    } catch (e) {
      print("Error getting ticket numbers: $e");
    }
  }

  Future<void> getTicketList() async {
    // final provider = Provider.of<AllRoomProvider>(context, listen: false);
    // provider.setBuilderList([]);
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('raisedTickets').get();
    if (querySnapshot.docs.isNotEmpty) {
      List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();
      ticketList = tempData;
      print(ticketList);
    }
  }

  Future<void> fetchData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('designations').get();
    if (querySnapshot.docs.isNotEmpty) {
      List<String> tempData = querySnapshot.docs.map((e) => e.id).toList();
      serviceProvider = tempData;
      print(serviceProvider);
    }
  }

  Future updateData() async {
    await FirebaseFirestore.instance
        .collection('raisedTickets')
        .doc(selectedTicketNumber)
        .update({
      'serviceProvider': selectedServiceProvider,
    });
  }

  void popupmessage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: AlertDialog(
              content: const Text(
                'Changes saved successfully!!',
                style: TextStyle(fontSize: 14, color: Colors.green),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
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
