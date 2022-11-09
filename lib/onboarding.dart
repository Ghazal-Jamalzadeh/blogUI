import 'package:blogui/auth.dart';
import 'package:blogui/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'data.dart';
import 'gen/assets.gen.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  final items = AppDatabase.onBoardingItems;

  int page = 0;

  /* این فانکشن زمانی کال میشه که برای اولین بار ویجت ساخته میشه*/
  @override
  void initState() {
    _pageController.addListener(() {
      /* این pageController یک getter ی دارد به اسم page
       که page ای که در حال حاضر توشیم را داخل خودش نگهدداری میکنه در فرمت double
        چون مثلا وقتی بین دو تا صفحه هستیم مقدارش میشه 1.5
        */
      if (_pageController.page!.round() != page) {
        setState(() {
          page = _pageController.page!.round();
          debugPrint('Onboarding: Selected Page -> $page');
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 8),
                child: Assets.img.background.onboarding.image(),
              ),
            ),
            Container(
              height: 260,
              decoration: BoxDecoration(
                  color: themeData.colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.black.withOpacity(0.1),
                    )
                  ],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32))),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      itemCount: items.length,
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                items[index].title,
                                style: themeData.textTheme.headline4,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                items[index].description,
                                /*میگه سایز فونت را به اندازه ۹ دهم چیزی که هست بکن */
                                style: themeData.textTheme.subtitle1!.apply(fontSizeFactor: 0.9),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: 60,
                    padding:
                    const EdgeInsets.only(left: 32, right: 32, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmoothPageIndicator(
                          controller: _pageController,
                          count: items.length,
                          effect: ExpandingDotsEffect(
                              activeDotColor: themeData.colorScheme.primary,
                              dotWidth: 8,
                              dotHeight: 8,
                              dotColor: themeData.colorScheme.primary.withOpacity(0.1)
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (page == items.length - 1) {
                              Navigator.of(context).pushReplacement(
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                      const AuthScreen()));
                            } else {
                              _pageController.animateToPage(
                                  page + 1,
                                  duration: const Duration(milliseconds: 500),
                                  /* نوع انیمیشن - این انیمیشن اول سرعتش زیاده بعد کم میشه */
                                  curve: Curves.decelerate);
                            }
                          },
                          /* استایل را هم میشه اینجا ست کرد هم توی تم */
                          style: ButtonStyle(
                              minimumSize:
                              MaterialStateProperty.all(const Size(84, 60)),
                              /* میگیم توی همه state ها همین شکل را حفظ کن */
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              )),
                          child: Icon(page == items.length - 1
                              ? CupertinoIcons.check_mark
                              : CupertinoIcons.arrow_right),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
