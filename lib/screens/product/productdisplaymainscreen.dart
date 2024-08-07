import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/badroute.dart';
import '../../components/customtitle.dart';
import '../../components/myappdrawer.dart';
import '../../models/productcar.dart';
import '../../models/user.dart';

class ProductDisplayMainScreen extends StatefulWidget {
  const ProductDisplayMainScreen({super.key});

  @override
  State<ProductDisplayMainScreen> createState() =>
      _ProductDisplayMainScreenState();
}

class _ProductDisplayMainScreenState extends State<ProductDisplayMainScreen> {
  User? currentUser;
  String? imageAvailable = '';
  final bool _isLoading = false;
  String? image = '';

  @override
  void initState() {
    try {
      currentUser = Provider.of<User>(context, listen: false).users.last;
      print(Provider.of<User>(context, listen: false).users.length);
    } catch (e) {
      print(e.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return currentUser == null
        ? const BadRoute()
        : _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const CustomTitle(
                    color: Colors.deepPurpleAccent,
                  ),
                ),
                drawer: Drawer(
                  child: MyAppDrawer(
                      imageAvailable: imageAvailable,
                      currentUser: currentUser,
                      mounted: mounted),
                ),
                body: SingleChildScrollView(
                  child: Consumer<ProductCar>(
                      builder: (context, car, productCarIndex) {
                    return SizedBox(
                      height: 690,
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Two products per row
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 3 /
                                2, // Aspect ratio (width / height) of each item
                          ),
                          itemCount: car.productCars.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 4, // Add some shadow to the card
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // Rounded corners
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                    child: Image.network(
                                      car.productCars[index].carImage, // Replace with your image URL
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      car.productCars[index].manufacturer,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                     car.productCars[index].carName,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '\$${car.productCars[index].price}', // Replace with the actual price
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );

                          }),
                    );
                  }),
                ),
              );
  }
}
