import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layouts/cubit/cubit.dart';

import '../Consts.dart';

//default Input with label
Widget defaultTextFormField({
  @required String label,
  @required TextEditingController controller,
  Function onChange,
  Function onTap,
  TextInputType keyboardType,
  @required IconData prefixIcon,
  IconData suffix,
  bool isPassword = false,
  Function validate,
}) =>
    TextFormField(
      onTap: onTap,
      onChanged: onChange,
      validator: validate,
      obscureText: isPassword,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffix != null ? Icon(suffix) : null,
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
// this for default button
Widget defaultButton({
  @required String text,
  Function press,
  Color color = Colors.teal,
  EdgeInsetsGeometry padding,
}) =>
    MaterialButton(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 30,
        ),
      ),
      onPressed: press,
      color: color,
      padding: padding,
    );

// this is for space with SizeBox
Widget spaceSizeBox({double height, double width}) => SizedBox(
      width: width,
      height: height,
    );

// I used this with ListVIew widget to create any time of this function with changed type of data with the help of List type
Widget contact(data) => Padding(
      padding: EdgeInsets.only(
        top: 15,
        left: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            child: Text(
              data.code,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          spaceSizeBox(width: 25),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  data.number,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );

// Navigator push
/*this context in parameters is the context of the screen which i will leave it and the context of the builder flutter gives me it and it refer to the next screen*/
dynamic navigatorTo({@required BuildContext context, @required Widget goTo}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => goTo));

// Navigator pop
/*this context in parameters is the context of the screen which i will leave back from it*/
dynamic navigatorBack({@required BuildContext context}) =>
    Navigator.pop(context);

// BMI calculator Component
Widget gender({
  String text,
  IconData icon,
  Color color = Colors.grey,
  Function press,
}) =>
    Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: press,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 70,
              ),
              Text(
                text.toUpperCase(),
                style: black25,
              ),
            ],
          ),
        ),
      ),
    );

// BMI calculator component
Widget personInformation({
  double value,
  Function plus,
  Function minus,
  String text,
}) =>
    Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                text.toUpperCase(),
                style: black25,
              ),
              Text(
                '$value',
                style: black35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: plus,
                    child: Icon(Icons.add),
                  ),
                  spaceSizeBox(width: 10),
                  FloatingActionButton(
                    onPressed: minus,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ],
          )),
    );

// Item Of todoApp
Widget taskItem(Map item, context) => Dismissible(
      onDismissed: (direction) {
        BottomCubit.get(context).deleteDb(item['id']);
      },
      key: Key('${item['id']}'),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.green,
              child: Text(
                '${item['state']}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            spaceSizeBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item['title'],
                    style: black25,
                  ),
                  spaceSizeBox(height: 5),
                  Text(
                    item['date'],
                    style: black25,
                  )
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.assignment_turned_in_rounded),
              color: Colors.lightGreen,
              onPressed: () {
                BottomCubit.get(context)
                    .updateDb(state: 'done', id: item['id']);
              },
            ),
            IconButton(
              icon: Icon(Icons.archive_outlined),
              color: Colors.grey,
              onPressed: () {
                BottomCubit.get(context)
                    .updateDb(state: 'archieved', id: item['id']);
              },
            )
          ],
        ),
      ),
    );

//Item of todoApp
Widget itemBuilder(List list, context) => ConditionalBuilder(
      condition: list != null,
      builder: (context) => ConditionalBuilder(
        condition: list.length > 0,
        builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => taskItem(list[index], context),
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[600],
            ),
          ),
          itemCount: list.length,
        ),
        fallback: (context) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.add_box_sharp,
                size: 100,
              ),
              Text(
                'No Tasks Here',
                style: TextStyle(fontSize: 30, color: Colors.grey),
              )
            ],
          ),
        ),
      ),
      fallback: (context) => Center(child: CircularProgressIndicator()),
    );
