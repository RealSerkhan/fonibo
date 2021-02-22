import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fonibo/back/fonibo_api.dart';
import 'package:fonibo/bloc/fonibo_bloc.dart';
import 'package:fonibo/models/Fonibo.dart';
import 'package:supercharged/supercharged.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Size _size;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FoniboApi _controller;
  List<Color> _colors = [
    "#FFDEDE".toColor(),
    "#5BB1FF".toColor().withOpacity(0.35),
    "#B1F8C1".toColor(),
    "#FEDEFF".toColor()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = FoniboApi();
  }

  @override
  Widget build(BuildContext context) {
    final foniboBloc = BlocProvider.of<FoniboBloc>(context);
    foniboBloc.add(FetchFoniboData());
    _size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          size: 36,
          color: "#0176E1".toColor(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return refreshData();
        },
        child: SafeArea(
          child: Container(
            height: _size.height,
            width: _size.width,
            child: Padding(
              padding: EdgeInsets.all(_size.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appBar(),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: _size.height * 0.025),
                    child: Text(
                      "Tasks",
                      style: TextStyle(
                          color: "#333232".toColor(),
                          fontSize: 16,
                          fontFamily: "RobotoMed",
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  BlocBuilder<FoniboBloc, FoniboState>(
                    builder: (context, state) {
                      if (state is FoniboLoadingState) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is FoniboLoadedState) {
                        return ListView(
                            shrinkWrap: true,
                            children: state.foniboList
                                .mapIndexed((currentValue, index) =>
                                    listContainer(index, currentValue))
                                .toList());
                      } else {
                        return Text("error");
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  //
  // FutureBuilder<List<Fonibo>>(
  // future: _controller.getData(),
  // builder: (context, AsyncSnapshot<List<Fonibo>> snapshot) {
  // if (snapshot.hasData) {
  // return ListView(
  // shrinkWrap: true,
  // children: snapshot.data
  //     .mapIndexed((currentValue, index) =>
  // listContainer(index, currentValue))
  //     .toList());
  // } else {
  // return Center(child: CircularProgressIndicator());
  // }
  // },
  // )

  Container listContainer(index, Fonibo fonibo) {
    List<String> split = fonibo.createdAt.split("-");
    List<String> day = split[2].split("T");
    return Container(
      height: _size.height * 0.1,
      width: _size.width,
      padding: EdgeInsets.only(bottom: _size.height * 0.01),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: _size.width * 0.015),
            child: Container(
              height: _size.height * 0.1,
              width: _size.width * 0.025,
              decoration: BoxDecoration(
                  color: _colors[index],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: _size.width * 0.05),
                width: _size.width * 0.6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: "#F8F8F8".toColor()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          fonibo.title,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: "RobotoMed"),
                        ),
                        Text(
                          DateTime(split[0].toInt(), split[1].toInt(),
                                  day[0].toInt())
                              .toString()
                              .split(" ")
                              .first,
                          style: TextStyle(
                              color: "#4E4E4E".toColor(),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "RobotoMed"),
                        )
                      ],
                    ),
                    Container(
                      width: _size.width * 0.05,
                      decoration: BoxDecoration(
                          color: "#F8F8F8".toColor(),
                          border:
                              Border.all(color: "#0176E1".toColor(), width: 2),
                          borderRadius: BorderRadius.circular(30)),
                      height: _size.width * 0.05,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget appBar() {
    return Container(
      width: _size.width / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                if (_scaffoldKey.currentState.isDrawerOpen) {
                  _scaffoldKey.currentState.openEndDrawer();
                } else {
                  _scaffoldKey.currentState.openDrawer();
                }
              },
              child: Container(child: Image.asset("assets/images/drawer.png"))),
          Center(
            child: Text(
              "task.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: "#0176E1".toColor(),
                  fontFamily: "RobotoMed",
                  fontSize: 22,
                  fontWeight: FontWeight.w900),
            ),
          )
        ],
      ),
    );
  }

  Future<void> refreshData() async {
    await context.read<FoniboBloc>().add(RefresFoniboData());
  }
}
