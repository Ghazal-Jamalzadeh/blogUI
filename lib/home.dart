

import 'package:blogui/article.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'carousel/carousel_slider.dart';
import 'data.dart';
import 'gen/assets.gen.dart';
import 'gen/fonts.gen.dart';

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
          /*حالت آیفون اسکرول میخورد */
          physics: BouncingScrollPhysics(),
          child: Column(
            /* به صورت پیش فرض در column فرزندان وسط قرار میگیرند برای جلوگیری از این */
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Hello Jonathan!', style: themeData.textTheme.subtitle1,),
                    Assets.img.icons.notification.image(width: 32 , height: 32 ),
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
              _PostList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _StoryList extends StatelessWidget {
  final List<StoryData> stories;

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

  final StoryData story;
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
                gradient:
                const LinearGradient(begin: Alignment.topLeft, colors: [
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
                  child:
                  Image.asset('assets/img/stories/${story.imageFileName}'),
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
            left: realIndex == 0 ? 32 : 8,
            right: realIndex == categories.length - 1 ? 32 : 8,
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
    required this.left,
    required this.right,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(left, 0, right, 0),
      child: Stack(
        children: [
          /*چون این container یک گرادیانت به صورت فورگراند داره اگه تکستی توش قرار بگیره هم می افته پشت گرادیانت - پس از استک استفاده میکنیم که آیتم ها را روی هم میچینه */
          Positioned.fill(
              top: 100,
              right: 65,
              left: 65,
              bottom: 24,
              child: Container(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(blurRadius: 20, color: Color(0xaa0D253C)),
                ]),
              )),
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
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

class _PostList extends StatelessWidget {
  const _PostList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final posts = AppDatabase.posts;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Latest News',
                style: Theme.of(context).textTheme.headline5,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'more',
                  style: TextStyle(color: Color(0xff376AED)),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
            itemCount: posts.length,
            /* باید ارتفاع پست ها مشخص باشد که بدونه چقدر میتونه ادامه بده لیست را */
            itemExtent: 141,
            /* برای لیست های طولانی و تو درتو این را true نکنید چون پرفورمنس بد میشه */
            /* توی فلاتر width height برای تکست ویو باید کاملا مشخص باشه */
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              final post = posts[index];
              return Post(post: post);
            }),
        SizedBox(
          height: 32,
        )
      ],
    );
  }
}

class Post extends StatelessWidget {
  const Post({
    Key? key,
    required this.post,
  }) : super(key: key);

  final PostData post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const ArticleScreen())),
      child: Container(
        height: 149,
        margin: const EdgeInsets.fromLTRB(32, 8, 32, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Color(0x15282FF),
            )
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child:
                Image.asset('assets/img/posts/small/${post.imageFileName}')),
            const SizedBox(
              width: 16,
            ),
            /* اگه تکست را همینجوری بندازیم اونجا و خط بلند شه ارور overflow میگیریم.
          این مشکل با expanded حل میشه. بهش میگه هر چقدر فضا باقی مونده استفاده کن نه بیشتر نه کمتر. 0pd  */
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.caption,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily:FontFamily.avenir,
                        fontSize: 14,
                        color: Color(0xff376AED),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      post.title,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(CupertinoIcons.hand_thumbsup,
                            size: 16,
                            color: Theme.of(context).textTheme.bodyText2!.color),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(post.likes,
                            style: Theme.of(context).textTheme.bodyText2),
                        const SizedBox(
                          width: 16,
                        ),
                        Icon(CupertinoIcons.clock,
                            size: 16,
                            color: Theme.of(context).textTheme.bodyText2!.color),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(post.time,
                            style: Theme.of(context).textTheme.bodyText2),
                        /* برای اینکه مطمعن شیم ایکون ته قرار میگیره داخل expanded میندازیمش و بعد داخل یک container و به این container میایم alignment میدیم*/
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Icon(
                                post.isBookmarked
                                    ? CupertinoIcons.bookmark_fill
                                    : CupertinoIcons.bookmark,
                                size: 16,
                                color:
                                Theme.of(context).textTheme.bodyText2!.color),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}