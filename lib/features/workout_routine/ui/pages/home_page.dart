import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workout_routine/features/workout_routine/ui/pages/pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showFAB = true;
  String appBarTitle = "Workout Routines";
  IconData addIcon = Icons.add;
  int _page = 0;
  late PageController pageController = PageController(initialPage: _page);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        elevation: 0,
        title: Text(appBarTitle),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (newPage) {
          setState(() {
            _page = newPage;
          });
          switch (newPage) {
            case 0:
              setState(() {
                appBarTitle = "Workout Routines";
                showFAB = true;
              });
              break;
            case 1:
              setState(() {
                appBarTitle =
                    "${DateFormat.EEEE().format(DateTime.now())}'s workout";
                showFAB = false;
              });
              break;
            case 2:
              setState(() {
                appBarTitle = "Report";
                showFAB = false;
              });
              break;
          }
        },
        children: const [
          RoutinesPage(),
          TodaysWorkoutPage(),
          ReportPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        items: const [
          BottomNavigationBarItem(
            label: "ROUTINES",
            icon: Icon(Icons.list_alt_rounded),
          ),
          BottomNavigationBarItem(
            label: "WORKOUT",
            icon: Icon(
              IconData(0xe28d, fontFamily: 'MaterialIcons'),
            ),
          ),
          BottomNavigationBarItem(
            label: "REPORTS",
            icon: Icon(Icons.checklist_rounded),
          ),
        ],
        onTap: (tabIndex) {
          pageController.animateToPage(tabIndex,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        },
      ),
      floatingActionButton: Visibility(
        visible: showFAB,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/add-routine");
          },
          child: Icon(addIcon),
        ),
      ),
    );
  }
}
