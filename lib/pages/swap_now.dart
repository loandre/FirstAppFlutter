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
  fontSize: 24.0,
  color: Colors.white,
);

// ------------------- MAIN WIDGET -------------------
class SwapNowPage extends StatelessWidget {
  const SwapNowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

// ------------------- INTERFACE METHODS -------------------
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: Colors.white,
      title: const Text('Swap', style: TextStyle(color: Colors.black)),
      centerTitle: true,
      elevation: 1.0,
      actions: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.settings_outlined, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCryptoRow(),
            const SizedBox(height: 40.0),
            _buildDropdownRow(),
            const SizedBox(height: 20.0),
            _buildWalletDropdown(),
            const SizedBox(height: 20.0),
            _buildRateBox(),
            const SizedBox(height: 20.0),
            _buildSwapButton(),
          ],
        ),
      ),
    );
  }

  Row _buildCryptoRow() {
    return Row(
      children: [
        Expanded(child: _cryptoCard('BNB', '+6.21%', '21.917')),
        const SizedBox(width: 20.0),
        Expanded(child: _cryptoCard('ETH', '+11.23%', '1.243')),
      ],
    );
  }

  Row _buildDropdownRow() {
    return Row(
      children: [
        Expanded(child: _buildDropdown("BNB")),
        const SizedBox(width: 20.0),
        Expanded(child: _buildDropdown("ETH")),
      ],
    );
  }

  Widget _buildWalletDropdown() {
    return SizedBox(
      width: double.infinity,
      child: _buildDropdown("WalletConnect"),
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
        Image.asset('lib/icons/arrow_3.png', height: 24.0),
        const SizedBox(width: 8.0),
        const Text('Swap now', style: _buttonTextStyle),
      ],
    );
  }

// ------------------- HELPER METHODS -------------------

  Widget _cryptoCard(String title, String percentage, String value) {
    const titleStyle = TextStyle(
      fontSize: 20.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    const valueStyle = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    final percentageColor =
        percentage.contains('+') ? Colors.green : Colors.red;
    final percentageStyle = TextStyle(color: percentageColor, fontSize: 16.0);

    final cardDecoration = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.blueGrey[700]!, Colors.black],
      ),
      borderRadius: BorderRadius.circular(20.0),
    );

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleAndPercentageRow(
              title, titleStyle, percentage, percentageStyle),
          const SizedBox(height: 10.0),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }

  Row _buildTitleAndPercentageRow(String title, TextStyle titleStyle,
      String percentage, TextStyle percentageStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: titleStyle),
        Text(percentage, style: percentageStyle),
      ],
    );
  }

  Widget _buildDropdown(String value) {
    return Container(
      height: 60.0,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          onChanged: (newValue) {
            // Handle change
          },
          items: ["BNB", "ETH", "WalletConnect"]
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  _getIconForValue(value),
                  const SizedBox(width: 10.0),
                  Text(value),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _getIconForValue(String value) {
    String assetName;
    switch (value) {
      case "BNB":
        assetName = 'lib/icons/bnb-binancecoin-bw.png';
        break;
      case "ETH":
        assetName = 'lib/icons/eth-ethereum-bw.png';
        break;
      case "WalletConnect":
        assetName = 'lib/icons/wallet-connect.png';
        break;
      default:
        return const SizedBox.shrink();
    }

    return Image.asset(assetName, height: 16.0, fit: BoxFit.contain);
  }

  Widget _buildRateBox() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Use a more appropriate color
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Rate",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 10.0),
          Text("6.75722 BNB = 1 ETH"),
          SizedBox(height: 10.0),
          Text("Slippage Tolerance", style: TextStyle(color: Colors.grey)),
          SizedBox(height: 5.0),
          Text("0.5%"),
          SizedBox(height: 10.0),
          Text("Liquidity Provider Fee", style: TextStyle(color: Colors.grey)),
          SizedBox(height: 5.0),
          Text("0.02802 BNB"),
        ],
      ),
    );
  }
}
