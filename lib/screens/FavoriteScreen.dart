import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../tools/cubit/cubit.dart';
import '../tools/cubit/status.dart';
import 'package:shop_app/tools/Sharedpreferencesclass.dart';

class favorite_screen extends StatelessWidget {
  const favorite_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)  => AppCubit()..GetFavoriteData(
          sharedpreferencesshop.getData(key: 'token')),
      child: BlocConsumer<AppCubit,ShopStatus>(
        listener: (context,status){},
        builder:  (context,status){
          AppCubit appCubit = AppCubit.get(context);
          return Scaffold(
            body: !appCubit.favoritedone?
            Center(child: CircularProgressIndicator()):
            appCubit.favoriteModel.data.ProductsDataList.length==0
                ?Center(
              child: Text('Your Favorite is Empty!',
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 20,
              )),
            ):ListView.separated(
              separatorBuilder: (context,index){
                return SizedBox(height: 5,);
              },
                physics: BouncingScrollPhysics(),
                itemCount: appCubit.favoriteModel.data.ProductsDataList.length,
                itemBuilder: (context,index){
                  return  Container(
                    padding: EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    height:  MediaQuery.of(context).size.height*0.18,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Image(
                            image: NetworkImage('${appCubit.favoriteModel.data.ProductsDataList[index].image}'),
                            width: 100,
                            height: 100,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width*0.48,
                              child: Text(
                                '${appCubit.favoriteModel.data.ProductsDataList[index].name.toUpperCase()}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                width: MediaQuery.of(context).size.width*0.48,
                                child: Text(
                                  '${appCubit.favoriteModel.data.ProductsDataList[index].description}',
                                  style: TextStyle(
                                    color: Colors.deepOrange
                                  ),
                                  //overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${appCubit.favoriteModel.data.ProductsDataList[index].price}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.lightBlue),
                                ),
                                if(appCubit.favoriteModel.data.ProductsDataList[index].discount!=0)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      '${appCubit.favoriteModel.data.ProductsDataList[index].old_price}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          decoration: TextDecoration.lineThrough
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: (){
                            appCubit.AddRemoveFavorite(appCubit.favoriteModel.data.ProductsDataList[index].id, sharedpreferencesshop.getData(key: 'token'),false);
                          },
                          icon: Icon(Icons.favorite),
                          color: Colors.deepOrange,
                        ),
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