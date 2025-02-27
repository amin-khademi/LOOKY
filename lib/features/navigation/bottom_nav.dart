import 'package:flutter/material.dart';
import 'package:new_horizen_test_app/core/theme/theme.dart';
import 'package:new_horizen_test_app/core/widgets/widgets.dart';
import 'package:new_horizen_test_app/features/barber/presentation/pages/barbers_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const BarbersPage(),
    const Scaffold(body: Center(child: Text('Bookmarks Page'))),
    const Scaffold(body: Center(child: Text('Location Page'))),
    const Scaffold(body: Center(child: Text('Profile Page'))),
  ];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.color1,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
            splashFactory: InkRipple.splashFactory,
            splashColor: Colors.grey.withOpacity(0.3),
            highlightColor: Colors.transparent,
            // This is where we customize the splash shape
            colorScheme: Theme.of(context)
                .colorScheme
                .copyWith(surfaceContainerHighest: Colors.transparent)),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: List.generate(
              _pages.length, (i) => _buildBottomNavigationBarItem(i)),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(int index) {
    final icons = [
      AppIcons.icHome,
      AppIcons.icBookmark,
      AppIcons.icLoc,
      AppIcons.icUser
    ];

    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          image(
            icons[index],
            size: 25,
            color:
                _selectedIndex == index ? AppColors.color2 : AppColors.color3,
          ),
          if (_selectedIndex == index)
            Container(
              margin: const EdgeInsets.only(top: 5),
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.color2,
              ),
            ),
        ],
      ),
      label: '',
    );
  }
}
