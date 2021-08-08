import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/states.dart';
import 'package:newsapp/modules/business/business_screen.dart';
import 'package:newsapp/modules/science/science_screen.dart';
//import 'package:newsapp/modules/settings/settings_screen.dart';
import 'package:newsapp/modules/sports/sports_screen.dart';
import 'package:newsapp/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: "Business"),
    BottomNavigationBarItem(icon: Icon(Icons.sports_baseball_rounded), label: "Sports"),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),

  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavItem(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: "v2/top-headlines",
      query:{
        'country' : 'eg',
        'category':'business',
        'apikey':'ceb6fe47ba9343d2a30b35d3252634a1',
      },
    ).then((value) {
     business = value.data['articles'];
     emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      emit(NewsGetBusinessErrorState(error.toString()));
      print(error.toString());
    });
  }

  List<dynamic> sports = [];
  void getSport(){
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      url: "v2/top-headlines",
      query:{
        'country' : 'eg',
        'category':'sports',
        'apikey':'ceb6fe47ba9343d2a30b35d3252634a1',
      },
    ).then((value) {
      sports = value.data['articles'];
      emit(NewsGetSportsSuccessState());
    }).catchError((error){
      emit(NewsGetSportsErrorState(error.toString()));
      print(error.toString());
    });
  }


  List<dynamic> science = [];
  void getScience(){
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
      url: "v2/top-headlines",
      query:{
        'country' : 'eg',
        'category':'science',
        'apikey':'ceb6fe47ba9343d2a30b35d3252634a1',
      },
    ).then((value) {
      science = value.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      emit(NewsGetScienceErrorState(error.toString()));
      print(error.toString());
    });
  }


  List<dynamic> search = [];
  void getSearch(String value){
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: "v2/everything",
      query:{
        'q':'$value',
        'apikey':'ceb6fe47ba9343d2a30b35d3252634a1',
      },
    ).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      emit(NewsGetSearchErrorState(error.toString()));
      print(error.toString());
    });
  }
}
