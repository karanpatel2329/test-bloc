import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:test_with_bloc/pages/createTest/model/test_model.dart';

import '../../bloc/home_bloc.dart';

class CreateTest extends StatefulWidget {
  const CreateTest({Key? key}) : super(key: key);

  @override
  State<CreateTest> createState() => _CreateTestState();
}

class _CreateTestState extends State<CreateTest> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(GetDataEvent());
    super.initState();
  }

  List<String> selectedItem = [];
  TextEditingController titleController = TextEditingController();
  var box = Hive.box('testBox');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    CupertinoIcons.calendar_today,
                    color: Colors.blue,
                  ),
                  hintText: "Test Name",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.blue, width: 1.5)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.blue, width: 1)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Topics",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.blue,
                    fontSize: 22),
              ),
              SizedBox(
                height: 10,
              ),
              BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                if (state is HomeLoaded) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                          title: Row(
                            children: [
                              !selectedItem.contains(state.topic[index].topicName)
                                  ? GestureDetector(
                                child: Icon(
                                  Icons.check_box_outline_blank_sharp,
                                ),
                                onTap: () {
                                  setState(() {
                                    selectedItem
                                        .add(state.topic[index].topicName);
                                  });
                                },
                              )
                                  : GestureDetector(
                                child: Icon(
                                  Icons.check_box_rounded,
                                  color: Colors.blue,
                                ),
                                onTap: () {
                                  setState(() {
                                    selectedItem.remove(
                                        state.topic[index].topicName);
                                  });
                                },
                              ),
                              SizedBox(width: 10,),
                              Text(state.topic[index].topicName),
                            ],
                          ),
                          children: state.topic[index].concepts
                              .map((e) => Container(

                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 40),

                            child:Row(
                              children: [
                                !selectedItem.contains(e.toString())
                                    ? GestureDetector(
                                  child: const Icon(
                                    Icons.check_box_outline_blank_sharp,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedItem
                                          .add(e.toString());
                                    });
                                  },
                                )
                                    : GestureDetector(
                                  child: const Icon(
                                    Icons.check_box_rounded,
                                    color: Colors.blue,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedItem.remove(
                                          e.toString());
                                    });
                                  },
                                ),
                                SizedBox(width: 10,),
                                SizedBox(child: Text(e.toString(),maxLines: 2,overflow: TextOverflow.ellipsis,),width: MediaQuery.of(context).size.width*0.6,),
                              ],
                            ),
                          ))
                              .toList());
                    },
                    itemCount: state.topic.length,
                    shrinkWrap: true,
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ SizedBox(child:  CircularProgressIndicator(),height: 25,width: 25,)],
                );
              }),
              SizedBox(
                height: 50,
              ),

              InkWell(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
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
                  TestModel testModel = TestModel(title: titleController.text, topic: selectedItem, createAt: DateTime.now());
                  box.add(testModel);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ));
  }
}
