import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/restaurants_models.dart';

class RestaurantsDetails extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantsDetails({
    super.key,
    required this.restaurant,
  });

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
                    restaurant.restaurantImage,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                restaurant.restaurantName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  restaurant.restaurantDetails,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey),
                  color: Colors.grey[300],
                ),
                child: Text(
                  'average Price is: ${restaurant.averagePrice} EG',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green[700],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rate Stars',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      size: 24,
                      Icons.star,
                      color: restaurant.restaurantRate > 0
                          ? Colors.blue
                          : Colors.grey[300],
                    ),
                    Icon(
                      size: 24,
                      Icons.star,
                      color: restaurant.restaurantRate > 1
                          ? Colors.blue
                          : Colors.grey[400],
                    ),
                    Icon(
                      size: 24,
                      Icons.star,
                      color: restaurant.restaurantRate > 2
                          ? Colors.blue
                          : Colors.grey[400],
                    ),
                    Icon(
                      size: 24,
                      Icons.star,
                      color: restaurant.restaurantRate > 3
                          ? Colors.blue
                          : Colors.grey[400],
                    ),
                    Icon(
                      size: 24,
                      Icons.star,
                      color: restaurant.restaurantRate > 4
                          ? Colors.blue
                          : Colors.grey[400],
                    ),
                  ],
                ),
              ),
              MaterialButton(
                color: Colors.grey[900],
                height: 70,
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () {},
                child: const Text(
                  'Go To Location',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
