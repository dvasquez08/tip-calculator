import 'package:flutter/material.dart';
import 'components.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class TipCalculatorScreen extends StatefulWidget {
  const TipCalculatorScreen({Key? key}) : super(key: key);

  @override
  State<TipCalculatorScreen> createState() => _TipCalculatorScreenState();
}

class _TipCalculatorScreenState extends State<TipCalculatorScreen> {
  double billAmount = 0.0;
  double tipPercentage = 0.1;
  int numberOfPeople = 1;
  bool roundUp = false;

  String amountPerPersonText = '';
  String roundedAmountText = '';

  @override
  void initState() {
    super.initState();
    initBannerAds();
  }

  late BannerAd topBannerAd;
  late BannerAd bottomBannerAd;
  bool isAdloaded = false;
  var adUnit = 'ca-app-pub-3940256099942544~3347511713'; // Testing Ad ID

  // ===== Initializing Google Ads =====

  initBannerAds() {
    topBannerAd = createBannerAd();
    bottomBannerAd = createBannerAd();

    topBannerAd.load();
    bottomBannerAd.load();
  }

  BannerAd createBannerAd() {
    return BannerAd(
      size: AdSize.banner,
      adUnitId: adUnit,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isAdloaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    );
  }

  // ===== End of Google ads initialization =====

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0XFF005f73),
          centerTitle: true,
          title: const SansText('Tip Calculator', 30.0),
        ),

        // Beginning of app content. This container adds the background image to the screen

        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover)),
          child: ListView(
            children: [
              const SizedBox(height: 20.0),
              // ===== Top ad banner =====
              SizedBox(
                height: topBannerAd.size.height.toDouble(),
                width: topBannerAd.size.height.toDouble(),
                child: AdWidget(ad: topBannerAd),
              ),

              // ===== Beginning of main tip calculator =====

              Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 0, 0, 0.5),
                    borderRadius: BorderRadius.circular(20.0)),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
                margin:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ===== Section where user enters the bill amount =====

                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          billAmount = double.parse(value);
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter bill amount here:',
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 20.0),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 25.0),
                    ),

                    // ===== End of user bill amount section =====

                    // ==== Beginning of tip percentage slider =====

                    const SizedBox(height: 20.0),
                    const SansText('Select Tip Percentage', 25.0),
                    Slider(
                      value: tipPercentage,
                      onChanged: (value) {
                        setState(() {
                          tipPercentage = value;
                        });
                      },
                      min: 0.1,
                      max: 0.3,
                      divisions: 4,
                    ),

                    // ===== Displaying the tip percentage =====

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SansText('${(tipPercentage * 100).round()}%', 20.0)
                      ],
                    ),

                    // ===== End of tip percentage selection slider =====

                    // ===== Calculated amounts after user interaction =====

                    const SizedBox(height: 20.0),
                    SansText(
                        'Tip Amount: \$${(billAmount * tipPercentage).toStringAsFixed(2)}',
                        23.0),
                    const SizedBox(height: 10),
                    SansText(
                        'Total Amount: \$${(billAmount + (billAmount * tipPercentage)).toStringAsFixed(2)}',
                        23.0),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),

              // ===== End of main tip calculator =====

              // ===== Column for additional calculations such as amount of people or when wanting to round the bill =====

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ===== Beginning of bill per person calculator ======

                  // This part takes the amount of people and splits the bill accordingly

                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                        borderRadius: BorderRadius.circular(20.0)),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
                    margin: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0),
                    child: Column(
                      children: [
                        const SansText('Split the bill', 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SansText('Number of people', 20.0),

                            // ===== Removing amount of people =====

                            Semantics(
                              label: 'Decrease number of people',
                              hint: 'Double-tap to decrease',
                              child: IconButton(
                                icon: const Icon(Icons.remove),
                                color: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    if (numberOfPeople > 1) {
                                      numberOfPeople--;
                                    }
                                  });
                                },
                              ),
                            ),

                            // ===== Number of people =====

                            Semantics(
                              label: 'Number of people: $numberOfPeople',
                              child: SansText('$numberOfPeople', 20.0),
                            ),

                            // ===== Adding the amount of people =====

                            Semantics(
                              label: 'Increase number of people',
                              hint: 'Double-tap to increase',
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                color: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    numberOfPeople++;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        SansText(
                            'Amount per person: \$${((billAmount + (billAmount * tipPercentage)) / numberOfPeople).toStringAsFixed(2)}',
                            20.0),
                      ],
                    ),
                  ),

                  // ===== End of per person calculator section =====

                  // ===== Beginning of rounding section =====

                  // This part rounds  the bill to the nearest dollar, up or down depending on what the user decides

                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                        borderRadius: BorderRadius.circular(20.0)),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
                    margin: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // ===== Rounding the bill up =====

                            const SansText('Round Up', 20.0),
                            IconButton(
                              icon: const Icon(Icons.arrow_upward),
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  roundUp = true;
                                  updateAmounts();
                                });
                              },
                            ),

                            // ===== Rounding the bill down =====

                            const SansText('Round Down', 20.0),
                            IconButton(
                              icon: const Icon(Icons.arrow_downward),
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  roundUp = false;
                                  updateAmounts();
                                });
                              },
                            ),
                          ],
                        ),

                        // ===== Showing the rounded amount =====
                        const SizedBox(height: 10.0),
                        SansText(
                            'Rounded Total: \$${roundTotalAmount().toStringAsFixed(0)}',
                            20.0),
                        SansText(
                            'Rounded Per Person: \$${calculateAmountPerPerson().toStringAsFixed(0)}',
                            20.0)
                      ],
                    ),
                  )

                  // ===== End of rounding section =====
                ],
              )

              // ===== End of additional calculations section  =====
            ],
          ),
        ),
        // ===== Bottom ad banner =====
        bottomNavigationBar: isAdloaded
            ? SizedBox(
                height: bottomBannerAd.size.height.toDouble(),
                width: bottomBannerAd.size.height.toDouble(),
                child: AdWidget(ad: bottomBannerAd),
              )
            : const SizedBox(),
      ),
    );
  }

  // ===== Functions being called for rounding the bill =====

  // ===== Rounds the amount of the total bill

  double roundTotalAmount() {
    double totalAmount = billAmount + (billAmount * tipPercentage);
    return roundUp ? totalAmount.ceilToDouble() : totalAmount.floorToDouble();
  }

  // ===== Rounds the amount of the bill per person =====

  double calculateAmountPerPerson() {
    return roundTotalAmount() / numberOfPeople;
  }

  // ===== This updates the rounded totals in the rounding container =====

  void updateAmounts() {
    setState(() {
      amountPerPersonText =
          'Amount per Person: \$${calculateAmountPerPerson().toStringAsFixed(2)}';

      roundedAmountText =
          'Rounded Amount: \$${roundTotalAmount().toStringAsFixed(0)}';
    });
  }
}
