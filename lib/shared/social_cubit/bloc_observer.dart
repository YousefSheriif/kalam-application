import 'package:bloc/bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}
//
// cupertino_icons: ^1.0.2
// sqflite: ^2.2.7
// hexcolor: ^3.0.1
// intl: ^0.18.1
// bloc: ^8.1.1
// flutter_bloc: ^8.1.2
// conditional_builder_null_safety: ^0.0.6
// dio: ^5.1.1
// shared_preferences: ^2.1.0
// webview_flutter: ^3.0.4



//yousefsherif979@gmail.com   12345666      Na08a1P4S7BMXsh2FLXsga3iqlJdfCJI3mfKSaBfx2FYZWuxqyfqWyMX2fHSinxSb4HeFg
//mohamed.yousef@gmail.com   123456
//abdo.sherif@gmail.com   123456789
