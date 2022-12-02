import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rating_dialog/rating_dialog.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isvisible = false;
  int currentIndex = 0;
  final _dialog = RatingDialog(
    initialRating: 1.0,
    // your app's name?
    title: const Text(
      'Rate your Journey',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
    // encourage your user to leave a high rating?
    message: const Text(
      'Tap a star to set your rating. Add more description here if you want.',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 10),
    ),
    // your app's logo?
    image: Image.asset("assets/logo.png", width: 100, height: 100),
    submitButtonText: 'Submit',
    submitButtonTextStyle: const TextStyle(fontSize: 20),
    starSize: 20,
    onCancelled: () => print('cancelled'),
    onSubmitted: (response) {
      print('rating: ${response.rating}, comment: ${response.comment}');

      // TODO: add your own logic
      if (response.rating < 3.0) {
        // send their comments to your email or anywhere you wish
        // ask the user to contact you instead of leaving a bad review
      } else {
        print("Review App");
      }
    },
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appbar(),
                  calendar(),
                  const SizedBox(height: 30),
                  datalist(),
                  socialpost(),
                ],
              )),
        ),
      ),
    );
  }

  Widget appbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset("assets/logo.png", width: 100, height: 100),
        const CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
              "https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg"),
        )
      ],
    );
  }

  Widget calendar() {
    DateTime date;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Dec, ${currentIndex + 1}"),
        const SizedBox(
          height: 30,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: 31,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isvisible = !_isvisible;
                      currentIndex = index;
                    });
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        color: currentIndex == index
                            ? Colors.blue[900]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${index + 1}",
                          style: TextStyle(
                            fontSize: 18,
                            color: currentIndex == index
                                ? Colors.white
                                : Colors.grey[600],
                          ),
                        ),
                        Text(
                          "Dec",
                          style: TextStyle(
                              color: currentIndex == index
                                  ? Colors.white
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget datalist() {
    return Visibility(
      visible: _isvisible,
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
                    GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible:
                                true, // set to false if you want to force a rating
                            builder: (context) => _dialog,
                          );
                        },
                        child: const Icon(Icons.star,
                            color: Colors.yellow, size: 30)),
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

  Widget socialpost() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 500,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: const [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          "https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg"),
                    ),
                    SizedBox(width: 20),
                    Text("Mohan yadav"),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.network(
                    "https://positiveroutines.com/wp-content/uploads/2018/06/group-of-people-outside-in-woods.jpg"),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Icon(Icons.favorite),
                    SizedBox(width: 10),
                    Icon(Icons.comment),
                    SizedBox(width: 10),
                    Icon(Icons.share)
                  ],
                ),
                const SizedBox(height: 5)
              ],
            );
          }),
    );
  }
}
