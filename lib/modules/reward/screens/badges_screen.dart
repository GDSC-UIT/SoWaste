import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BadgeScreen extends StatelessWidget {
  const BadgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> badges = [
      "https://i.pinimg.com/564x/e8/a6/29/e8a6295025285f37aeb1a9ecbd9c642f.jpg",
      "https://i.pinimg.com/564x/1b/1f/57/1b1f573c3eafa456044b71fa47f88f86.jpg",
      "https://i.pinimg.com/564x/fc/fa/68/fcfa68037144b5ce8f14075e12ace789.jpg",
      "https://i.pinimg.com/564x/f5/7e/ea/f57eeaea750b772c083acbd7ad971aa8.jpg",
      "https://i.pinimg.com/564x/33/47/16/3347168a4159ab1d424062fd3a39623c.jpg",
      "https://i.pinimg.com/564x/20/0f/50/200f509408e5ae122d1a45d110f2faa2.jpg"
    ];

    return GridView.count(
      crossAxisCount: 3,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      mainAxisSpacing: 24.0,
      crossAxisSpacing: 26.0,
      children: List.generate(
        badges.length,
        (index) => GridTile(
          child: Image.network(
            badges[index],
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
