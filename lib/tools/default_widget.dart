import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/screens/MainScreen.dart';

final lightTheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrangeAccent,
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
    ),
    color: Colors.white,
    titleTextStyle: TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
    elevation: 0,
  ),
);

final darkTheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: Colors.white10,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.black,
    ),
    color: Colors.black,
    titleTextStyle: TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white10,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrangeAccent,
    unselectedItemColor: Colors.white,
  ),
);

Widget onBoardingPage({
  required String image,
  required context
}) {
  return Column(
    children: [
      Expanded(
        flex: 3,
        child: Image.asset(image),
      ),
      Expanded(
        flex: 1,
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Shop Only',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                SizedBox(height: 15),
                Text('On Boarding Body'),
              ],
          ),
        ),
      ),
    ],
  );
}

void goWithOutBack({
  required BuildContext context,
  required Widget widget,
}) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}

Widget defaultTextField({
  TextEditingController? textEditingController,
  String? Function(String?)? validation,
  String? label,
  Icon? prefixicon,
  IconData? suffixicon,
  void Function()? onPressedSuffix,
  bool readonly = false,
  bool hidetext = false,
  bool ispassword = false,
  void Function()? ontap,
})
{
  return TextFormField(
    controller: textEditingController,
    validator: validation,
    readOnly: readonly,
    onTap: ontap,
    obscureText: hidetext,
    decoration: InputDecoration(
      suffixIcon: ispassword?IconButton(
        onPressed: onPressedSuffix,
        icon: Icon(suffixicon),
      ):null ,
      labelText: label,
      prefixIcon: prefixicon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
      ),
    ),
  );
}

void toastFlutter(
String msg,{
      Color? bgcolor,
      Color? txcolor,
      double? txsize,
}){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: bgcolor,
      textColor: txcolor,
      fontSize: txsize
  );
}


class HomeSearch extends SearchDelegate<String>{
  List<String> l = [
    'omar',
    'said',
    'ali',
    'kamel',
    'ahmed',
    'samy',
    'walid',
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            goWithOutBack(context: context, widget: MainScreen());
          } else {
            query = '';
          }
        },
        icon: Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return  IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        goWithOutBack(context: context, widget: MainScreen());
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> s  = l.where((element)  {
      final a = element.toLowerCase();
      final b = query.toLowerCase();
      return a.contains(b);
    }).toList();
    return ListView.builder(
      itemBuilder: (context,index){
        return ListTile(
          title: Text(s[index]),
          onTap: (){
            query = s[index];
            print(query);
          },
        );
      },
      itemCount: s.length,
    );
  }
}