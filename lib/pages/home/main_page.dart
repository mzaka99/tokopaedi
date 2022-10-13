import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/pages/home/chat_page.dart';
import 'package:tokopaedi/pages/home/favorite_page.dart';
import 'package:tokopaedi/pages/home/home_page.dart';
import 'package:tokopaedi/pages/home/profile_page.dart';
import 'package:tokopaedi/providers/category_product_provider.dart';
import 'package:tokopaedi/providers/product_provider.dart';
import 'package:tokopaedi/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<CategoryProductProvider>(context, listen: false).isLoading =
        true;
    Provider.of<ProductProvider>(context, listen: false).isLoading = true;
    Provider.of<CategoryProductProvider>(context, listen: false)
        .fetchDataCategoryProduct()
        .then(
          (_) => Provider.of<ProductProvider>(context, listen: false)
              .fetchDataProduct(),
        );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as int?;
    if (args != null) {
      setState(() {
        currentIndex = args;
      });
    }
  }

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget cardButton() {
      return FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/cart');
        },
        backgroundColor: secondaryColor,
        child: Image.asset(
          'assets/icon/cart_icon.png',
          width: 20,
        ),
      );
    }

    Widget customBottomNav() {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: bgColor4,
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Image.asset(
                    'assets/icon/home_icon.png',
                    width: 21,
                    color: currentIndex == 0
                        ? primaryColor
                        : const Color(0xff808191),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Image.asset(
                    'assets/icon/chat_icon.png',
                    width: 20,
                    color: currentIndex == 1
                        ? primaryColor
                        : const Color(0xff808191),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Image.asset(
                    'assets/icon/fav_icon.png',
                    width: 20,
                    color: currentIndex == 2
                        ? primaryColor
                        : const Color(0xff808191),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Image.asset(
                    'assets/icon/profile.png',
                    width: 18,
                    color: currentIndex == 3
                        ? primaryColor
                        : const Color(0xff808191),
                  ),
                ),
                label: '',
              ),
            ],
          ),
        ),
      );
    }

    Widget? body() {
      switch (currentIndex) {
        case 0:
          return const HomePage();
        case 1:
          return const ChatPage();
        case 2:
          return FavoritePage(
            changeIndexFn: changeIndex,
          );
        case 3:
          return const ProfilePage();
      }
      return null;
    }

    return Scaffold(
      backgroundColor: currentIndex == 0 ? bgColor1 : bgColor3,
      body: body(),
      bottomNavigationBar: customBottomNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: cardButton(),
    );
  }
}
