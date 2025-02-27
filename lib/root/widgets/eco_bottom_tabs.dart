import 'package:flutter/material.dart';
import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';

class EcoBottomTabs extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const EcoBottomTabs({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 14,
      right: 14,
      bottom: 10,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 145, 145, 145).withOpacity(0.6),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(2),
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: onTap,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: ThemeConstants.ecoGreen,
              unselectedItemColor: ThemeConstants.ecoGrey,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: <BottomNavigationBarItem>[
                _buildNavItem(
                  IconPaths.stroke_home,
                  25,
                  currentIndex == 0,
                ),
                _buildNavItem(
                  IconPaths.stroke_bottle,
                  28,
                  currentIndex == 1,
                ),
                _buildNavItem(
                  IconPaths.stroke_transactions,
                  20,
                  currentIndex == 2,
                ),
                _buildNavItem(
                  IconPaths.stroke_smile,
                  20,
                  currentIndex == 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String path, double size, bool isSelected) {
    return BottomNavigationBarItem(
      icon: EcoIcon(
        path: path,
        size: size,
        color: isSelected ? ThemeConstants.ecoGreen : ThemeConstants.ecoGrey,
      ),
      label: '',
    );
  }
}
