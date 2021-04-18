import 'package:flutter/material.dart';
import 'package:flutter_app/layouts/cubit/cubit.dart';
import 'package:flutter_app/layouts/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomCubit, BottomStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text('Todo'),
          centerTitle: true,
        ),
        body: BottomCubit.get(context)
            .screens[BottomCubit.get(context).currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: BottomCubit.get(context).currentIndex,
          onTap: (int index) {
            BottomCubit.get(context).changeIndex(index);
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded), label: 'Done'),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_right), label: 'Archieved'),
          ],
        ),
      ),
    );
  }
}
