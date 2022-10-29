import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:test_with_bloc/pages/home/model/topic.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if(event is GetDataEvent){
        print("GetDataEvent");
        Dio dio = Dio();
       var res =await dio.get('https://utkwwq6r95.execute-api.us-east-1.amazonaws.com/assignment/topics',options: Options(
         headers: {
           'userid':'25794905-2dd4-40bd-97b9-9d5d69294b86',
           'token':'d61036c6-5ffd-4964-b7ff-8d5ba8ca0262'
         }
       ));
       List<Topic> topic = [];
       for(var i in res.data){
          topic.add(Topic(topicName: i['topicName'], concepts: i['concepts']));
       }
       emit(HomeLoaded(topic: topic));
      }
    });
  }
}
