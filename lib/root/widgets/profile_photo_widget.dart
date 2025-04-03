import 'dart:io';

import 'package:flutter/material.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/core/base/controllers/photo_handler.dart';

class ProfilePhoto extends StatefulWidget {
  final File? selectedImage;
  final ValueChanged<File?> onImageSelected;

  const ProfilePhoto({
    Key? key,
    required this.selectedImage,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 40),
    );

    _animation = Tween<double>(
      begin: ThemeConstants.screenHeight / 28,
      end: ThemeConstants.screenHeight / 30,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 20), () {
          _controller.reverse();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _resizeIcon() {
    if (_controller.status == AnimationStatus.dismissed) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.selectedImage == null
            ? Image.asset(
                "Assets/illustrations/default_profile.png",
                height: ThemeConstants.screenHeight / 4,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(55),
                child: Image.file(
                  widget.selectedImage!,
                  height: ThemeConstants.screenHeight / 4,
                ),
              ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () async {
              _resizeIcon();
              File? image = await PhotoHandler.pickImage(context);
              widget.onImageSelected(image);
            },
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      widget.selectedImage == null
                          ? BoxShadow(
                              color: const Color.fromARGB(255, 0, 116, 106)
                                  .withOpacity(0.2),
                              blurRadius: 6,
                              spreadRadius: 1,
                              offset: const Offset(0, -0),
                            )
                          : BoxShadow(
                              color: const Color.fromARGB(255, 0, 116, 106)
                                  .withOpacity(0.5),
                              blurRadius: 9,
                              spreadRadius: 2,
                              offset: const Offset(-2, -2),
                            ),
                    ],
                  ),
                  height: _animation.value,
                  child: Image.asset(
                    "Assets/icons/camera.png",
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
