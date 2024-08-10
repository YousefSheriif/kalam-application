import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/app_mode_cubit/mode_states.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';


  class ModeCubit  extends Cubit<ModeStates>
{

  ModeCubit():super(AppInitialModeState());

  static ModeCubit get(context) => BlocProvider.of(context);

  bool isDark = false ;
  void changeAppMode({bool? fromShared})
  {
    if (fromShared != null )
    {
      isDark = fromShared;
    }
    else
    {
      isDark= !isDark;

    }
    CacheHelper.saveData(key: 'isDark', value: isDark).then((value)
    {
      emit(ChangeAppModeState());
    });
  }



}
