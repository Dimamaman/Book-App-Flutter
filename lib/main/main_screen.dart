import 'package:book_app_flutter/freezed/book_bloc.dart';
import 'package:book_app_flutter/detail/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:book_app_flutter/pref/book_pref.dart';

import '../core/api/book_api.dart';

class Main_Screen extends StatefulWidget {
  Main_Screen({super.key});

  Color myColor = Color(0xFFFFFFFF);

  @override
  State<Main_Screen> createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Main_Screen> {
  final pref = BookPRef();

  final bloc = BookBloc(BookApi());

  bool _iconBool = false;

  final _searchController = TextEditingController();

  var searchValue = "";

  @override
  void initState() {

    bloc.add(BookEvent.loadData());

    _searchController.addListener(() {
      searchValue = _searchController.text.toString();
      bloc.add(BookEvent.loadData(searchValue: searchValue));
    });

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    bloc.close();
    super.dispose();
  }

  ThemeData _lightTheme =
  ThemeData(primarySwatch: Colors.blueGrey, brightness: Brightness.light);

  ThemeData _darkTheme =
  ThemeData(primarySwatch: Colors.grey, brightness: Brightness.dark);
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
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
                    height: 45,
                    width: double.infinity,
                    decoration: ShapeDecoration(
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: TextField(
                      controller: _searchController,
                      focusNode: _focusNode,
                      // onEditingComplete: () {
                      //   context.read<BookProvider>().loadData(searchValue);
                      // },
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.grey,
                            )
                        )
                            : null,
                        hintText: 'Book name or author...',
                        prefixIcon: const Icon(Icons.search, color: Color(
                            0xFFC4C4C4)),
                        hintStyle: const TextStyle(
                          color: Color(0xFFC4C4C4),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Builder(builder: (context) {
                      if (state.status == EnumStatus.loading) {
                        return GridView.builder(
                          itemCount: 4,
                          padding: const EdgeInsets.all(5),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                                    highlightColor: Colors.grey.withOpacity(
                                        0.3),
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

                      if (state.error.isNotEmpty) {
                        return const Center(
                          child: Text(
                              "Xatolik", style: TextStyle(fontSize: 32)),
                        );
                      }

                      if (state.list.isEmpty) {
                        return const Center(
                          child: Text("Kitob topilmadi",
                              style: TextStyle(fontSize: 22)),
                        );
                      }

                      return GridView.builder(
                        itemCount: state.list.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 18.0,
                          mainAxisSpacing: 12.0,
                          childAspectRatio: 0.55,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final model = state.list[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return DetailScreen(id: model.id);
                                  }));
                              _focusNode.unfocus();
                              // _searchController.dispose();
                            },
                            child: Column(
                              children: [
                                Expanded(
                                    child: Container(
                                      width: 180,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              10)),
                                      clipBehavior: Clip.antiAlias,
                                      child: Image.network(
                                        model.image,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                Text(
                                  model.name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis),
                                  maxLines: 1,
                                ),
                                Text(
                                  model.author,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis),
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
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Image.asset('assets/images/drawer_icon.jpeg')),
                ListTile(
                  leading: Icon(Icons.nights_stay),
                  title: Text('Dark Mode'),
                  onTap: () {
                    _iconBool = true;
                    pref.setMode(true);
                    setState(() {});
                    // Scaffold.of(context).openEndDrawer();
                    // Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text('Light Mode'),
                  onTap: () {
                    _iconBool = false;
                    pref.setMode(true);
                    setState(() {});
                    // Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
