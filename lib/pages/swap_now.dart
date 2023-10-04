import 'package:flutter/material.dart';

class SwapNowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        title: Text('Swap', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 1.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.settings, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _cryptoCard('BNB', '+6.21%', '21.917'),
              SizedBox(height: 20.0),
              _cryptoCard('ETH', '+11.23%', '1.243'),
              SizedBox(height: 40.0),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown("BNB"),
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: _buildDropdown("ETH"),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              _buildDropdown("WalletConnect"),
              SizedBox(height: 20.0),
              _buildRateBox(),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Implement swap logic here
                },
                child: Text('Swap now'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple, // Color based on your design
                  padding: EdgeInsets.symmetric(vertical: 20),
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cryptoCard(String title, String percentage, String value) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.grey[300], // Use a more appropriate color or a gradient
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              Text(percentage,
                  style: TextStyle(
                      color: (percentage.contains('+')
                          ? Colors.green
                          : Colors.red))),
            ],
          ),
          SizedBox(height: 10.0),
          Text(value,
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildDropdown(String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildRateBox() {
    return Container(
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Use a more appropriate color
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
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
