import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/route_manager.dart';
import 'package:house/global.dart';
import 'package:house/model/posting_model.dart';
import 'package:house/payment_gateway/payment_config.dart';
import 'package:house/view/guest_home_screen.dart';
import 'package:house/view/widgets/calender_ui.dart';
import 'package:pay/pay.dart';

class BookListingScreen extends StatefulWidget {
   PostingModel? posting;
   String? hostID;

  BookListingScreen({super.key, this.posting, this.hostID});

  @override
  State<BookListingScreen> createState() => _BookListingScreenState();
}

class _BookListingScreenState extends State<BookListingScreen> {
  PostingModel? posting;
  
  

  List<DateTime> bookedDates = [];
  List<DateTime> selectedDates = [];
  List<CalenderUi> calenderWidgets = [];

  void _buildCalenderWidgets() {
    List<CalenderUi> tempWidgets = List.generate(12, (index) {
      return CalenderUi(
        monthIndex: index, // Ensure each instance gets a different month index
        bookedDates: bookedDates,
        selectDates: _selectDates,
        getSelectedDates: _getSelectedDates,
      );
    });

    setState(() {
      calenderWidgets = tempWidgets;
    });
  }

  List<DateTime> _getSelectedDates() {
    return selectedDates;
  }

  void _selectDates(DateTime date) {
    setState(() {
      if (selectedDates.contains(date)) {
        selectedDates.remove(date);
      } else {
        selectedDates.add(date);
      }
      selectedDates.sort();
    });
  }

  Future<void> _loadBookedDates() async {
    if (posting != null) {
      await posting!.getAllBookingsFromFirestore();
      setState(() {
        bookedDates = posting!.getAllBookedDates();
        _buildCalenderWidgets();
      });
    }
  }

_makeBooking() {
  if (selectedDates.isEmpty) {
    print("No dates selected!");
    return;
  }

  if (bookingPrice == 0.0) {
    print("Error: Booking price is zero. Cannot proceed.");
    return;
  }

  posting!.makeNewBooking(selectedDates, context, widget.hostID).whenComplete(() {
    Get.back();
  });
}


  calculateAmountForOverStay() {
    if (selectedDates.isEmpty) {
      return;
    }

    double totalPriceForAllNights = selectedDates.length * posting!.price!;
    bookingPrice = totalPriceForAllNights;
  }

  @override
  void initState() {
    super.initState();
    posting = widget.posting;
    _loadBookedDates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pinkAccent, Colors.amberAccent],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
        ),
        title: Text(
          posting != null ? "Book ${posting!.name}" : "Book Listing",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Sun'),
                Text('Mon'),
                Text('Tues'),
                Text('Wed'),
                Text('Thus'),
                Text('Fri'),
                Text('Sat'),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child:
                  calenderWidgets.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : PageView.builder(
                        itemCount: calenderWidgets.length,
                        itemBuilder: (context, index) {
                          return calenderWidgets[index]; // Correctly passing the index
                        },
                      ),
            ),

            bookingPrice == 0.0
                ? MaterialButton(
                  onPressed: () {
                    calculateAmountForOverStay();
                  },
                  minWidth: double.infinity,
                  height: MediaQuery.of(context).size.height / 14,
                  color: Colors.green,
                  child: const Text(
                    'Proceed',
                    style: TextStyle(color: Colors.white),
                  ),
                )
                : Container(),

            paymentResult != ""
                ? MaterialButton(
                  onPressed: () {
                    Get.to(GuestHomeScreen());

                    setState(() {
                      paymentResult = "";
                    });
                  },
                  minWidth: double.infinity,
                  height: MediaQuery.of(context).size.height / 14,
                  color: Colors.green,
                  child: const Text(
                    'Amount Paid Successfully',
                    style: TextStyle(color: Colors.white),
                  ),
                )
                : Container(),
            bookingPrice == 0.0
                ? Container()
                : Platform.isIOS
                ? ApplePayButton(
                  paymentConfiguration: PaymentConfiguration.fromJsonString(
                    defaultApplePay,
                  ),
                  paymentItems: [
                    PaymentItem(
                      amount: bookingPrice.toString(),
                      label: 'Booking Amount',
                      status: PaymentItemStatus.final_price
                      )
                  ],
                  style: ApplePayButtonStyle.black,
                  width: double.infinity,
                  height: 50,
                  type: ApplePayButtonType.buy,
                  margin: const EdgeInsets.only(top: 15.0),
                  onPaymentResult: (result) {
                    print("Payment Result = $result");
                    setState(() {
                      paymentResult = result.toString();
                      //bookingPrice;
                    });
                  },
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
                : GooglePayButton(
                  paymentConfiguration: PaymentConfiguration.fromJsonString(
                    defaultGooglePay,
                  ),
                  paymentItems: [

                    PaymentItem(
                      amount: bookingPrice.toString(),
                      status: PaymentItemStatus.final_price, 
                      label: 'Total Amounts',
                      )
                  ],
                  type: GooglePayButtonType.pay,
                  margin: const EdgeInsets.only(top: 15.0),

                  onPaymentResult: (result) {
                    print("Payment Result = $result");
                    setState(() {
                      paymentResult = result.toString();
                      //bookingPrice;
                    });

                    _makeBooking();
                  },

                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
