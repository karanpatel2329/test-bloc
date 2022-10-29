import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:test_with_bloc/pages/createTest/model/test_model.dart';

import '../createTest/createTest.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Mock Test App",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 250,
                child: Image(
                  image: AssetImage('assets/study.png'),
                ),
              ),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Center(
                    child: Text(
                      "Create New Test",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateTest()));
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 3,
                color: Colors.blue,
              ),
              ValueListenableBuilder(
                  valueListenable: Hive.box('testBox').listenable(),
                  builder: (context, Box box, _) {
                    if (box.values.isEmpty) {
                      return const Text('No Test added.');
                    } else {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          var data = box.values.toList();
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                            margin:
                            const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius:
                                const BorderRadius.all(const Radius.circular(15))),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    (data[index] as TestModel).title,
                                    style: const TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "Created on ${DateFormat().format(
                                          (data[index] as TestModel).createAt,
                                        )}",
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black54),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: box.values.length,
                        shrinkWrap: true,
                      );
                    }
                  })
            ],
          ),
        ));
  }
}
