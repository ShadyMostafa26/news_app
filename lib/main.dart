import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/layout/app_cubit/cubit.dart';
import 'package:newsapp/layout/app_cubit/states.dart';
import 'package:newsapp/layout/cubit/cubit.dart';
import 'package:newsapp/layout/news_layout.dart';
import 'package:newsapp/network/local/cache_helper.dart';
import 'package:newsapp/network/remote/dio_helper.dart';
import 'package:newsapp/shared/helpers/helpers.dart';

// base url: https://newsapi.org/
// url: v2/top-headlines?
// queries: country=eg&category=business&apiKey=ceb6fe47ba9343d2a30b35d3252634a1

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

bool isDark = CacheHelper.getData(key: 'isDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
   MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    //print(isDark);
    return MultiBlocProvider(
      providers: [
       BlocProvider(create: (context) => NewsCubit()..getBusiness()..getSport()..getScience(),),
       BlocProvider( create: (context) => AppCubit()..changeAppMode(fromShared: isDark)),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return  MaterialApp(
            color: Colors.white,
            title: 'News APP',
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              textTheme: TextTheme(
                headline6: TextStyle(
                  color: Colors.black,
                ),
                bodyText1: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              appBarTheme: AppBarTheme(
                titleSpacing: 20,
                backgroundColor: Colors.white,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                actionsIconTheme: IconThemeData(
                  color: Colors.black87,
                  size: 50.0,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
                textTheme: TextTheme(
                  headline6: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Colors.deepOrange,
                elevation: 5.0,
                unselectedItemColor: Colors.grey,
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              textTheme: TextTheme(
                headline6: TextStyle(
                  color: Colors.white,
                ),
                bodyText1: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                backgroundColor: HexColor('333739'),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
                actionsIconTheme: IconThemeData(
                  color: Colors.white,
                  size: 50.0,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
                textTheme: TextTheme(
                  headline6: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Colors.deepOrange,
                elevation: 5.0,
                unselectedItemColor: Colors.grey,
                backgroundColor: HexColor('333739'),
              ),
              scaffoldBackgroundColor: HexColor('333739'),
            ),
            themeMode: AppCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: Directionality(
              textDirection: TextDirection.ltr,
              child: NewsLayout(),
            ),
          );
        },
      ),
    );
  }
}
