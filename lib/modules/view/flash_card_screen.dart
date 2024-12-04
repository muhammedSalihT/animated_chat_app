import 'package:animated_chat_app/constants/const_colors.dart';
import 'package:animated_chat_app/modules/view_model/flash_provider.dart';
import 'package:animated_chat_app/widgets/custom_svg_widget.dart';
import 'package:animated_chat_app/widgets/custom_text_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FlashCardScreen extends StatefulWidget {
  const FlashCardScreen({super.key});

  @override
  State<FlashCardScreen> createState() => _FlashCardScreenState();
}

class _FlashCardScreenState extends State<FlashCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/Group 1171276412.png',
              ),
              Positioned(
                left: 30,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const CustomSvgWidget(
                    path: 'assets/back (1).svg',
                    size: 30,
                  ),
                ),
              ),
              const CustomTextWidget(
                text: 'Flash Card',
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: ConstColors.appWhite,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextWidget(
                  text: 'Everyday Phrases',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                SizedBox(
                  width: 20,
                ),
                CircularIndicator()
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const FlipCarousel(),
          const SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                2,
                (index) =>
                    Consumer<FlashProvider>(builder: (context, flashPro, _) {
                  return InkWell(
                    onTap: () => index == 0
                        ? flashPro.onbackWord()
                        : flashPro.onForword(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border:
                              Border.all(color: ConstColors.appPrimeryColor)),
                      child: CustomTextWidget(
                        text: index == 0 ? 'Previous' : 'Next',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CircularIndicator extends StatelessWidget {
  const CircularIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the progress

    return Consumer<FlashProvider>(builder: (context, flashPro, _) {
      return CustomPaint(
        painter:
            CirclePainter(flashPro.currentBarIndex / flashPro.items.length),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: CustomTextWidget(
              text:
                  '${flashPro.currentBarIndex}/${flashPro.items.length}', // Display the fraction
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    });
  }
}

class CirclePainter extends CustomPainter {
  final double progress;

  CirclePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    final Paint progressPaint = Paint()
      ..color = ConstColors.appPrimeryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    // Draw the background circle
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2,
        backgroundPaint);

    // Draw the progress circle (arc)
    double sweepAngle = 2 *
        3.141592653589793 *
        progress; // Calculate the sweep angle based on progress
    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2),
      -3.141592653589793 / 2, // Start angle (top of the circle)
      sweepAngle, // Sweep angle (progress)
      false, // Don't fill the arc
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint unless the progress changes
  }
}

class FlipCarousel extends StatefulWidget {
  const FlipCarousel({
    super.key,
  });

  @override
  _FlipCarouselState createState() => _FlipCarouselState();
}

class _FlipCarouselState extends State<FlipCarousel> {
  final con = FlipCardController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashProvider>(builder: (context, falshPro, _) {
      return CarouselSlider.builder(
        carouselController: falshPro.carouselSliderController,
        itemCount: falshPro.items.length,
        itemBuilder: (context, index, realIndex) {
          return FlipCard(
            controller: con,
            onTapFlipping: true,
            rotateSide: RotateSide.bottom,
            axis: FlipAxis.horizontal,
            backWidget: CustomFlipBoxWidget(
              index: index,
              translateText: 'Obvious',
            ),
            frontWidget: CustomFlipBoxWidget(
              index: index,
              translateText: falshPro.items[index],
            ),
          );
        },
        options: CarouselOptions(
          height: 230.h,
          scrollPhysics: const NeverScrollableScrollPhysics(),
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          viewportFraction: 0.8,
          initialPage: falshPro.currentBarIndex - 1,
          autoPlay: false,
        ),
      );
    });
  }
}

class CustomFlipBoxWidget extends StatelessWidget {
  const CustomFlipBoxWidget({
    super.key,
    required this.index,
    required this.translateText,
  });

  final int index;
  final String translateText;

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashProvider>(builder: (context, falshPro, _) {
      return Container(
        width: 350,
        height: 250,
        decoration: BoxDecoration(
          color: ConstColors.appPrimeryColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomTextWidget(
              text: translateText,
              fontSize: 40.sp,
              color: ConstColors.appWhite,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomSvgWidget(path: 'assets/sound.svg'),
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: const CustomTextWidget(
                    text: 'ob.wi.o',
                    fontSize: 15,
                    color: ConstColors.appWhite,
                  ),
                )
              ],
            ),
            Container(
              height: 50.h,
              width: 50.h,
              decoration: BoxDecoration(
                  color: ConstColors.appWhite,
                  borderRadius: BorderRadius.circular(10.r)),
              child: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: ConstColors.appBlack,
              ),
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      );
    });
  }
}
