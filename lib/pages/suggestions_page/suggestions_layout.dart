import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foxtrot_app/model/suggestions.dart';
import 'package:foxtrot_app/pages/about_page/about_page.dart';
import 'package:foxtrot_app/pages/profile_page/profile_page.dart';
import 'package:foxtrot_app/pages/sign_in_up_page/sign_in_page.dart';
import 'package:foxtrot_app/pages/suggestions_page/suggestions_cubit.dart';
import 'package:foxtrot_app/pages/suggestions_page/suggestions_state.dart';

class SuggestionsLayout extends StatelessWidget {
  const SuggestionsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: _buildDrawer(context),
        appBar: AppBar(
          title: _buildAppBarContent(context),
          backgroundColor: const Color(0xFF02AD58),
          bottom: _buildTapBarInAppBar(context),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildFirstTab(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildSecondTab(),
            ),
          ],
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff27C189),
              Color(0xff237BBF),
            ],
          ),
        ),
        child: _buildDrawerContent(context),
      ),
    );
  }

  Widget _buildDrawerContent(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 21, left: 21, bottom: 42),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        SvgPicture.asset('assets/images/logoDrawer.svg'),
        const SizedBox(
          height: 86,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 54),
          child: ListTile(
            leading: SvgPicture.asset(
              'assets/images/profile.svg',
            ),
            title: const Text(
              'Профиль',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const ProfilePage(),
              ));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 54),
          child: ListTile(
            leading: SvgPicture.asset('assets/images/position.svg'),
            title: const Text(
              'Позиции',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const AboutPage(),
              ));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 54),
          child: ListTile(
            leading: SvgPicture.asset('assets/images/corporation.svg'),
            title: const Text(
              'Корпоратка',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 54),
          child: ListTile(
            leading: SvgPicture.asset(
              'assets/images/transactions.svg',
            ),
            title: const Text(
              'Транзакции',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 54),
          child: ListTile(
            leading: SvgPicture.asset(
              'assets/images/settings.svg',
            ),
            title: const Text(
              'Настройка',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const SignInPage(),
              ));
            },
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 53, top: 78),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                shadowColor: const Color.fromRGBO(255, 71, 61, 0.25),
                elevation: 20,
                backgroundColor: const Color(0xffFF473D)),
            child: const Text('Добавить карту'),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              type: MaterialType.transparency,
              child: Ink(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromRGBO(255, 255, 255, 0.2),
                      width: 1.0),
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(50.0),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset('assets/images/social.svg'),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 32,
            ),
            Material(
              type: MaterialType.transparency,
              child: Ink(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromRGBO(255, 255, 255, 0.2),
                      width: 1.0),
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(50.0),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset('assets/images/exit.svg'),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildSecondTab() {
    return BlocConsumer<SuggestionsCubit, SuggestionsState>(
        listener: ((context, state) {
      log(state.toString());
      if (state is LoadedState) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Suggestions is Loaded')));
      }
    }), builder: (context, state) {
      if (state is EmptyState) {
        return const Center(
          child: Text(
            'No data received.',
            style: TextStyle(fontSize: 20),
          ),
        );
      }

      if (state is LoadingState) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is LoadedState) {
        return _buildSuggestionsGridBuilder(state);
      }
      return const SizedBox.shrink();
    });
  }

  Widget _buildSuggestionsGridBuilder(LoadedState state) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8),
      scrollDirection: Axis.vertical,
      itemCount: state.loadedSuggestions.length,
      itemBuilder: (context, index) {
        String? s = state.loadedSuggestions[index].logo;
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: state.loadedSuggestions[index].color != null
                  ? BoxDecoration(
                      color: Color(
                          int.parse("${state.loadedSuggestions[index].color}")),
                      borderRadius: BorderRadius.circular(8))
                  : null,
            ),
            Container(
              child: s == null
                  ? null
                  : Image.asset(
                      "${s.substring(0, s.length - 3)}png",
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFirstTab() {
    return BlocConsumer<SuggestionsCubit, SuggestionsState>(
        listener: ((context, state) {
      log(state.toString());
      if (state is LoadedState) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Suggestions is Loaded')));
      }
    }), builder: (
      context,
      state,
    ) {
      if (state is EmptyState) {
        return const Center(
          child: Text(
            'No data received',
            style: TextStyle(fontSize: 20),
          ),
        );
      }

      if (state is LoadingState) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is LoadedState) {
        return StaggeredGridView.countBuilder(
          staggeredTileBuilder: (int index) => index % 2 == 0 && index != 0
              ? const StaggeredTile.count(2, 1)
              : const StaggeredTile.count(1, 1.5),
          crossAxisCount: 2,
          itemCount: state.loadedSuggestions.length,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 500,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    decoration: state.loadedSuggestions[index].image != null
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.transparent,
                            image: DecorationImage(
                              image: AssetImage(
                                  "${state.loadedSuggestions[index].image}"),
                              fit: BoxFit.fill,
                            ))
                        : null,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      gradient: const LinearGradient(
                        stops: [0.0, 1.0],
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0),
                          Color.fromRGBO(0, 0, 0, 0.8)
                        ],
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                      ),
                    ),
                  ),
                  state.loadedSuggestions[index] is SuggestionsModel
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: 140,
                                  child: Text(
                                    "${state.loadedSuggestions[index].text}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )),
                              Text(
                                "${state.loadedSuggestions[index].endData}",
                                style: const TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 0.4),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            );
          },
          scrollDirection: Axis.vertical,
        );
      }
      return const SizedBox.shrink();
    });
  }

  PreferredSizeWidget _buildTapBarInAppBar(BuildContext context) {
    final SuggestionsCubit suggestionsCubit = context.read<SuggestionsCubit>();
    return TabBar(
      onTap: (tabIndex) {
        switch (tabIndex) {
          case 0:
            suggestionsCubit.clearSuggestions();
            suggestionsCubit.fetchSuggestions("suggestions");
            break;
          case 1:
            suggestionsCubit.clearSuggestions();
            suggestionsCubit.fetchSuggestions('partners');

            break;
        }
      },
      indicatorColor: Colors.white,
      tabs: const <Widget>[
        Tab(
          text: "Предложения",
        ),
        Tab(
          text: "Компании",
        )
      ],
    );
  }

  Widget _buildAppBarContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            SizedBox(
              width: 35,
            ),
            Text("Корпоратив"),
          ],
        ),
        Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.info_outline)),
          ],
        ),
      ],
    );
  }
}
