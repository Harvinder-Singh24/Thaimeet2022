import 'package:flutter/material.dart';
import 'mainscreen.dart' as main;

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int? currentIndex1;
  int? currentIndex2;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text("Schedule", style: TextStyle(color: Colors.black)),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Colors.indigo[600],
            unselectedLabelColor: Colors.grey[200],
            tabs: const [
              Tab(text: "Present"),
              Tab(text: "Upcoming"),
            ],
          ),
        ),
        body: SafeArea(
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TabBarView(children: [
                datalist(),
                datalist(),
              ])),
        ),
      ),
    );
  }

  Widget datalist() {
    return Visibility(
      visible: true,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 180,
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 2,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return SizedBox(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          "https://www.pocketwanderings.com/wp-content/uploads/2022/04/Six-Senses-Yao-Noi-1440x1028.jpg"),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Lunch at morning",
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            "8:00 Am",
                            style: TextStyle(fontSize: 12),
                          )
                        ]),
                    Column(children: const [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          "https://img.freepik.com/free-icon/google-maps_318-326114.jpg",
                        ),
                      ),
                      Text(
                        "Direction",
                        style: TextStyle(fontSize: 12),
                      )
                    ]),
                  ],
                ));
              })),
    );
  }
}
