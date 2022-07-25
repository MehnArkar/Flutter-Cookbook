import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_cookbook/pages/animate_container/animateContainer_page.dart';
import 'package:flutter_cookbook/pages/animation/animation_main.dart';
import 'package:flutter_cookbook/utils/app_constant.dart';
import 'package:flutter_cookbook/utils/globle_method.dart';
import 'package:flutter_cookbook/utils/globle_variable.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        topPadding(context),
        homePageAppBar(),
        Expanded(child: bodyWidget()),
        botPadding(context),
      ],
    ));
  }

  Widget homePageAppBar() {
    return Container(
      color: AppConstant.primaryColor,
      padding: const EdgeInsets.all(16),
      width: double.maxFinite,
      child: const Text(
        'Flutter\nCookbook',
        style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppConstant.secondaryColor),
      ),
    );
  }

  Widget eachItem(String title, Widget to) {
    return InkWell(
      onTap: () {
        Get.to(to, transition: Transition.native, curve: Curves.fastOutSlowIn);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: AppConstant.primaryColor,
        shadowColor: AppConstant.secondaryColor,
        elevation: 3,
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                height: screenWidth * 0.25,
                width: screenWidth * 0.25,
                child: const Image(
                  image: AssetImage('assets/images/flutter_dark_icon.png'),
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        )),
      ),
    );
  }

  Widget bodyWidget() {
    return GridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1,
      crossAxisCount: 2,
      children: [
        eachItem('Dragable Card', const MainAnimationPage()),
        eachItem('Animate\nContainer', const AnimateContainerPage()),
        eachItem('Animation', const MainAnimationPage()),
        eachItem('Animation', const MainAnimationPage()),
      ],
    );
  }
}
