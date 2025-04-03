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
    double screenWidth = ThemeConstants.screenWidth;
    double containerHeight = screenWidth * 0.165; // 15% of screen width
    double iconSize = screenWidth * 0.06; // 6% of screen width

    return Positioned(
      // left: 14,
      // right: 14,
      // bottom: 10,
      // child: Container(
      //   width: ThemeConstants.screenHeight - 28, // Account for padding
      //   height: containerHeight, // Set dynamic height
      left: 0,
      right: 0,
      bottom: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Container(
          width: ThemeConstants.screenHeight - 28, // Account for padding
          height: containerHeight, // Set dynamic height
          padding: EdgeInsets.only(bottom: 0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 145, 145, 145).withOpacity(0.6),
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
              padding: const EdgeInsets.only(top: 3),
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
                    iconSize,
                    currentIndex == 0,
                  ),
                  _buildNavItem(
                    IconPaths.stroke_bottle,
                    iconSize * 1.12, // Slightly larger icon for bottle
                    currentIndex == 1,
                  ),
                  _buildNavItem(
                    IconPaths.stroke_transactions,
                    iconSize * 0.8, // Slightly smaller icon for transactions
                    currentIndex == 2,
                  ),
                  _buildNavItem(
                    IconPaths.stroke_smile,
                    iconSize * 0.8, // Slightly smaller icon for smile
                    currentIndex == 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      String path, double size, bool isSelected) {
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
