import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/app_cubit/states.dart';
import 'package:newsapp/network/local/cache_helper.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeAppMode({bool fromShared}){
    if(fromShared != null)
    isDark = fromShared;
    else
      isDark = !isDark;

    CacheHelper.setData(key:'isDark', value: isDark).then((value) {
     emit(AppChangeModeState());
    });
  }
}
