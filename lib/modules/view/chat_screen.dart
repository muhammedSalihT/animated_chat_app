import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:animated_chat_app/constants/const_colors.dart';
import 'package:animated_chat_app/modules/view/flash_card_screen.dart';
import 'package:animated_chat_app/widgets/custom_svg_widget.dart';
import 'package:animated_chat_app/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.chatBoxScaffoldColor,
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: ConstColors.appWhite,
        leading: const Padding(
          padding: EdgeInsets.all(10),
          child: CustomSvgWidget(
            path: 'assets/back.svg',
          ),
        ),
        title: Row(
          children: [
            Image.asset('assets/Speeki-ai-Logo__Original_Transparen-BG_1 2.png',
                height: 30.h, width: 30.h),
            SizedBox(
              width: 15.w,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: 'JOHN DOE',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                CustomTextWidget(
                  text: 'Online',
                  color: ConstColors.appPrimeryColor,
                  fontSize: 15,
                )
              ],
            )
          ],
        ),
        actions: [
          Icon(
            Icons.more_vert_rounded,
            color: ConstColors.appBlack,
            size: 30.sp,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 250.h,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ConstColors.chatBoxColor,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: const CustomTextWidget(
                  text:
                      '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took.''',
                  fontSize: 14,
                  maxLines: 40,
                  color: ConstColors.appWhite,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 20.h),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return RefractedChatBoxWidget(
                    index: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom != 0
          ? null
          : FloatingActionButton(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                height: 50.h,
                width: 50.h,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: ConstColors.appPrimeryColor),
                child: Center(
                  child: Image.asset(
                      'assets/Speeki-ai-Logo__Original_Transparen-BG_1 2.png',
                      height: 25.h,
                      width: 25.h),
                ),
              ),
              onPressed: () {},
              //params
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        height: 70.h,
        notchMargin: 20,
        onTap: (index) {
          if (index == 0) {
            SystemChannels.textInput.invokeMethod("TextInput.show");
          }
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FlashCardScreen(),
              ),
            );
          }
        },
        icons: const [
          Icons.keyboard,
          Icons.arrow_forward_ios_rounded,
        ],
        activeIndex: 1,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,

        //other params
      ),
    );
  }
}

class RefractedChatBoxWidget extends StatelessWidget {
  const RefractedChatBoxWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final bool isUser = index.isEven;
    return Padding(
      padding: EdgeInsets.only(
        bottom: 10.h,
      ),
      child: Row(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser)
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Image.asset(
                  'assets/Speeki-ai-Logo__Original_Transparen-BG_1 2.png',
                  height: 30.h,
                  width: 30.h),
            ),
          Container(
            constraints: BoxConstraints(maxWidth: 150.w),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: ConstColors.greyLight, width: .1),
              color: isUser ? ConstColors.appWhite : ConstColors.chatBoxColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight:
                      isUser ? Radius.circular(0.r) : Radius.circular(20.r),
                  topLeft:
                      !isUser ? Radius.circular(0.r) : Radius.circular(20.r),
                  topRight: Radius.circular(20.r)),
            ),
            child: CustomTextWidget(
              text: 'Lorem Ipsum is simply dummy ',
              fontSize: 10,
              fontWeight: FontWeight.w600,
              maxLines: 10,
              color: isUser ? ConstColors.appBlack : ConstColors.appWhite,
            ),
          ),
          if (isUser)
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Image.asset('assets/Ellipse 1057.png',
                  height: 30.h, width: 30.h),
            ),
        ],
      ),
    );
  }
}
