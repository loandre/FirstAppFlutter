import 'package:flutter/material.dart';

// ------------------- CONSTANTS -------------------
final _buttonDecoration = BoxDecoration(
  gradient: const LinearGradient(
    colors: [Color(0xFF90A9DD), Color(0xFF827EDA)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  borderRadius: BorderRadius.circular(10.0),
);

const _buttonTextStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.w500,
  letterSpacing: -0.7,
  color: Colors.white,
);

const _rateTextStyle = TextStyle(
  fontSize: 16,
  color: Colors.black,
);

const _boldRateTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

// ------------------- MAIN WIDGET -------------------
class SwapNowPage extends StatelessWidget {
  const SwapNowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(),
      body: _buildBody(),
    );
  }
}

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      leading: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      title: const Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Text('Swap', style: TextStyle(color: Colors.black)),
      ),
      centerTitle: true,
      elevation: 0.0,
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 8.0, top: 10.0),
          child: Icon(Icons.settings_outlined, color: Colors.black),
        ),
      ],
    );
  }
}

class CryptoBox extends StatelessWidget {
  final String cryptoName;
  final String percentageChange;
  final String value;
  final Color boxColor;
  final Color textColor;
  final String? backgroundImagePath;

  const CryptoBox({
    Key? key,
    required this.cryptoName,
    required this.percentageChange,
    required this.value,
    required this.boxColor,
    required this.textColor,
    this.backgroundImagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(10),
        image: backgroundImagePath != null
            ? DecorationImage(
                image: AssetImage(backgroundImagePath!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cryptoName,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                percentageChange,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class SendReceiveWidget extends StatelessWidget {
  final String label;
  final String amount;

  const SendReceiveWidget({
    Key? key,
    required this.label,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF5e5e5e),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          amount,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class SelectionBox extends StatelessWidget {
  final String label;
  final String iconPath;

  const SelectionBox({
    Key? key,
    required this.label,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(iconPath, height: 24.0),
              const SizedBox(width: 10),
              Text(label, style: const TextStyle(fontSize: 16)),
            ],
          ),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

// ------------------- INTERFACE METHODS -------------------
Widget _buildBody() {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10.0),
          const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CryptoBox(
                      cryptoName: "BNB",
                      percentageChange: "+6.21%",
                      value: "21.917",
                      boxColor: Color(0xFF17232F),
                      textColor: Colors.white,
                      backgroundImagePath: 'lib/icons/bnb_2.png',
                    ),
                    SizedBox(height: 25),
                    SendReceiveWidget(
                      label: "You Send",
                      amount: "12.121",
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CryptoBox(
                      cryptoName: "ETH",
                      percentageChange: "+11.23%",
                      value: "1.243",
                      boxColor: Color(0xFFD8E1F1),
                      textColor: Colors.black,
                      backgroundImagePath: 'lib/icons/eth_2.png',
                    ),
                    SizedBox(height: 20),
                    SendReceiveWidget(
                      label: "You Receive",
                      amount: "1.79067",
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25.0),
          const Row(
            children: [
              Expanded(
                child: SelectionBox(
                  label: "BNB",
                  iconPath: "lib/icons/bnb-binancecoin-bw.png",
                ),
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: SelectionBox(
                  label: "ETH",
                  iconPath: "lib/icons/eth-ethereum-bw.png",
                ),
              ),
            ],
          ),
          const SizedBox(height: 25.0),
          const SelectionBox(
            label: "WalletConnect",
            iconPath: "lib/icons/wallet-connect.png",
          ),
          const SizedBox(height: 35.0),
          _buildRateBox(),
          const SizedBox(height: 35.0),
          _buildSwapButton(),
        ],
      ),
    ),
  );
}

Container _buildSwapButton() {
  return Container(
    decoration: _buttonDecoration,
    child: TextButton(
      onPressed: () {
        // Implement swap logic here
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: _buildSwapButtonContent(),
    ),
  );
}

Row _buildSwapButtonContent() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset('lib/icons/arrow_3.png', height: 25.0),
      const SizedBox(width: 8.0),
      const Text('Swap now', style: _buttonTextStyle),
    ],
  );
}

Widget _buildRateBox() {
  return Container(
    padding: const EdgeInsets.all(15.0),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      children: [
        _buildRateRow("Rate", "6.75722 BNB = 1 ETH", bold: true),
        const SizedBox(height: 25.0),
        _buildRateRow("Slippage Tolerance", "0.5%"),
        const SizedBox(height: 25.0),
        _buildRateRow("Liquidity Provider Fee", "0.02802 BNB"),
      ],
    ),
  );
}

Row _buildRateRow(String leftText, String rightText, {bool bold = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        leftText,
        style: bold ? _boldRateTextStyle : _rateTextStyle,
      ),
      Text(rightText),
    ],
  );
}
