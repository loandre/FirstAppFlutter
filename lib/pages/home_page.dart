import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'swap_now.dart';

// ------------------- CONSTANTS -------------------
const _defaultPaddingValue = 16.0;
const _backgroundGradientColors = [
  Color(0xFF153435),
  Color(0xFF1e484a),
  Color(0xFFc7e3f2),
  Color(0xFFeff6fa),
  Color(0xFF607499),
  Color(0xFF596d94),
];
const backgroundGradientStops = [0.0, 0.2, 0.3, 0.4, 0.6, 1.0];
const _gradientColors = [
  Color(0xFF90A9DD),
  Color(0xFF827EDA),
];

// ------------------- MAIN WIDGET -------------------
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  int _currentIndex = 0;

  Shader _gradientTextShader() {
    return const LinearGradient(
      colors: _gradientColors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  }

  Widget _gradientIcon(IconData data) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors: _gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: Icon(data, color: Colors.white),
    );
  }

  Widget _gradientImage(String imagePath) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors: _gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: Image.asset(imagePath, color: Colors.white, width: 24, height: 24),
    );
  }

  // ------------------- INTERFACE METHODS -------------------

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _buildBody(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: _backgroundDecoration(),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            child: Column(
              children: [
                _buildTopBar(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                _buildMiddleContent(),
                _buildStatisticBoxes(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              ],
            ),
          ),
          Flexible(child: _buildPortfolio()),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        _defaultPaddingValue,
        54.0,
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

  Widget _buildMiddleContent() {
    return Column(
      children: [
        const Text('\$ 21,937.31',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/icons/show_chart.png',
              width: 20,
              height: 20,
              color: const Color(0xFF103611),
            ),
            const SizedBox(width: 5),
            const Text('APY + 7.21',
                style: TextStyle(fontSize: 14, color: Color(0xFF103611))),
          ],
        ),
      ],
    );
  }

  Widget _buildStatisticBoxes() {
    return Padding(
      padding: const EdgeInsets.all(_defaultPaddingValue),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: _buildStatisticBox('\$7.27', '/24H')),
          const SizedBox(width: 16.0),
          Expanded(child: _buildStatisticBox('\$73.81', '/7D')),
          const SizedBox(width: 16.0),
          Expanded(child: _buildStatisticBox('\$2,391.30', '/1Y')),
        ],
      ),
    );
  }

  Widget _buildPortfolio() {
    return Container(
      padding: const EdgeInsets.all(_defaultPaddingValue),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 30),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Portfolio',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Icon(Icons.more_vert, size: 28),
            ],
          ),
          const SizedBox(height: 15),
          Expanded(child: ListView(children: _buildPortfolioItems())),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFFf2f5f8),
      currentIndex: _currentIndex,
      onTap: (index) {
        if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SwapNowPage()),
          );
        } else {
          setState(() => _currentIndex = index);
        }
      },
      unselectedItemColor: const Color(0xFF3c3c3c),
      selectedItemColor: const Color(0xFF3c3c3c),
      selectedLabelStyle: TextStyle(
        foreground: Paint()..shader = _gradientTextShader(),
      ),
      unselectedLabelStyle: const TextStyle(color: Color(0xFF3c3c3c)),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: [
        _buildNavBarItem(iconData: Icons.home_filled, label: 'Home'),
        _buildNavBarItem(
            imagePath: 'lib/icons/show_chart_nav.png', label: 'Trade'),
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
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
        _buildNavBarItem(imagePath: 'lib/icons/pool_icon.png', label: 'Pools'),
        _buildNavBarItem(
            iconData: Icons.person_outline_rounded, label: 'Profile'),
      ],
    );
  }

  // ------------------- INTERFACE METHODS -------------------

  List<Widget> _buildPortfolioItems() {
    final iconPaths = [
      'lib/icons/ltc-litecoin.png',
      'lib/icons/bnb-binancecoin.png',
      'lib/icons/eth-ethereum.png',
      'lib/icons/link-chainlink.png'
    ];
    final titles = ['LTC', 'BNB', 'ETH', 'LINK'];
    final subtitles = ['Litecoin', 'Binance Coin', 'Ethereum', 'Chainlink'];
    final values = ['23.21', '3.5', '9.14', '65.5'];
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
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Image.asset(iconPaths[i], width: 40, height: 40),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titles[i],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19)),
                    const SizedBox(height: 2.0),
                    Text(subtitles[i],
                        style: const TextStyle(
                            color: Color(0xFF282828), fontSize: 14)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(values[i],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 19)),
                  const SizedBox(height: 2.0),
                  Text(details[i],
                      style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                ],
              ),
              const SizedBox(width: 8.0),
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

  Widget _buildStatisticBox(String value, String timeFrame) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(_defaultPaddingValue),
      decoration: _statisticBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.white),
            maxLines: 1,
          ),
          Text(timeFrame,
              style: TextStyle(color: Colors.white.withOpacity(0.6))),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavBarItem(
      {IconData? iconData, String? imagePath, required String label}) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: iconData != null
            ? Icon(iconData)
            : Image.asset(imagePath!, width: 24, height: 24),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: iconData != null
            ? _gradientIcon(iconData)
            : _gradientImage(imagePath!),
      ),
      label: label,
    );
  }

  Widget _buildCopyWidget() {
    return InkWell(
      onTap: () {
        Clipboard.setData(const ClipboardData(text: 'Oxf8...b21'));
        _scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: const Text('Text copied to clipboard!',
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
            shape: const RoundedRectangleBorder(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: _copyContainerDecoration(),
        child: const Row(
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
    return const Stack(
      alignment: Alignment.topRight,
      children: [
        Icon(Icons.notifications_none_rounded, size: 24, color: Colors.white),
        CircleAvatar(radius: 5.5, backgroundColor: Colors.orange),
      ],
    );
  }

  // ------------------- INTERFACE METHODS -------------------

  BoxDecoration _backgroundDecoration() {
    return const BoxDecoration(
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
      color: Colors.grey.shade800.withOpacity(0.6),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
