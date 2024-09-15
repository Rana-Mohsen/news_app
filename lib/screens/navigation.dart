import 'package:flutter/material.dart';
import 'package:news_app/screens/favorite_screen.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/profile_screen.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  List<String> icons = [
    'assets/icons/Home.png',
    'assets/icons/Favorite.png',
    'assets/icons/Profile.png'
  ];
  List<String> selectedIcons = [
    'assets/icons/HomeActive.png',
    'assets/icons/FavoriteActive.png',
    'assets/icons/ProfileActive.png'
  ];
  List<String> titles = ['Home', 'Favorite', 'Profile'];
  int selectedIndex = 0;
  List<Widget> pages = const [HomeScreen(), FavoriteScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          pages[selectedIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: _navbar(),
          ),
        ],
      ),
    );
  }

  Widget _navbar() {
    return Container(
      height: 65,
      margin: const EdgeInsets.only(
        right: 24,
        left: 24,
        bottom: 24,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withAlpha(20),
              spreadRadius: 10,
            )
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: icons.map((icon) {
          int index = icons.indexOf(icon);
          bool isSelected = selectedIndex == index;
          return Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  // if (selectedIndex == 2) {
                  //   BlocProvider.of<FavoritCubit>(context).favoritBody();
                  // }
                });
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                        top: 15,
                        bottom: 0,
                        left: 35,
                        right: 35,
                      ),
                      child: Image.asset(
                        isSelected ? selectedIcons[index] : icons[index],
                        gaplessPlayback: true,
                      ),
                    ),
                    Text(
                      titles[index],
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
