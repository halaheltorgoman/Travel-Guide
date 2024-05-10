import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:flutter/material.dart';

import '../models/hotel_medels.dart';

class HotelDetails extends StatefulWidget {
  final Hotels hotel;

  const HotelDetails({
    super.key,
    required this.hotel,
  });

  @override
  State<HotelDetails> createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  bool isOn = false;
  int beds = 2;
  int days = 2;
  int price = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hotel Description'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          // margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey[100],
          ),
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Image.network(
                      widget.hotel.hotelImage,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.hotel.hotelName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  widget.hotel.hotelDescription,
                  style: const TextStyle(
                    fontSize: 19,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (beds > 2) {
                                    price -= 200;
                                    beds--;
                                  }
                                });
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text(
                              "$beds Beds",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (beds < 8) {
                                    beds++;
                                    price += 200;
                                  }
                                });
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (days > 1) {
                                    days--;
                                    price -= 250;
                                  }
                                });
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text(
                              "$days Days",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  days++;
                                  price += 250;
                                });
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey),
                    color: Colors.grey[300],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                          'you need a breakfast? \nThe price will be increased by 100EG'),
                      Switch(
                        activeColor: Colors.blue,
                        value: isOn,
                        onChanged: (value) {
                          setState(() {
                            isOn = value;
                            if (value) {
                              price += (100 * days);
                            } else {
                              price -= (100 * days);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  textAlign: TextAlign.center,
                  'Price',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  '$price EG',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  color: Colors.grey[900],
                  height: 70,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  onPressed: () {
                    launcher.launchUrl(
                      Uri.parse('https://booking.com'),
                      mode: launcher.LaunchMode.externalNonBrowserApplication,
                    );
                  },
                  child: const Text(
                    'Book now',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
