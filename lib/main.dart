import 'package:blogui/article.dart';
import 'package:blogui/gen/fonts.gen.dart';
import 'package:blogui/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  /* تغییر رنگ استاتوس بار و نویگیشن گوشی در اپ فلاتزی */
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // static const String defaultFontFamily = 'Avenir';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //colors
    const primaryTextColor = Color(0xff0D253C);
    const Color secondaryTextColor = Color(0xff2D4379);
    const primaryColor = Color(0xff376AED);

    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
          primarySwatch: Colors.blue,

          /* رنگ های پروژه را اینجا تعریف میکنیم و از همه جا دسترسی داریم با کد زیر */
          /* color: Theme.of(context).colorScheme.surface,*/
          colorScheme: const ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              onSurface: primaryTextColor,
              background: Color(0xffFBFCFF),
              surface: Colors.white,
              onBackground: primaryTextColor),

          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  /* چون دکمه است MaterialStateProperty میگیره که state های مختلفی را ساپورت میکنه. ولی ما میزنیم all یعنی همه state ها  */
                  textStyle: MaterialStateProperty.all(const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamily.avenir,
          )))),

          /*تعریف استایل اپ بار */
          appBarTheme: const AppBarTheme(
            /*رنگ بک گراند */
            backgroundColor: Colors.white ,
            /* رنگ تکست ها و آیتم های رویی */
            foregroundColor: primaryTextColor ,
            elevation: 0 ,
            /* فاصله title ای که در اپ بار قرار میگرد از دو طرف */
            titleSpacing: 32 ,
          ),

          /* تم اسنک بار */
          // snackBarTheme: const SnackBarThemeData(
          //   backgroundColor: primaryColor ,
          // ),

          textTheme: const TextTheme(
            headline6: TextStyle(
              fontFamily: FontFamily.avenir,
              fontWeight: FontWeight.bold,
              color: primaryTextColor,
              fontSize: 18,
            ),
            headline4: TextStyle(
                fontFamily: FontFamily.avenir,
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: primaryTextColor),
            headline5: TextStyle(
                fontFamily: FontFamily.avenir,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: primaryTextColor),
            bodyText2: TextStyle(
              fontFamily: FontFamily.avenir,
              color: secondaryTextColor,
              fontSize: 12,
            ),
            subtitle1: TextStyle(
              fontFamily: FontFamily.avenir,
              color: secondaryTextColor,
              fontSize: 14,
            ),
            subtitle2: TextStyle(
                fontFamily: FontFamily.avenir,
                color: primaryTextColor,
                fontWeight: FontWeight.w400,
                fontSize: 14),
            caption: TextStyle(
                fontFamily: FontFamily.avenir,
                fontWeight: FontWeight.w700,
                color: Color(0xff7B8BB2),
                fontSize: 10),
          )),

      //home: Stack(
      //   children: const [
      //     /* یعنی کل صفحه را بگیرد  */
      //     Positioned.fill(bottom: 65, child: HomeScreen()),
      //     Positioned(bottom: 0, right: 0, left: 0, child: _BottomNavigation())
      //   ],
      // ),
      home: const ProfileScreen(),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.white,
                    boxShadow: [BoxShadow(blurRadius: 20 , color: const Color(0xaa9B8487).withOpacity(0.3))]
                ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  BottomNavigationItem(
                      iconFileName: 'Home.png',
                      activeIconFileName: 'Home.png',
                      title: 'Home'),
                  BottomNavigationItem(
                      iconFileName: 'Articles.png',
                      activeIconFileName: 'Articles.png',
                      title: 'Article'),
                  SizedBox(
                    width: 8,
                  ),
                  BottomNavigationItem(
                      iconFileName: 'Search.png',
                      activeIconFileName: 'Search.png',
                      title: 'Search'),
                  BottomNavigationItem(
                      iconFileName: 'Menu.png',
                      activeIconFileName: 'Menu.png',
                      title: 'Menu'),
                ],

            ),
            ),
          ) ,
          /* دقیقا از بالا و پایین و چپ و راست وسط پرنتش قرار میگیره */
          Center(
            child: Container(
              width: 65,
              height: 85,
              alignment: Alignment.topCenter,
              child: Container(
                height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.5) ,
                    color: Color(0xff376AED),
                      border: Border.all(color: Colors.white, width: 4),
              ) ,
                  child: Image.asset('assets/img/icons/plus.png')),
            ),
          )
        ],
      ),
    );
  }
}

class BottomNavigationItem extends StatelessWidget {
  final String iconFileName;
  final String activeIconFileName;
  final String title;

  const BottomNavigationItem(
      {Key? key,
      required this.iconFileName,
      required this.activeIconFileName,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/img/icons/$iconFileName'),
        const SizedBox(
          height: 4,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.caption,
        )
      ],
    );
  }
}
