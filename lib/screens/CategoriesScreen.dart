import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/tools/Sharedpreferencesclass.dart';
import '../tools/cubit/cubit.dart';
import '../tools/cubit/status.dart';

class categories_screen extends StatelessWidget {
  const categories_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)  => AppCubit()..GetCategoriesData(),
      child: BlocConsumer<AppCubit,ShopStatus>(
        listener: (context,status){},
        builder:  (context,status){
          AppCubit appCubit = AppCubit.get(context);
          return Scaffold(
            body: !appCubit.categoriesdone?
            Center(child: CircularProgressIndicator()):
            ListView.builder(
              physics: BouncingScrollPhysics(),
                itemCount: appCubit.categoriesModel.data.categoriesdata.length,
                itemBuilder: (context,index){
                  return  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage('${appCubit.categoriesModel.data.categoriesdata[index].image}'),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Text('${appCubit.categoriesModel.data.categoriesdata[index].name.toUpperCase()}'),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}