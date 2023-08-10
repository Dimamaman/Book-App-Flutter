import 'package:book_app_flutter/detail/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../core/api/book_api.dart';

class Main_Screen extends StatefulWidget {
  const Main_Screen({super.key});

  @override
  State<Main_Screen> createState() => _Main_ScreenState();
}

enum Status { initial, loading, fail, success }

class _Main_ScreenState extends State<Main_Screen> {
  final api = BookApi();
  var list = [];
  var status = Status.initial;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Future<void> _loadData() async {
    status = Status.loading;
    setState(() {});
    try {
      list = await api.getList();
      status = Status.success;
    } catch (e) {
      status = Status.fail;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 12),

              Text(
                'Welcome back, Bunny!',
                style: GoogleFonts.montserrat().copyWith(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                'What do you want to read today?',
                style: GoogleFonts.poppins().copyWith(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Container(
                height: 50,
                width: double.infinity,

                decoration: ShapeDecoration(
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    suffixIcon: Icon(Icons.mic, color: Color(0xFFC4C4C4)),
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search, color: Color(0xFFC4C4C4)),
                    hintStyle: TextStyle(
                      color: Color(0xFFC4C4C4),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Builder(builder: (context) {

                  if (status == Status.loading) {
                    return GridView.builder(
                      itemCount: 4,
                      padding: const EdgeInsets.all(5),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 18.0,
                        mainAxisSpacing: 18.0,
                        childAspectRatio: 2 / 3,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey.withOpacity(0.1),
                                highlightColor: Colors.grey.withOpacity(0.3),
                                child: Container(color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.1),
                              highlightColor: Colors.grey.withOpacity(0.3),
                              child: Container(
                                width: 150,
                                height: 25,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.1),
                              highlightColor: Colors.grey.withOpacity(0.3),
                              child: Container(
                                width: 100,
                                height: 15,
                                color: Colors.white,
                              ),
                            )
                          ],
                        );
                      },
                    );
                  }

                  if (status == Status.fail) {
                    return const Center(
                      child: Text("Xatolik", style: TextStyle(fontSize: 32)),
                    );
                  }

                  return GridView.builder(
                    itemCount: list.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 18.0,
                      mainAxisSpacing: 12.0,
                      childAspectRatio: 0.55,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final model = list[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return DetailScreen(id: model['id']);
                          }));
                        },
                        child: Column(
                          children: [
                            Expanded(
                                child: Container(
                                  width:180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.network(model["image"], fit: BoxFit.cover,),
                                )
                            ),

                            Text(
                              model["name"],
                              style: const TextStyle(
                                  fontSize: 18,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis
                              ),
                              maxLines: 1,
                            ),

                            Text(
                              model["author"],
                              maxLines: 1,
                              style: const TextStyle(fontSize: 14,overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
