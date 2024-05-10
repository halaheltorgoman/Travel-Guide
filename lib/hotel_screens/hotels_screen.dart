import 'package:flutter/material.dart';

import '../models/hotel_medels.dart';
import 'hotel_details.dart';

class HotelsPage extends StatelessWidget {
  const HotelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose a Hotel for your Comfort'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
          itemCount: Reserve().hotels.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (Reserve().hotels[index].isAvailable) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HotelDetails(
                        hotel: Reserve().hotels[index],
                      ),
                    ),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[100]),
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Reserve().hotels[index].hotelName.toUpperCase(),
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const Text(
                              'Click here for more details',
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                              style: TextStyle(color: Colors.blue),
                            ),
                            const Divider(),
                            Text(
                              Reserve().hotels[index].isAvailable
                                  ? 'Available'
                                  : 'Not Available',
                              style: TextStyle(
                                color: Reserve().hotels[index].isAvailable
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            height: 100,
                            child: Image.network(
                              Reserve().hotels[index].hotelImage,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
