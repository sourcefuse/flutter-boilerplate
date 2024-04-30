import 'package:flutter/material.dart';
import 'package:clean_arch/presenter/ui/add_note/add_note_page.dart';
import 'package:clean_arch/utils/navigator.dart';

/// The AddButton class is a StatefulWidget in Dart that represents a button for adding items.
class AddButton extends StatefulWidget {
  const AddButton({Key? key}) : super(key: key);

  @override
  State<AddButton> createState() => _AddButtonState();
}

/// The `_AddButtonState` class in Dart defines a stateful widget with an animated IconButton that
/// scales when pressed and navigates to the `AddNotePage` after a delay.
class _AddButtonState extends State<AddButton>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    const quick = Duration(milliseconds: 150);
    final scaleTween = Tween(begin: 0.8, end: 1.0);
    controller = AnimationController(duration: quick, vsync: this);
    animation = scaleTween.animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    )..addListener(() {
      setState(() => scale = animation.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _animate() {
    animation.addStatusListener((AnimationStatus status) {
      if (scale == 1.0) {
        controller.reverse();
      }
    });
    controller.forward();
  }

  double scale = 0.8;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: IconButton(
        onPressed: () {
          _animate();
          Future.delayed(
            const Duration(milliseconds: 300),
                () => NavigatorUtil.get(
              context,
              const AddNotePage(),
            ),
          );
        },
        icon: const Icon(Icons.add, size: 40.0),
      ),
    );
  }
}
