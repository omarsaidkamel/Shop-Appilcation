import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/tools/cubit/cubit.dart';
import 'package:shop_app/tools/cubit/status.dart';
import 'package:shop_app/tools/default_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (context)=> AppCubit(),
        child: BlocConsumer<AppCubit,ShopStatus>(
          listener: (context, states){},
          builder:  (context, states){
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text('Salla'),
                actions: [
                  IconButton(
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: HomeSearch(),
                      );
                    },
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
              body: cubit.Screens[cubit.currentnavbar],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentnavbar,
                onTap: (x){
                  cubit.ChangeNavScreen(x);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.category),
                    label: 'Categories',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorite',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                  ),
                ],
              ),
            );
          },
        ),
    );
  }
}

/*ElevatedButton(
        onPressed: () {
          sharedpreferencesshop.removeData(key: 'token');
          goWithOutBack(context: context, widget: LoginScreen());
        },
        child: Text('sign out'),
      ),
*/
