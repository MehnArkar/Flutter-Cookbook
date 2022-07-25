import 'package:flutter/material.dart';

import 'package:flutter_cookbook/utils/globle_method.dart';
import 'package:get/get.dart';

class AnimateContainerPage extends StatefulWidget {
  const AnimateContainerPage({Key? key}) : super(key: key);

  @override
  State<AnimateContainerPage> createState() => _AnimateContainerPageState();
}

class _AnimateContainerPageState extends State<AnimateContainerPage> {
  Rx<bool> isClicked = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          topPadding(context),
          Expanded(child: bodyWidget()),
          botPadding(context)
        ],
      ),
    );
  }

  Widget bodyWidget() {
    return Center(
        child: GestureDetector(
      onTap: () {
        isClicked.value = !isClicked.value;
      },
      child: Obx(
        () => AnimatedContainer(
          duration: const Duration(
            milliseconds: 300,
          ),
          width: isClicked.value ? 100 : 50,
          height: 50,
          decoration: BoxDecoration(
              color: isClicked.value ? Colors.transparent : Colors.black,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.black, width: 2)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: isClicked.value ? 0 : 1,
                  child: const Icon(
                    Icons.person_add,
                    color: Colors.white,
                  )),
              AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: isClicked.value ? 1 : 0,
                  child: const Text(
                    'Message',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
