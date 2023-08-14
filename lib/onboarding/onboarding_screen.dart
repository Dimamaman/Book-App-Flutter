import 'package:book_app_flutter/boardModel/board_model.dart';
import 'package:book_app_flutter/constants/constants.dart';
import 'package:book_app_flutter/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding_Screen extends StatefulWidget {
  const OnBoarding_Screen({super.key});

  @override
  State<OnBoarding_Screen> createState() => _OnBoarding_ScreenState();
}

class _OnBoarding_ScreenState extends State<OnBoarding_Screen> {
  final controller = PageController();
  var index = 0.0;
  SharedPreferences?  prefs;

  Future<void> load() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    load();
    controller.addListener(() {
      index = controller.page!;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: 3,
                itemBuilder: (_, index) {
                  return _buildBoardImage(Constants.boardList[index]);
                },
              ),
            ),


          Row(
            children: [
              SizedBox(width: index.round() >= 1.5 ? 87 : 50),

              GestureDetector(
                onTap: () {
                  prefs?.setBool("isOpened", false);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Main_Screen()));
                },
                child: Text(
                  index >= 1.5 ? "" : 'Skip',
                  style: const TextStyle(
                    color: Color(0xFFA5A5A5),
                    fontSize: 17,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: Center(
                  child: SizedBox(
                    height: 6,
                    child: ListView.separated(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      separatorBuilder: (__, _) => const SizedBox(width: 10),
                      itemBuilder: (_, i) {
                        return Container(
                          width: 15,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: i == index.round()
                                ? const Color(0xFFFF8F51)
                                : const Color(0xFFDCDFE3),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  if(index == 2) {
                    prefs?.setBool("isOpened", false);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Main_Screen()));
                  } else {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
                  }
                },
                child: Container(
                  width: 87,
                  height: 37,
                  padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 8),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD45555),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child:  Text(
                    index >= 1.5 ? "Start" : 'Next',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 30),
            ],
          ),
              const SizedBox(height: 60)
        ]),
      ),
    );
  }
}

Widget _buildBoardImage(BoardModel boardModel) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(boardModel.image),
      const SizedBox(height: 20.0),
      Text(
        boardModel.title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 20.0),
      SizedBox(
        width: 307,
        height: 96,
        child: Opacity(
          opacity: 0.50,
          child: Text(
            boardModel.desc,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: 'RobotoSerif',
              fontWeight: FontWeight.w400,
              height: 1.60,
            ),
          ),
        ),
      )
    ],
  );
}

Future<void> _saveFirstOpened() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isOpened', false);
  print("Saqlandi -> ${prefs.getBool('isOpened')}");
}
