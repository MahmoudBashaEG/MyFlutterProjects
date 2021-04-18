import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Shared/Components/Components.dart';
import 'package:flutter_app/Shared/Consts.dart';
import 'package:flutter_app/layouts/cubit/cubit.dart';
import 'package:flutter_app/layouts/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatelessWidget {
  TextEditingController title = TextEditingController();
  TextEditingController tarih = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomCubit, BottomStates>(
      listener: (context, state) {
        if (state is BottomInsertDataSuccessState) {
          navigatorBack(context: context);
        }
      },
      builder: (context, state) {
        List list = BottomCubit.get(context).newTasks;
        return Scaffold(
          body: itemBuilder(list, context),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showBottom(context);
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }

  void showBottom(
    BuildContext context,
  ) {
    showBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                defaultTextFormField(
                  controller: title,
                  label: 'title',
                  onTap: () {},
                  prefixIcon: Icons.ac_unit_rounded,
                  onChange: (value) {},
                ),
                spaceSizeBox(height: 20),
                defaultTextFormField(
                  controller: tarih,
                  label: 'date',
                  onTap: () {},
                  prefixIcon: Icons.ac_unit_rounded,
                  onChange: (value) {},
                ),
                spaceSizeBox(height: 20),
                Container(
                  width: double.infinity,
                  child: defaultButton(
                      text: 'ADD',
                      color: Colors.teal,
                      press: () {
                        if (title.text.isEmpty || tarih.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Please Insert Data",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.amber,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          return;
                        }
                        BottomCubit.get(context).insertDb(
                          title: title.text,
                          date: tarih.text,
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
