  import 'package:flutter/material.dart';

class Clickaple extends StatelessWidget {
  final Widget child;
  final VoidCallback ontap;
    const Clickaple({super.key,required this.child,required this.ontap});
    @override
    Widget build(BuildContext context) {
      return  InkWell(
        onTap: ontap ,
        child: child,
      );
    }
  }

