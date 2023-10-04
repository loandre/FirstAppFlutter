import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'home_page.dart';

// ------------------- MAIN WIDGET -------------------
class GetStartedPage extends StatelessWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCreditCardImage(),
            _buildTitleWithStarIcon(),
            _buildGetStartedButton(context),
          ],
        ),
      ),
    );
  }

// ------------------- WIDGET BUILDING METHODS -------------------
  Widget _buildCreditCardImage() {
    return Container(
      margin: _imageMargin,
      child: Center(
        child: Image.asset(
          'lib/images/credit-card.png',
          errorBuilder: (context, error, stackTrace) {
            return const Text('Failed to load image');
          },
        ),
      ),
    );
  }

  Widget _buildTitleWithStarIcon() {
    return Stack(
      children: [
        const Padding(
          padding: _titlePadding,
          child: AutoSizeText(
            'Manage your\ncrypto assets,\nsimply',
            textAlign: TextAlign.left,
            style: _titleStyle,
            maxLines: 3,
            minFontSize: 20,
          ),
        ),
        Positioned(
          top: 50.0,
          left: 245.0,
          child: Image.asset('lib/icons/star.png', width: 26.0, height: 26.0),
        ),
      ],
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return Padding(
      padding: _buttonPadding,
      child: ElevatedButton(
        onPressed: () => _navigateToHomePage(context),
        style: _buttonStyle,
        child: Container(
          decoration: _buttonDecoration,
          alignment: Alignment.center,
          constraints: const BoxConstraints(minHeight: 70.0),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: _buildButtonContent(),
        ),
      ),
    );
  }

  Widget _buildButtonContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AutoSizeText(
                'Get started',
                style: _buttonTextStyle,
                maxLines: 1,
                minFontSize: 18,
              ),
              const SizedBox(width: 9.0),
              Center(
                child: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: Image.asset('lib/icons/arrow_1.png'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _navigateToHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }

// ------------------- STYLE AND LAYOUT CONSTANTS -------------------
  static const _backgroundColor = Color(0xFF000E17);
  static const _imageMargin =
      EdgeInsets.only(top: 65.0, left: 20.0, right: 20.0);
  static const _titlePadding =
      EdgeInsets.only(left: 29.0, right: 16.0, top: 46.0);
  static const _titleStyle = TextStyle(
    fontSize: 36.0,
    height: 1.2,
    letterSpacing: -4.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Courier',
    color: Colors.white,
  );
  static const _buttonPadding =
      EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0);
  static final _buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
  static final _buttonDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: [Color(0xFF90A9DD), Color(0xFF827EDA)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    borderRadius: BorderRadius.circular(10.0),
  );
  static const _buttonTextStyle = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Courier',
    letterSpacing: -3.0,
    color: Colors.white,
  );
}
