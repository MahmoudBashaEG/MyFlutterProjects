import 'package:flutter/material.dart';
import 'package:flutter_app/layouts/cubit/states.dart';
import 'package:flutter_app/modules%20TO%20DO%20App/dark_mode.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Shared/bloc_observer.dart';
import 'layouts/basic.dart';
import 'layouts/cubit/cubit.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomCubit()..openDb(),
        )
      ],
      child: BlocConsumer<BottomCubit, BottomStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: BottomCubit.get(context).isDark
                ? ThemeData.dark()
                : ThemeData(),
            home: CircularProgressIndicator(
              backgroundColor: Colors.black,
              semanticsLabel: 'hello',
              semanticsValue: 'mahmoud',
            ),
          );
        },
      ),
    );
  }
}
