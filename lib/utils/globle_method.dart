import 'package:flutter/material.dart';

Widget topPadding(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).viewPadding.top,
  );
}

Widget botPadding(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).viewPadding.bottom,
  );
}
