import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/tools/cubit/cubit.dart';
import 'package:shop_app/tools/cubit/status.dart';
import 'package:shop_app/tools/Sharedpreferencesclass.dart';

class home_screen extends StatelessWidget {
  const home_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)  => AppCubit()..GetHomeData(
            sharedpreferencesshop.getData(key: 'token')
        )..GetCategoriesData(),
        child: BlocConsumer<AppCubit,ShopStatus>(
          listener: (context,status){},
          builder:  (context,status){
            AppCubit appCubit = AppCubit.get(context);
            return Scaffold(
              body: !appCubit.homedone?
              Center(child: CircularProgressIndicator()):
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                   CarouselSlider(
                        items: appCubit.homeModel.data.BannersDataList.map((e) {
                             return Image(
                               image: NetworkImage(e.image),
                             );
                          }).toList(),
                        options: CarouselOptions(
                          height: 200,
                          aspectRatio: 1,
                          viewportFraction: 1,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                        )
                    ),
                    !appCubit.categoriesdone?
                    Center(child: CircularProgressIndicator()):
                    Container(
                      height: 200,
                      child: ListView.builder(
                        itemCount: appCubit.categoriesModel.data.categoriesdata.length,
                       scrollDirection: Axis.horizontal,
                         itemBuilder: (context,index){
                       return  Stack(
                         alignment: Alignment.bottomLeft,
                         children: [
                           Image(
                               image: NetworkImage('${appCubit.categoriesModel.data.categoriesdata[index].image}')
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Container(
                                 padding: EdgeInsets.all(5),
                                 color: Colors.black54,
                                 child: Text('${appCubit.categoriesModel.data.categoriesdata[index].name.toUpperCase()}',style: TextStyle(color: Colors.white),)),
                           ),
                         ],
                       );
                   }),
                    ),
                    Container(
                      color: Colors.grey,
                      child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 1/1.5,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                          physics:NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                        children: List.generate(
                            appCubit.homeModel.data.ProductsDataList.length,
                                (index){
                              return Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: [
                                      Container(
                                        alignment: Alignment.topCenter,
                                        color: Colors.grey,
                                        child: Image.network(
                                          appCubit.homeModel.data.ProductsDataList[index].image,
                                          width: double.infinity,
                                          height: 200,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      if(appCubit.homeModel.data.ProductsDataList[index].discount!=0)
                                      Container(
                                        color: Colors.deepOrange,
                                        child: Text('  Discount  '),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(right: 10,left: 10,top: 2),
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Text(
                                            '${appCubit.homeModel.data.ProductsDataList[index].name}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            children: [
                                              Text(
                                                '${appCubit.homeModel.data.ProductsDataList[index].price}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(color: Colors.lightBlue),
                                              ),
                                              SizedBox(width: 10,),
                                              if(appCubit.homeModel.data.ProductsDataList[index].discount!=0)
                                                Text(
                                                '${appCubit.homeModel.data.ProductsDataList[index].old_price}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                  decoration: TextDecoration.lineThrough
                                                ),
                                              ),
                                              Spacer(),
                                              IconButton(
                                                  onPressed: (){
                                                    appCubit.AddRemoveFavorite(appCubit.homeModel.data.ProductsDataList[index].id, sharedpreferencesshop.getData(key: 'token'),true);
                                                  },
                                                  icon: Icon(
                                                      appCubit.favlist[appCubit.homeModel.data.ProductsDataList[index].id]==true
                                                          ?Icons.favorite:Icons.favorite_border
                                                  ),
                                                color: Colors.deepOrange,
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                                },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
    );
  }
}