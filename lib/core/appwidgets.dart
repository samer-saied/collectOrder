import 'package:collect_order/core/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomText extends StatelessWidget {
  final String txt;
  final Color color;
  final double size;
  final bool alignCenter;
  const CustomText(
      {Key? key,
      required this.txt,
      required this.color,
      required this.size,
      this.alignCenter = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      txt.toString(),
      textAlign: alignCenter ? TextAlign.center : TextAlign.start,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class CustomImage extends StatelessWidget {
  final double width;
  final double height;
  final String stringImage;
  const CustomImage({
    Key? key,
    required this.width,
    required this.height,
    required this.stringImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(stringImage),
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }
}

class CustomButton extends StatelessWidget {
  final Function()? onpressedFunc;
  final double width;
  final String txt;
  const CustomButton({
    Key? key,
    required this.txt,
    required this.width,
    this.onpressedFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50.0,
      child: ElevatedButton(
        style:
            ButtonStyle(foregroundColor: MaterialStateProperty.all(main2Color)),
        onPressed: onpressedFunc,
        child: CustomText(
          txt: txt,
          color: whiteColor,
          size: 24,
        ),
      ),
    );
  }
}

PreferredSizeWidget customAppBar(BuildContext context, String appBarTxt) {
  return AppBar(
    title: CustomText(
      txt: appBarTxt,
      color: whiteColor,
      size: 30,
    ),
    centerTitle: true,
  );
}

Widget angeryPersonWidget(BuildContext context, String txt) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.5,
    child: Stack(
      children: [
        Center(
          child: Image(
            width: MediaQuery.of(context).size.width * 0.5,
            image: const AssetImage("assets/images/person-1_empty.png"),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.height / 4 < 125
                ? 125
                : MediaQuery.of(context).size.height / 4,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/bubble.png"),
            )),
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.07,
              ),
              child: CustomText(
                txt: txt.tr,
                size: 24,
                color: mainColor,
                alignCenter: true,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
