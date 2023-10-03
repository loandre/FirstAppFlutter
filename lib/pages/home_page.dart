import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _defaultPaddingValue = 16.0;

const _backgroundGradientColors = [
  Color(0xFF1b323f),
  Color(0xFFd4dbda),
  Color(0xFF7990bc),
];
const _backgroundGradientStops = [0.0, 0.8, 1.0];

const _gradientColors = [
  Color(0xFF90A9DD),
  Color(0xFF827EDA),
];

class MyHomePage extends StatefulWidget {
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
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: _backgroundDecoration(),
                child: Column(
                  children: [
                    _buildTopBar(),
                    SizedBox(height: 70),
                    _buildMiddleContent(),
                    _buildStatisticBoxes(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            _buildPortfolio(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    ),
  );
}


  Widget _buildPortfolio() {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.all(_defaultPaddingValue),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Portfolio',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Icon(Icons.more_vert, size: 28),
            ],
          ),
          SizedBox(height: 15),
          ..._buildPortfolioItems(),
        ],
      ),
    );
  }

  List<Widget> _buildPortfolioItems() {
    final iconPaths = [
      'lib/icons/ltc-litecoin.png',
      'lib/icons/bnb-binancecoin.png',
      'lib/icons/eth-ethereum.png',
      'lib/icons/link-chainlink.png'
    ];
    final titles = ['LTC', 'BNB', 'ETH', 'LINK'];
    final subtitles = ['Litecoin', 'Binance Coin', 'Ethereum', 'Chainlink'];
    final values = ['23.21', '45.12', '1,200.43', '30.05'];
    final details = [
      '1,571.5 USD (+1.9%)',
      '1,114.29 USD (+4.8%)',
      '17,437.56 USD (+2.1%)',
      '493.21 USD (+0.3%)'
    ];

    List<Widget> portfolioItems = [];
    for (int i = 0; i < titles.length; i++) {
      portfolioItems.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Image.asset(iconPaths[i], width: 40, height: 40),
              SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titles[i],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 2.0),
                    Text(subtitles[i],
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(values[i],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 2.0),
                  Text(details[i],
                      style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                ],
              ),
              SizedBox(width: 8.0),
            ],
          ),
        ),
      );
      if (i != titles.length - 1) {
        portfolioItems.add(Divider(color: Colors.grey[300]));
      }
    }
    return portfolioItems;
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
      padding: EdgeInsets.fromLTRB(
        _defaultPaddingValue,
        55.0,
        _defaultPaddingValue,
        0.0,
      ),
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
        Icon(Icons.notifications, size: 24, color: Colors.white),
        CircleAvatar(radius: 6, backgroundColor: Colors.orange),
      ],
    );
  }

  Widget _buildMiddleContent() {
    return Column(
      children: [
        Text('\$ 21,937.31',
            style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Image.asset('lib/icons/show_chart.png', width: 20, height: 20, color: Colors.green),
    SizedBox(width: 5),
    Text('APY + 7.21', style: TextStyle(fontSize: 14)),
  ],
),
      ],
    );
  }

  Widget _buildStatisticBoxes() {
    return Padding(
      padding: EdgeInsets.all(_defaultPaddingValue),
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
      padding: EdgeInsets.all(_defaultPaddingValue),
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

  BoxDecoration _backgroundDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: _backgroundGradientColors,
      ),
    );
  }

  BoxDecoration _copyContainerDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.black,
    );
  }

  BoxDecoration _statisticBoxDecoration() {
    return BoxDecoration(
      color: Colors.grey.shade800.withOpacity(0.5),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
