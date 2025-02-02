part of 'widgets.dart';

class AppBarWelcome extends StatelessWidget {
  const AppBarWelcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 11.h,
      // margin: EdgeInsets.symmetric(vertical: 7.h, horizontal: 15),
      child: Row(
        children: [
          Image(
            // width: 0.3.dp,
            // height: 0.3.dp,
            image: const AssetImage(kIconSplash),
          ),
          // const SizedBox(width: 5),
          // Text(
          //   kAppName,
          //   style: Get.textTheme.headlineMedium!.copyWith(color: kColorPrimary),
          // ),
          // Container(
          //   width: 1,
          //   height: 8.h,
          //   margin: const EdgeInsets.symmetric(horizontal: 13),
          //   color: kColorHint,
          // ),

          // Expanded(
          //   child: BlocBuilder<AuthBloc, AuthState>(
          //     builder: (context, state) {
          //       if (state is AuthSuccess) {
          //         final userInfo = state.user.userInfo;
          //         return Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Text(
          //               dateNowWelcome(),
          //               style: Get.textTheme.titleSmall!
          //                   .copyWith(color: kColorPrimary),
          //             ),
          //             Expanded(
          //               child: Text(
          //                 "Expiration: ${expirationDate(userInfo!.expDate)}",
          //                 style: Get.textTheme.titleSmall!.copyWith(
          //                   color: kColorHint,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         );
          //       }

          //       return const SizedBox();
          //     },
          //   ),
          // ),
      
          // IconButton(
          //   focusColor: kColorFocus,
          //   onPressed: () {
          //     Get.toNamed(screenSettings);
          //   },
          //   icon: Icon(
          //     FontAwesomeIcons.gear,
          //     color: kColorPrimary,
          //     size: 19.sp,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class CardWelcomeSetting extends StatelessWidget {
  const CardWelcomeSetting(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);
  final String title;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      focusColor: kColorFocus,
      child: Row(
        children: [
          Ink(
            width: 7.w,
            height: 7.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const RadialGradient(colors: [
                kColorCardDark,
                kColorCardLight,
              ]),
            ),
            child: Center(
              child: Icon(
                icon,
                color: kColorPrimary,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: Get.textTheme.headlineSmall!.copyWith(color: kColorPrimary),
          ),
        ],
      ),
    );
  }
}

class CardWelcomeTv extends StatelessWidget {
  const CardWelcomeTv({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.title,
    required this.subTitle,
    this.autoFocus = false,
  }) : super(key: key);
  final String icon;
  final String title;
  final String subTitle;
  final Function() onTap;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      focusColor: kColorFocus,
      autofocus: autoFocus,
      onFocusChange: (value) {},
      child: Ink(
        decoration: BoxDecoration(
          color: Kmoon3,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              width: 8.w,
              image: AssetImage(icon),
            ),
            SizedBox(height: 3.h),
            Text(
              title,
              style: Get.textTheme.displaySmall!.copyWith(color: kColorPrimary),
            ),
            SizedBox(height: 1.h),
            Text(
              "◍ $subTitle",
              style: Get.textTheme.titleSmall!.copyWith(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

class CardTallButton extends StatelessWidget {
  const CardTallButton(
      {Key? key,
      required this.label,
      required this.onTap,
      this.radius = 5,
      this.isLoading = false})
      : super(key: key);
  final String label;
  final Function() onTap;
  final double radius;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        width: 100.w,
        height: 55,
        duration: const Duration(milliseconds: 300),
        child: ElevatedButton(
          onPressed: onTap,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(kColorPrimary),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ))),
          child: isLoading
              ? LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white,
                  size: 40,
                )
              : Text(
                  label,
                  style: Get.textTheme.headlineLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
