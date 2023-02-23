import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foxtrot_app/pages/about_page/about_cubit.dart';
import 'package:foxtrot_app/pages/about_page/users_data.dart';
import 'package:foxtrot_app/utils/date_util.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:readmore/readmore.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'about_state.dart';

class AboutLayout extends StatefulWidget {
  const AboutLayout({Key? key}) : super(key: key);

  @override
  State<AboutLayout> createState() => _AboutLayoutState();
}

class _AboutLayoutState extends State<AboutLayout> {
  bool smallAppBar = false;
  bool changeSlidePanel = false;
  void _changeAppBar(bool appbar) {
    setState(() {
      smallAppBar = appbar;
    });
  }

  void _changeSlidePanel(bool slideIsOpen) {
    setState(() {
      changeSlidePanel = slideIsOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: PreferredSize(
          preferredSize: smallAppBar == true ? const Size.fromHeight(120) : const Size.fromHeight(250),
          child: _buildAppBar(smallAppBar),
        ),
        body: _buildAppBarContent(context),
      ),
    );
  }

  Widget _buildAppBarContent(BuildContext context) {
    const CameraPosition kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );

    const Marker kGooglePlexMarker = Marker(
      markerId: MarkerId('kGooglePlexMarker'),
      infoWindow: InfoWindow(title: 'Google plex'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(37.42796133580664, -122.085749655962),
    );
    final Completer<GoogleMapController> controller = Completer<GoogleMapController>();
    final AboutCubit aboutCubit = context.read<AboutCubit>();

    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Container(),
        _buildSecondTab(aboutCubit),
        _buildThirdTab(kGooglePlexMarker, kGooglePlex, context),
      ],
    );
  }

  Stack _buildThirdTab(Marker kGooglePlexMarker, CameraPosition kGooglePlex, BuildContext context) {
    return Stack(
      children: [
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constrains) {
            return SizedBox(
              height: constrains.maxHeight,
              child: GoogleMap(
                markers: {kGooglePlexMarker},
                mapType: MapType.normal,
                initialCameraPosition: kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  // controller.complete(controller);
                },
              ),
            );
          },
        ),
        SlidingUpPanel(
          onPanelClosed: () {
            _changeSlidePanel(false);
          },
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          onPanelOpened: () {
            _changeSlidePanel(true);
          },
          color: Colors.white,
          minHeight: MediaQuery.of(context).size.height / 3,
          maxHeight: MediaQuery.of(context).size.height,
          panelBuilder: (ScrollController sc) => _scrollingList(sc),
        ),
      ],
    );
  }

  Widget _scrollingList(ScrollController sc) {
    return ListView.builder(
        controller: sc,
        itemCount: 50,
        itemBuilder: (BuildContext context, int i) {
          if (i == 0) {
            return changeSlidePanel == false
                ? Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 12),
                          child: Container(
                            height: 4,
                            width: 40,
                            decoration: const BoxDecoration(
                                color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                        const Text(
                          'Список магазинов',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ))
                : Row(
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 23, left: 16, bottom: 10),
                        child: Text(
                          'Список магазинов',
                          style: TextStyle(fontSize: 16, color: Color.fromRGBO(0, 0, 0, 0.54)),
                        ),
                      ),
                    ],
                  );
          } else {
            return InkWell(
              onTap: () {
                print(i);
              },
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Color.fromRGBO(0, 0, 0, 0.12),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(
                            'assets/images/foxtrot.png',
                          ),
                          radius: 17,
                        ),
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        child: Container(
                          decoration:
                              const BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 13,
                              ),
                              const Text(
                                'Магазин “Фокстрот”',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'просп. Центральный, $i',
                                style: const TextStyle(color: Colors.teal),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }

  Widget _buildSecondTab(AboutCubit aboutCubit) {
    return SingleChildScrollView(
      child: BlocConsumer<AboutCubit, AboutState>(
        listener: ((context, state) {}),
        builder: (context, state) {
          return Column(
            children: <Widget>[
              _buildRating(),
              _buildAbout(),
              _buildWorkingHours(),
              Padding(
                padding: const EdgeInsets.only(top: 23, left: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Отзывы",
                      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.54)),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state is AboutLoadedState ? state.users.length : userDataList.length,
                itemBuilder: (context, index) {
                  return _buildListReviews(index, state);
                },
                shrinkWrap: true,
              ),
              state is AboutLoadedState ? const SizedBox() : _buildReviews(context, aboutCubit)
            ],
          );
        },
      ),
    );
  }

  Widget _buildListReviews(int index, AboutState state) {
    return Slidable(
      enabled: state is AboutLoadedState && (state.users[index].thisMy == true) ? true : false,
      endActionPane: ActionPane(
        extentRatio: 0.171,
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          Expanded(
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SlidableAction(
                    onPressed: (context) {},
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                  ),
                  SlidableAction(
                    onPressed: (context) {},
                    backgroundColor: const Color(0xFF3C83EE),
                    foregroundColor: Colors.white,
                    icon: Ionicons.pencil,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      key: state is AboutLoadedState ? ValueKey(state.users[index]) : ValueKey(userDataList[index]),
      child: Container(
        decoration: BoxDecoration(
            color: state is AboutLoadedState && (state.users[index].thisMy == true)
                ? const Color(0xFFF6F6F6)
                : Colors.white,
            border: state is AboutLoadedState && (state.users[index].thisMy == true)
                ? const Border(
                    left: BorderSide(width: 3.0, color: Color(0xFF02AD58)),
                  )
                : null),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color.fromRGBO(0, 0, 0, 0.12),
                              width: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        state is AboutLoadedState ? Text(state.users[index].name) : Text(userDataList[index].name),
                        const SizedBox(
                          height: 3,
                        ),
                        RatingBar.builder(
                          ignoreGestures: true,
                          glow: false,
                          initialRating: state is AboutLoadedState ? state.users[index].star : userDataList[index].star,
                          itemSize: 15,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Color(0xfff88821),
                          ),
                          onRatingUpdate: (ff) {
                            //print(ff);
                          },
                        ),
                        const SizedBox(
                          height: 19,
                        ),
                        state is AboutLoadedState ? Text(state.users[index].text) : Text(userDataList[index].text),
                        const SizedBox(
                          height: 13,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviews(BuildContext context, AboutCubit aboutCubit) {
    TextEditingController reviewController = TextEditingController();
    double rating = 0;
    return Container(
      color: const Color(0xffF6F6F6),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 16),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color.fromRGBO(0, 0, 0, 0.12),
                      width: 3,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Text(
            "Оставить отзыв",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 8,
          ),
          const SizedBox(
            width: 270,
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing",
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          RatingBar.builder(
            glow: false,
            initialRating: 3,
            itemSize: 40,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 10.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Color(0xfff88821),
            ),
            onRatingUpdate: (ratingChange) {
              rating = ratingChange;
            },
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: reviewController,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
                hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
                hintText: 'Опишите свои впечатления',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.91,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shadowColor: const Color.fromRGBO(255, 71, 61, 0.25),
                  elevation: 20,
                  backgroundColor: const Color(0xffFF473D)),
              onPressed: () {
                aboutCubit.fetchSuggestions(reviewController.text, rating);
              },
              child: const Text("Опишите свои впечатления"),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget _buildRating() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.12)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  "Фокстрот",
                  style: TextStyle(fontSize: 24),
                ),
                RatingBar.builder(
                  ignoreGestures: true,
                  glow: false,
                  initialRating: countUsers(),
                  itemSize: 25,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Color(0xfff88821),
                  ),
                  onRatingUpdate: (count) {},
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text(
                  "Lorem ipsum",
                  style: TextStyle(fontSize: 14, color: Color.fromRGBO(0, 0, 0, 0.5)),
                ),
                Text(
                  "300.555",
                  style: TextStyle(fontSize: 14, color: Color.fromRGBO(0, 0, 0, 0.3)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAbout() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.12)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: const <Widget>[
                Icon(
                  Icons.info_outline,
                  color: Color.fromRGBO(0, 0, 0, 0.54),
                ),
                SizedBox(
                  width: 34,
                ),
                Text(
                  "О компании",
                  style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.54)),
                ),
              ],
            ),
            Row(
              children: const <Widget>[
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(top: 22, left: 58, right: 16, bottom: 22),
                    child: ReadMoreText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do usermod temper incident ut laborer et do lore magna aliquot. Ut denim ad minim venial, quits nostrum excitation McCull-och labors nisei ut aliquot ex ea commode consequent. Dis auto iru...Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do usermod temper incident ut labor et do lore magna aliquot. Ut enum ad minim venial, quits nostrum excitation McCull-och labors nisei ut aliquot ex ea commode consequent. Dis auto iru...',
                      trimLines: 6,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'ДЕТАЛЬНЕЕ',
                      trimExpandedText: 'СКРЫТЬ',
                      moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff02AD58)),
                      lessStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff02AD58),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkingHours() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.12)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 34),
              child: Column(
                children: const <Widget>[
                  Icon(
                    Icons.access_time,
                    color: Color.fromRGBO(0, 0, 0, 0.54),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Wrap(
                runSpacing: 10,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        "График работы",
                        style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.54)),
                      ),
                      checkOpen()
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  _buildDayOfWeek('Понедельник', "Monday", "12:00 - 00:00"),
                  _buildDayOfWeek('Вторник', "Tuesday", "12:00 - 00:00"),
                  _buildDayOfWeek('Среда', "Wednesday", "12:00 - 00:00"),
                  _buildDayOfWeek('Четверг', "Thursday", "12:00 - 00:00"),
                  _buildDayOfWeek('Пятница', "Friday", "12:00 - 00:00"),
                  _buildDayOfWeek('Суббота', "Saturday", "12:00 - 00:00"),
                  _buildDayOfWeek('Воскресенье', "Sunday", "12:00 - 00:00"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDayOfWeek(String dayText, String dayCheck, String openHours) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          dayText,
          style: checkTime(dayCheck),
        ),
        Text(
          openHours,
          style: checkTime(dayCheck),
        ),
      ],
    );
  }

  AppBar _buildAppBar(bool smallAppBar) {
    return AppBar(
      title: smallAppBar == true
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Фокстрот"),
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              ],
            )
          : null,
      flexibleSpace: smallAppBar == false ? Image.asset('assets/images/logo.png') : null,
      bottom: TabBar(
        onTap: (tab) {
          print(tab);
          if (tab == 2) {
            _changeAppBar(true);
          }
          if (tab == 1) {
            _changeAppBar(false);
          }
        },
        indicatorColor: Colors.white,
        tabs: const <Widget>[
          Tab(
            text: "Предложения",
          ),
          Tab(
            text: "Подробнее",
          ),
          Tab(
            text: "Локации",
          )
        ],
      ),
      backgroundColor: const Color(0xffFE5000),
    );
  }
}

TextStyle checkTime(String day) {
  if (DateUtil().dayOfWeek == day && DateUtil().hourTimeNow >= 12 && DateUtil().hourTimeNow <= 24) {
    return const TextStyle(fontWeight: FontWeight.w700);
  } else {
    return const TextStyle(fontWeight: FontWeight.w400, color: Color.fromRGBO(0, 0, 0, 0.54));
  }
}

double countUsers() {
  double numbersOfStars = 0;
  for (var element in userDataList) {
    numbersOfStars += element.star;
  }
  numbersOfStars = numbersOfStars / userDataList.length;
  return numbersOfStars;
}

Widget checkOpen() {
  if ((DateUtil().hourTimeNow >= 12 && DateUtil().hourTimeNow <= 24)) {
    return const Text("Открыто", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.green));
  } else {
    return const Text(
      "Закрыто",
      style: TextStyle(color: Color(0xffFF473D), fontWeight: FontWeight.w700),
    );
  }
}
