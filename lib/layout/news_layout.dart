import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/app_cubit/cubit.dart';
import 'package:newsapp/layout/cubit/cubit.dart';
import 'package:newsapp/layout/cubit/states.dart';
import 'package:newsapp/modules/search/search_screen.dart';
//import 'package:newsapp/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text("News App"),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_){
                     return SearchScreen();
                  }));
                },
              ),
              IconButton(
                icon: Icon(Icons.brightness_4_outlined),
                onPressed: () {
                  AppCubit.get(context).changeAppMode();
                },
              ),
            ],
          ),
          body: NewsCubit.get(context)
              .screens[NewsCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: NewsCubit.get(context).currentIndex,
            onTap: (index) =>
                NewsCubit.get(context).changeBottomNavItem(index),
            items: NewsCubit.get(context).bottomItems,
          ),
        );
      },
    );
  }
}
