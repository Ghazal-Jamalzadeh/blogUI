import 'package:blogui/carousel/carousel_slider.dart';
import 'package:blogui/data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String defaultFontFamily = 'Avenir';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //colors
    const primaryTextColor = Color(0xff0D253C);
    const Color secondaryTextColor = Color(0xff2D4379);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            subtitle1: TextStyle(
              fontFamily: defaultFontFamily,
              color: secondaryTextColor,
              fontSize: 14,
            ),
            headline6: TextStyle(
              fontFamily: defaultFontFamily,
              fontWeight: FontWeight.bold,
              color: primaryTextColor,
              fontSize: 18,
            ),
            bodyText2: TextStyle(
              fontFamily: defaultFontFamily,
              color: secondaryTextColor,
              fontSize: 12,
            ),
          )),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final stories = AppDatabase.stories;

    /* برای استفاده از متریال تم باید روت این صفحه Scaffold باشه */
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            /* به صورت پیش فرض در column فرزندان وسط قرار میگیرند برای جلوگیری از این */
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hello Jonathan!',
                      style: themeData.textTheme.subtitle1,
                    ),
                    Image.asset(
                      'assets/img/icons/notification.png',
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 0, 24),
                child: Text("Explore Today's",
                    style: themeData.textTheme.headline6),
              ),
              _StoryList(stories: stories),
              SizedBox(
                height: 16,
              ),
              _CategoryList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = AppDatabase.categories;
    return CarouselSlider.builder(
        itemCount: categories.length,
        itemBuilder: (context, index, realIndex) {
          return _CategoryItem(
            category: categories[index],
            left: realIndex == 0 ? 32 : 8 ,
            right: realIndex == categories.length -1 ? 32 : 8  ,
          );
        },
        options: CarouselOptions(
            scrollDirection: Axis.horizontal,
            /* جهت چینش آیتم ها - پیش فرض افقی است */
            viewportFraction: 0.8,
            /* هر کدام از آیتم ها چند درصد صفحه را بگیرند */
            aspectRatio: 1.3,
            /* نسبت تصویر آیتم های اسلایدر - ۱ یعنی مربع*/
            initialPage: 0,
            /* از کدام آیتم شروع کند به نمایش دادن */
            scrollPhysics: const BouncingScrollPhysics(),
            /* افکت حالت آیفون اسکرول میخورد */
            disableCenter: true,
            /* به صورت پیش فرض آیتمی که روشیم وسط صفحه قرار میگرد که میشه دیس ایبل کرد */
            /* اگر اینو true کنیم آیتم وسطی دیگه بزرگتر نمیشه */
            autoPlay: false,
            /*مشخصه چیه */
            enableInfiniteScroll: false,
            /* لوپ */
            enlargeCenterPage: true,
            /* آیتم وسطی بزرگتر شود */
            enlargeStrategy: CenterPageEnlargeStrategy.height));
  }
}

class _CategoryItem extends StatelessWidget {
  final Category category;
  /*برای آیتم اپل و آخر میخواهیم یک margin اضافه در نظر بگیریم */
  final double left;
  final double right;

  const _CategoryItem({
    Key? key,
    required this.category,
    required this.left ,
    required this.right ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(left , 0 , right , 0  ),
      child: Stack(
        children: [
          /*چون این container یک گرادیانت به صورت فورگراند داره اگه تکستی توش قرار بگیره هم می افته پشت گرادیانت - پس از استک استفاده میکنیم که آیتم ها را روی هم میچینه */
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(32),
              ),
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      Color(0xff0D253C),
                      Colors.transparent,
                    ]),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  'assets/img/posts/large/${category.imageFileName}',
                  fit: BoxFit.cover, /* معادل scale type */
                ),
              ),
            ),
          ),
          Positioned.fill(
              top: 180,
              right: 65,
              left: 65,
              bottom: 24,
              child: Container(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(blurRadius: 20, color: Color(0xaa0D253C)),
                ]),
              )),
          Positioned(
              bottom: 48,
              left: 32,
              child: Text(category.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .apply(color: Colors.white)))
        ],
      ),
    );
  }
}

class _StoryList extends StatelessWidget {
  final List<Story> stories;

  const _StoryList({
    Key? key,
    required this.stories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
        /*حالت آیفون اسکرول میخورد */
          physics: const BouncingScrollPhysics(),
          itemCount: stories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final story = stories[index];

            return _StoryItem(story: story, themeData: themeData);
          }),
    );
  }
}

class _StoryItem extends StatelessWidget {
  const _StoryItem({
    Key? key,
    required this.story,
    required this.themeData,
  }) : super(key: key);

  final Story story;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [
                      Color(0xff376AED),
                      Color(0xff49B0E2),
                      Color(0xff9CECFB),
                    ]),
              ),
              child: Container(
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                      'assets/img/stories/${story.imageFileName}'),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                'assets/img/icons/${story.iconFileName}',
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(story.name, style: themeData.textTheme.bodyText2)
      ],
    );
  }
}
