import 'package:blogui/article.dart';
import 'package:blogui/gen/fonts.gen.dart';
import 'package:blogui/home.dart';
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
            backgroundColor: Colors.white,
            /* رنگ تکست ها و آیتم های رویی */
            foregroundColor: primaryTextColor,
            elevation: 0,
            /* فاصله title ای که در اپ بار قرار میگرد از دو طرف */
            titleSpacing: 32,
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
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

const int homeIndex = 0;

const int articleIndex = 1;

const int searchIndex = 2;

const int menuIndex = 3;

const double bottomNavHeight =  65 ; 

class _MainScreenState extends State<MainScreen> {
  int selectedScreenIndex = homeIndex;

  /* روش زیر برای bottom nav های ساده خیلی خوب کار میکنه*/
  /* ولی برای مورد ما صفحه باید بره پشت bottom nav پس به روش دوم مینویسیم */
/*  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _BottomNavigation(onTap: (int index){
        setState(() {
          selectedScreenIndex =  index ;
        });
      }, selectedIndex: selectedScreenIndex,),
      *//*میهش بادی را به این شکل داد بهش ولی اون وقت همیشه یک صفحه میشه *//*
      // body: HomeScreen(),
      body: IndexedStack(
        *//* این ایندکس به صورت پیش فرض انتخاب میشه  *//*
        index: selectedScreenIndex,
        children: [
          HomeScreen(),
          ArticleScreen(),
          SearchScreen(),
          ProfileScreen()
        ],
      ),
    );
  }*/

/* روش دوم مدیریت bottom nav */
  /* بادی را میبریم داخل یک استک */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* میهش بادی را به این شکل داد بهش ولی اون وقت همیشه یک صفحه میشه */
      // body: HomeScreen(),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: bottomNavHeight,
            child: IndexedStack(
            /*   این ایندکس به صورت پیش فرض انتخاب میشه  */
              index: selectedScreenIndex,
              children: [
                HomeScreen(),
                ArticleScreen(),
                SearchScreen(),
                ProfileScreen()
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0 ,
            left: 0  ,
            child: _BottomNavigation(onTap: (int index){
              setState(() {
                selectedScreenIndex =  index ;
              });
            }, selectedIndex: selectedScreenIndex,),
          ),
        ],
      ),
    );
  }

}

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'Search Screen',
      style: Theme.of(context).textTheme.headline4,
    ));
  }
}

class _BottomNavigation extends StatelessWidget {
  final Function(int index) onTap;
  final int selectedIndex ;

  const _BottomNavigation({Key? key, required this.onTap , required this.selectedIndex}) : super(key: key);

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
              height: bottomNavHeight,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    blurRadius: 20,
                    color: const Color(0xaa9B8487).withOpacity(0.3))
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BottomNavigationItem(
                    iconFileName: 'Home.png',
                    activeIconFileName: 'Home.png',
                    title: 'Home',
                    isActive: selectedIndex==homeIndex,
                    onTap: () {
                      onTap(homeIndex);
                    },
                  ),
                  BottomNavigationItem(
                    iconFileName: 'Articles.png',
                    activeIconFileName: 'Articles.png',
                    title: 'Article',
                      isActive: selectedIndex==articleIndex,
                    onTap: () {
                      onTap(articleIndex);
                    },
                  ),
                  // SizedBox(width: 8,),
                  /* در حالت بالا فقط ۸ تا فضا وسط میذاریم که کمه*/
                  /* در حالت پایین فضا به طور مساوی بین ۵ آیتم تقسیم میشه */
                  Expanded(child: Container())  ,
                  BottomNavigationItem(
                    iconFileName: 'Search.png',
                    activeIconFileName: 'Search.png',
                    title: 'Search',
                    isActive: selectedIndex==searchIndex,
                    onTap: () {onTap(searchIndex) ; },
                  ),
                  BottomNavigationItem(
                    iconFileName: 'Menu.png',
                    activeIconFileName: 'Menu.png',
                    title: 'Menu',
                    isActive: selectedIndex==menuIndex,
                    onTap: () {onTap(menuIndex);},
                  ),
                ],
              ),
            ),
          ),
          /* دقیقا از بالا و پایین و چپ و راست وسط پرنتش قرار میگیره */
          Center(
            child: Container(
              width: 65,
              height: 85,
              alignment: Alignment.topCenter,
              child: Container(
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.5),
                    color: Color(0xff376AED),
                    border: Border.all(color: Colors.white, width: 4),
                  ),
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
  final bool isActive ;
  final Function() onTap;

  const BottomNavigationItem({
    Key? key,
    required this.iconFileName,
    required this.activeIconFileName,
    required this.title,
    required this.isActive ,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = Theme.of(context) ;

    return Expanded(
      flex: 1 ,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/icons/$iconFileName'
              , color: isActive? themeData.colorScheme.primary : themeData.textTheme.caption!.color , ),
            const SizedBox(
              height: 4,
            ),
            Text(
              title,
              style: themeData.textTheme.caption!
                  .apply(color: isActive? themeData.colorScheme.primary : themeData.textTheme.caption!.color)
            )
          ],
        ),
      ),
    );
  }
}
