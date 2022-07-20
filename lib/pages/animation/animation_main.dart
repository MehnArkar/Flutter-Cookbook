import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_cookbook/utils/globle_method.dart';
import 'package:get/get.dart';

class MainAnimationPage extends StatefulWidget {
  const MainAnimationPage({Key? key}) : super(key: key);

  @override
  State<MainAnimationPage> createState() => _MainAnimationPageState();
}

class _MainAnimationPageState extends State<MainAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _animation;
  Rx<Alignment> _alignment = Alignment.center.obs;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _controller.addListener(() {
      _alignment.value = _animation.value;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void runAnimation() {
    _animation = _controller
        .drive(AlignmentTween(begin: _alignment.value, end: Alignment.center));
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          topPadding(context),
          Expanded(child: bodyWidget()),
          botPadding(context),
        ],
      ),
    );
  }

  Widget bodyWidget() {
    var size = MediaQuery.of(context).size;
    return Obx(
      () => GestureDetector(
        onPanUpdate: (details) {
          _alignment.value += Alignment(
            details.delta.dx / (size.width / 2),
            details.delta.dy / (size.height / 2),
          );
        },
        onPanEnd: (details) {
          runAnimation();
        },
        onPanDown: (_) {
          _controller.stop();
        },
        child: Container(
            child: Align(
          alignment: _alignment.value,
          child: Card(
            child: SizedBox(
              height: 80,
              width: 80,
              child: Image.asset('assets/images/flutter_dark_icon.png'),
            ),
          ),
        )),
      ),
    );
  }
}
