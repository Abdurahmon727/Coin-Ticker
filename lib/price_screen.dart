import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      int r1 = await getRate('BTC', currentCurrency);
      int r2 = await getRate('ETH', currentCurrency);
      int r3 = await getRate('LTC', currentCurrency);
      setState(() {
        currentRateBTC = r1;
        currentRateETH = r2;
        currentRateLTC = r3;
      });
    });
  }

  //making list
  List<DropdownMenuItem> listOfItems() {
    List<DropdownMenuItem<String>> dropDownList = [];
    for (String part in currenciesList) {
      var item = DropdownMenuItem(child: Text(part), value: part);
      dropDownList.add(item);
    }
    return dropDownList;
  }

  List<Text> listOfCupertinoItems() {
    List<Text> all = [];
    for (String part in currenciesList) {
      all.add(Text(part));
    }
    return all;
  }

//making rigjt button
  DropdownButton<String> isAndroid() {
    return DropdownButton<String>(
      dropdownColor: Colors.blue,
      menuMaxHeight: 150,
      value: currentCurrency,
      items: listOfItems(),
      onChanged: (value) async {
        setState(() {
          currentRateBTC = 0;
          currentRateETH = 0;
          currentRateLTC = 0;
        });
        int r1 = await getRate('BTC', value);
        int r2 = await getRate('ETH', value);
        int r3 = await getRate('LTC', value);
        setState(() {
          currentRateBTC = r1;
          currentRateETH = r2;
          currentRateLTC = r3;
          currentCurrency = value;
        });
      },
    );
  }

  CupertinoPicker isIOS() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 30,
      onSelectedItemChanged: (selectedIndex) async {
        setState(() {
          currentRateBTC = 0;
          currentRateETH = 0;
          currentRateLTC = 0;
        });
        int r1 = await getRate('BTC', currenciesList[selectedIndex]);
        int r2 = await getRate('ETH', currenciesList[selectedIndex]);
        int r3 = await getRate('LTC', currenciesList[selectedIndex]);
        setState(() {
          currentRateBTC = r1;
          currentRateETH = r2;
          currentRateLTC = r3;
          currentCurrency = currenciesList[selectedIndex];
        });
      },
      children: listOfCupertinoItems(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $currentRateBTC $currentCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $currentRateETH $currentCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = $currentRateLTC $currentCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
              height: 100.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? isIOS() : isAndroid()),
        ],
      ),
    );
  }
}
