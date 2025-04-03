
import 'package:eco_return/core/collections/gradients.dart';
import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:eco_return/root/widgets/stat_widgets/stat_tile.dart';
import 'package:flutter/material.dart';

class StatStack extends StatelessWidget {
  const StatStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 20,
      children: [
        // StatTile 1
        StatTile(
          title: "Bottles",
          icon: EcoIcon(path: IconPaths.stroke_bottle, color: Colors.white, size: 45),
          subtitle: "123 bottles recycled",
          gradient: Gradients.ecoGreen,
        ),
        const SizedBox(height: 16),
        // StatTile 2
        StatTile(
          title: "Receievd",
          icon: EcoIcon(path: IconPaths.stroke_smile, color: Colors.white, size: 30),
          subtitle: "\$2000 receieved",
          gradient: Gradients.crimsonRed,
        ),
        const SizedBox(height: 16),
        // StatTile 3
        StatTile(
          title: "Withdrawn",
          icon: EcoIcon(path: IconPaths.stroke_withdraw, color: Colors.white, size: 45),
          subtitle: "\$1450",
          gradient: Gradients.velvetBlue,
        ),
        const SizedBox(height: 16),
        // StatTile 4
        StatTile(
          title: "Pickups",
          icon: EcoIcon(path: IconPaths.stroke_location, color: Colors.white, size: 45),
          subtitle: "23 Pickups",
          gradient: Gradients.amberRed,
        ),
        SizedBox(height: 300,)
      ],
    );
  }
}
