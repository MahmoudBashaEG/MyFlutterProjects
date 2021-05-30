//default Input with label
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/Shared/styles/colors.dart';
import '../styles/Consts.dart';

Widget defaultTextField({
  @required String label,
  @required TextEditingController controller,
  Function onChange,
  Function onTap,
  Function onSubmit,
  TextInputType keyboardType,
  @required IconData prefixIcon,
  IconData suffixIcon,
}) =>
    TextField(
      onTap: onTap,
      onChanged: onChange,
      keyboardType: keyboardType,
      controller: controller,
      onSubmitted: onSubmit,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        labelText: label,
        border: OutlineInputBorder(),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
      ),
    );

Widget defaultTextFormField({
  @required String label,
  @required TextEditingController controller,
  Function onChange,
  Function onTap,
  TextInputType keyboardType,
  @required IconData prefixIcon,
  IconData suffix,
  bool isPassword = false,
  @required String validate,
  Function suffixIconOnPress,
}) =>
    TextFormField(
      onTap: onTap,
      onChanged: onChange,
      obscureText: isPassword,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixIconOnPress,
              )
            : null,
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: (String value) {
        if (value.isEmpty) return validate;
        return null;
      },
    );
// this for default button
Widget defaultButton({
  @required String text,
  @required Function press,
  Color color = Colors.blue,
  double padding = 4,
  double fontSize = 25,
  bool isFullWidth = true,
  double width,
}) =>
    Container(
      width: isFullWidth ? double.infinity : width,
      child: MaterialButton(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
          ),
        ),
        onPressed: press,
        color: color,
        padding: EdgeInsets.symmetric(vertical: padding),
      ),
    );

Widget defaultButtonWithRadius({
  @required String text,
  @required Function press,
  double width,
  bool isFullWidth = true,
  Color backgroundColor = Colors.red,
  Color textColor = Colors.white,
  TextAlign textAlign = TextAlign.center,
  double paddingVertical = 10,
  double shadowBlur = 10,
  double shadowSpread = 1,
}) {
  return InkWell(
    onTap: press,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: paddingVertical),
      width: isFullWidth ? double.infinity : width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(20),
          left: Radius.circular(20),
        ),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(.3),
            spreadRadius: shadowSpread,
            blurRadius: shadowBlur,
          ),
        ],
      ),
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          color: textColor,
        ),
      ),
    ),
  );
}

// this is for space with SizeBox
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
          SizedBox(width: 25),
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

dynamic navigatorToAndReplace({
  @required BuildContext context,
  @required Widget goTo,
}) =>
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => goTo));

// Navigator pop
/*this context in parameters is the context of the screen which i will leave back from it*/
dynamic navigatorBack({@required BuildContext context}) =>
    Navigator.pop(context);

//Message flutter toast
dynamic message({
  @required String message,
  Color messageColor = Colors.white,
  @required MessageType state,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: messageState(state),
      textColor: messageColor,
      fontSize: 16.0);
}

enum MessageType { Error, Succeed, Warning }
Color messageState(MessageType type) {
  if (type == MessageType.Succeed)
    return Colors.green;
  else if (type == MessageType.Warning)
    return Colors.amber;
  else
    return Colors.red;
}

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
                  SizedBox(width: 10),
                  FloatingActionButton(
                    onPressed: minus,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ],
          )),
    );

Widget buildNewsItem(Map item) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 100,
        child: Row(
          children: [
            Container(
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                      '${item['urlToImage']}',
                    ),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item['title']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                    maxLines: 3,
                  ),
                  Spacer(),
                  Text('${item['publishedAt']}'),
                ],
              ),
            )
          ],
        ),
      ),
    );

Widget newsBuilder(List list) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildNewsItem(list[index]),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.infinity,
            color: Colors.grey,
            height: 1,
          ),
        ),
        itemCount: list.length,
      ),
      fallback: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

Widget newsSearchBuilder(List list) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildNewsItem(list[index]),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.infinity,
            color: Colors.grey,
            height: 1,
          ),
        ),
        itemCount: list.length,
      ),
      fallback: (context) => Center(
        child: Center(
            child: Text(
          'There Aren\'t Any Seraches',
          style: TextStyle(
            fontSize: 30,
          ),
        )),
      ),
    );

//------------------------------------------------------------------------------------------------------------------------------
// Shop App Build categoryItem
Widget categoryItem(Map<String, dynamic> item) {
  return InkWell(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      child: Container(
        height: 90,
        child: Row(
          children: [
            Image(
              image: NetworkImage(item['image']),
              width: 100,
              height: 120,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                item['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
            ),
            IconButton(
                icon: FaIcon(FontAwesomeIcons.arrowRight), onPressed: () {})
          ],
        ),
      ),
    ),
  );
}

// Shop app Category build item in home
Widget categoryHome(item) => Container(
      width: 110,
      child: Stack(
        alignment: Alignment.bottomCenter,
        fit: StackFit.loose,
        children: [
          Container(
            height: 90,
            child: Image(image: NetworkImage(item['image'])),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 3),
            width: double.infinity,
            height: 25,
            color: Colors.grey,
            child: Center(
              child: Text(
                item['name'],
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
//ShopApp  favorite build item
Widget favoriteProductItemBuilder(dynamic product, context) => Container(
      height: 130,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  height: 120,
                  width: 120,
                  image: NetworkImage(product.image),
                ),
                if (product.discount != 0)
                  Container(
                    color: Colors.redAccent,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'Discount ${product.discount} %',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
              ],
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${product.name}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${product.price}',
                          style: TextStyle(color: defaultColor),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (product.oldPrice != null)
                          Text(
                            '${product.oldPrice}',
                            style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                          icon: CircleAvatar(
                            child: FaIcon(
                              FontAwesomeIcons.heart,
                              color: Colors.white,
                              size: 17,
                            ),
                            backgroundColor: defaultColor,
                            radius: 25,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
//ShopApp  search build item

Widget searchItemBuilder(dynamic model, context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 110,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              height: 120,
              width: 100,
              image: NetworkImage(model.image),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Spacer(),
                      IconButton(
                        icon: CircleAvatar(
                          child: FaIcon(
                            FontAwesomeIcons.heart,
                            size: 18,
                            color: Colors.white,
                          ),
                          radius: 25,
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {},
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
