import 'package:flutter/material.dart';
import 'trainingTabs/HistoryTab.dart';
import 'trainingTabs/TrainingTab.dart';
import 'trainingTabs/ExercicesTab.dart';
import 'package:flutter_svg/flutter_svg.dart';


class TrainingHome extends StatefulWidget {
  @override
  _TrainingHomeState createState() => _TrainingHomeState();
}

class _TrainingHomeState extends State<TrainingHome> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index=1; // defaults to Training tab on load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.black,
        backgroundColor: const Color(0xFF1B1B1B),
        title: SvgPicture.asset('assets/AthletiX.svg'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(child:
              Text('History',
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ),
            Tab(child:
              Text('Training',
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ),
            Tab(child:
              Text('Exercises',
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                HistoryTab(),
                TrainingTab(),
                ExercicesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
