import 'package:flutter/material.dart';

class assign extends StatefulWidget {
  const assign({Key? key}) : super(key: key);

  @override
  State<assign> createState() => _assignState();
}

class _assignState extends State<assign> {
  String? selectedRole1;
  String? selectedRole2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            height: 500,
            width: 700,
            color: Colors.purpleAccent,
            child: Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 224, 141, 239),
                          child: Icon(
                            Icons.star_border_purple500,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'Assign Role',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                      width: 150,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: DropdownButton<String>(
                        value: selectedRole1,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedRole1 = newValue;
                          });
                        },
                        isExpanded: true,
                        items: <String>['Role 1', 'Role 2', 'Role 3', 'Role 4']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem(
                              value: value, child: Text(value));
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                      width: 150,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: DropdownButton<String>(
                        value: selectedRole2,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedRole2 = newValue;
                          });
                        },
                        isExpanded: true,
                        items: ['Role A', 'Role B', 'Role C', 'Role D']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem(
                              value: value, child: Text(value));
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: Text('Assign Role')),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'))
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
