import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _defaultPaddingValue = 16.0;

const _backgroundGradientColors = [
  Color(0xFF1b323f),
  Color(0xFFd4dbda),
  Color(0xFF7990bc),
];

const _gradientColors = [
  Color(0xFF90A9DD),
  Color(0xFF827EDA),
];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: _backgroundDecoration(),
            child: Column(
              children: [
                _buildTopBar(),
                SizedBox(height: 70),
                _buildMiddleContent(),
                _buildStatisticBoxes(),
                Spacer(flex: 2),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      unselectedItemColor: Color(0xFF3c3c3c),
      items: [
        _buildNavBarItem(Icons.home, 'Home'),
        _buildNavBarItem(Icons.show_chart, 'Trade'),
        BottomNavigationBarItem(
          icon: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child:
                Image.asset('lib/icons/arrow_2.png', width: 26.0, height: 26.0),
          ),
          label: '',
        ),
        _buildNavBarItem(Icons.view_module, 'Pools'),
        _buildNavBarItem(Icons.person, 'Profile'),
      ],
    );
  }

  BottomNavigationBarItem _buildNavBarItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: _gradientIcon(icon),
      label: label,
    );
  }

  Widget _gradientIcon(IconData data) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: _gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: Icon(data, color: Colors.white),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: _defaultPadding(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCopyWidget(),
          _buildNotificationIcon(),
        ],
      ),
    );
  }

  Widget _buildCopyWidget() {
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: 'Oxf8...b21'));
        _scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: Text('Text copied to clipboard!',
                style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(_scaffoldMessengerKey.currentContext!)
                        .size
                        .height *
                    0.2),
            width: MediaQuery.of(_scaffoldMessengerKey.currentContext!)
                    .size
                    .width *
                0.7,
            shape: RoundedRectangleBorder(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: _copyContainerDecoration(),
        child: Row(
          children: [
            Text('Oxf8...b21', style: TextStyle(color: Colors.white)),
            SizedBox(width: 7),
            Icon(Icons.copy, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationIcon() {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Icon(Icons.notifications, size: 24),
        CircleAvatar(radius: 6, backgroundColor: Colors.orange),
      ],
    );
  }

  Widget _buildMiddleContent() {
    return Column(
      children: [
        Text('\$ 21,937.31',
            style: _middleAmountTextStyle().copyWith(fontSize: 29)),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.show_chart, color: Colors.green, size: 20),
            Text('APY + 7.21', style: TextStyle(fontSize: 14)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatisticBoxes() {
    return Padding(
      padding: _defaultPadding(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: _buildStatisticBox('\$7.27', '/24H')),
          SizedBox(width: 16.0),
          Expanded(child: _buildStatisticBox('\$73.81', '/7D')),
          SizedBox(width: 16.0),
          Expanded(child: _buildStatisticBox('\$2,391.30', '/1Y')),
        ],
      ),
    );
  }

  Widget _buildStatisticBox(String value, String timeFrame) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: _defaultPadding(),
      decoration: _statisticBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: TextStyle(fontSize: 18, color: Colors.white)),
          Text(timeFrame,
              style: TextStyle(color: Colors.white.withOpacity(0.6))),
        ],
      ),
    );
  }

  BoxDecoration _backgroundDecoration() => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: _backgroundGradientColors,
        ),
      );

  EdgeInsets _defaultPadding() => EdgeInsets.all(_defaultPaddingValue);

  BoxDecoration _copyContainerDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black,
      );

  TextStyle _middleAmountTextStyle() => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );

  BoxDecoration _statisticBoxDecoration() => BoxDecoration(
        color: Colors.grey.shade600.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      );
}
