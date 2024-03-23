import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/screens/home_screen.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key, required this.onTabChange}) : super(key: key);

  final Function(int tabIndex) onTabChange;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> with TickerProviderStateMixin {
  final List<IconData> iconsNames = [
    Icons.home_outlined,
    Icons.search_sharp,
    Icons.headphones,
    Icons.podcasts_sharp,
    Icons.favorite_border_rounded,
  ];
  int _selectedTab = 0;
  late AnimationController _positionController;
  late AnimationController _widthController;
  late Animation<double> _positionAnimation;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();
    _positionController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _widthController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);

    double initialPosition = 32;
    _positionAnimation = Tween<double>(begin: initialPosition, end: initialPosition).animate(_positionController)
      ..addListener(() {
        setState(() {});
      });

    _widthAnimation = Tween<double>(begin: 15, end: 15).animate(_widthController)
      ..addListener(() {
        setState(() {});
      });
  }

  void onTabPress(int index) {
    if (_selectedTab != index) {
      setState(() {
        _selectedTab = index;
      });
      widget.onTabChange(index);

      double screenWidth = MediaQuery.of(context).size.width;
      double targetPosition = screenWidth / iconsNames.length * index + 32;
      double startPosition = _positionAnimation.value;
      double startWidth = 15;
      double targetWidth = 40;

      _positionAnimation = Tween<double>(begin: startPosition, end: targetPosition).animate(_positionController)
        ..addListener(() {
          setState(() {});
        });
      _positionController.forward(from: 0);

      _widthAnimation = TweenSequence([
        TweenSequenceItem(tween: Tween<double>(begin: startWidth, end: targetWidth), weight: 50),
        TweenSequenceItem(tween: Tween<double>(begin: targetWidth, end: startWidth), weight: 50),
      ]).animate(_widthController)
        ..addListener(() {
          setState(() {});
        });

      _widthController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF222932),
      child: SafeArea(
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(iconsNames.length, (index) {
                return Expanded(
                  key: ValueKey(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                    child: CupertinoButton(
                      padding: const EdgeInsets.all(12),
                      onPressed: index == 2
                          ? null
                          : () {
                              onTabPress(index);
                            },
                      child: index == 2
                          ? CircleAvatar(
                              radius: 30,
                              backgroundColor: MyColors.secondaryColor,
                              child: const Icon(
                                Icons.headphones,
                                color: Colors.white,
                                size: 24,
                              ),
                            )
                          : Icon(
                              iconsNames[index],
                              color: _selectedTab == index ? Colors.white : Colors.white.withOpacity(0.7),
                              size: _selectedTab == index ? 32 : 26,
                              weight: 1,
                            ),
                    ),
                  ),
                );
              }),
            ),
            _selectedTab != 2
                ? AnimatedBuilder(
                    animation: Listenable.merge([_positionController, _widthController]),
                    builder: (context, child) {
                      return Positioned(
                        bottom: 10,
                        left: _positionAnimation.value,
                        child: Container(
                          height: 4,
                          width: _widthAnimation.value,
                          decoration: BoxDecoration(
                            color: MyColors.secondaryColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
