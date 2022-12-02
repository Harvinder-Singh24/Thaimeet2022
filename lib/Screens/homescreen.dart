import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thaimeet/Screens/inappscreens/contactusscreen.dart';
import 'package:thaimeet/Screens/inappscreens/feedbackscreen.dart';
import 'package:thaimeet/Screens/inappscreens/schedulescreen.dart';
import 'inappscreens/mainscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selectedPageIndex;
  late List<Widget> _pages;
  late PageController _pageController;

  @override
  void initState() {
    _selectedPageIndex = 0;
    _pages = [
      //The individual tabs.
      MainScreen(),
      const ScheduleScreen(),
      FeedbackScreen(),
      const ContactUs(),
    ];

    _pageController = PageController(initialPage: _selectedPageIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                _selectedPageIndex = index;
                _pageController.jumpToPage(_selectedPageIndex);
              });
            },
            currentIndex: _selectedPageIndex,
            elevation: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.indigo[600],
            selectedIconTheme: IconThemeData(color: Colors.indigo[600]),
            unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
            items: const [
              BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: "Schedule", icon: Icon(Icons.calendar_month)),
              BottomNavigationBarItem(
                  label: "Feedback", icon: Icon(Icons.feedback_rounded)),
              BottomNavigationBarItem(
                  label: "Contact Us",
                  icon: Icon(Icons.perm_contact_calendar_rounded))
            ]),
        body: WillPopScope(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: _pages,
          ),
          onWillPop: () {
            SystemNavigator.pop();
            throw "Cannot Back";
          },
        ));
  }
}
