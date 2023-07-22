import 'package:flutter/material.dart';
import 'package:shop_app/screens/MainScreen.dart';
import 'package:shop_app/tools/Sharedpreferencesclass.dart';
import 'package:shop_app/tools/default_widget.dart';
import '../Model/LoginModel.dart';
import '../network/dio_helper.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email = TextEditingController();
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool loading = false;
  bool hideText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          'Login to see our offers',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        defaultTextField(
                          textEditingController: email,
                          label: 'Username',
                          prefixicon: const Icon(Icons.person),
                          validation: (value) {
                            if (value!.isEmpty) return 'Title is empty';
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        defaultTextField(
                          onPressedSuffix: (){
                           setState(() {
                             hideText = !hideText;
                           });
                          },
                          hidetext: hideText,
                          suffixicon: hideText ? Icons.visibility_off : Icons.visibility,
                          ispassword: true,
                          textEditingController: password,
                          label: 'Password',
                          prefixicon: const Icon(Icons.password),
                          validation: (value) {
                            if (value!.isEmpty) return 'Password is empty';
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                         SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: loading?
                          const Center(child: CircularProgressIndicator(),):
                          ElevatedButton(
                            onPressed: ()  {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                DioHelper.postData(
                                  url: 'login',
                                  data: {
                                    'email':email.text,
                                    'password':password.text,
                                  },
                                ).then((data){
                                  LoginModel loginModel = LoginModel.fromJason(data.data);
                                 if(loginModel.status){
                                   print(loginModel.status);
                                   print(loginModel.dataUser?.name);
                                   print(loginModel.dataUser?.token);
                                   sharedpreferencesshop.saveData(
                                     key: 'token',
                                     value: loginModel.dataUser?.token,
                                   ).then((value) {
                                     toastFlutter(
                                       '${LoginModel.fromJason(data.data).message}',
                                       bgcolor:Colors.green,
                                     );
                                     goWithOutBack(context: context, widget: const MainScreen());
                                   });
                                 }
                                 else {
                                   setState(() {
                                     loading=false;
                                   });
                                   toastFlutter(
                                     '${LoginModel.fromJason(data.data).message}',
                                     bgcolor: Colors.red,
                                   );
                                 }
                                }).catchError((e){
                                  setState(() {
                                    loading=false;
                                  });
                                  print(e.toString());
                                });
                              }
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(
                             'Don\'t an account?',
                             style: TextStyle(fontSize: 15),
                           ),
                           TextButton(
                             child: Text(
                                 'Register',
                                 style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                             ),
                             onPressed: (){},
                           ),
                         ],
                       ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
