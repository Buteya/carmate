import 'package:carmate/models/productcar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/badroute.dart';
import '../../components/customtitle.dart';
import '../../components/myappdrawer.dart';
import '../../models/user.dart';

class ViewProductCarsScreen extends StatefulWidget {
  const ViewProductCarsScreen({super.key});

  @override
  State<ViewProductCarsScreen> createState() => _ViewProductCarsScreenState();
}

class _ViewProductCarsScreenState extends State<ViewProductCarsScreen> {
  bool _isLoading = false;
  User? currentUser;
  String imageAvailable = '';

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    try {
      currentUser = Provider.of<User>(context, listen: false).users.last;
      imageAvailable = currentUser!.imageUrl;
      print(currentUser?.username);
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      _isLoading = false;
    });
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
                    mounted: mounted,
                  ),
                ),
                body:
                   Card(
                    child: Column(
                      children: [
                        Consumer<ProductCar>(
                            builder: (context, productCar, child) {
                              print(productCar);
                              print(productCar.productCars.length);
                              print(productCar.productCars[0]);
                          final productsLength = productCar.productCars.length;
                          final productImageUrl = productCar.carImage;
                          final productManufacturer = productCar.manufacturer;
                          final productId = productCar.id;
                          final productPrice = productCar.price;
                          return SizedBox(
                            height:690,
                            child: ListView.builder(
                                itemCount: productCar.productCars.length,
                                itemBuilder: (context, index) {
                                  return ExpansionTile(
                                    leading: Card(child: Image.network(width: 50,productCar.productCars[index].carImage)),
                                    title: Text(productCar.productCars[index].manufacturer),
                                    trailing:  Text(productCar.productCars[index].status),
                                    children: [
                                      ListTile(title: Card(child: Image.network(productCar.productCars[index].carImage),),),
                                      ListTile(title: Text('id: ${productCar.productCars[index].id}')),
                                      ListTile(title: Text('userid: ${productCar.productCars[index].userId}')),
                                      ListTile(title: Text('chasis number: ${productCar.productCars[index].chasisNumber}')),
                                      ListTile(title: Text('year of manufacture: ${productCar.productCars[index].yearOfManufacture}')),
                                      ListTile(title: Text('quantity: ${productCar.productCars[index].quantity}')),
                                      ListTile(title: Text('status: ${productCar.productCars[index].status}')),
                                      ListTile(title: Text('manufacturer: ${productCar.productCars[index].manufacturer}')),
                                      ListTile(title: Text('car name: ${productCar.productCars[index].carName}')),
                                      ListTile(title: Text('engine type: ${productCar.productCars[index].engineType}')),
                                      ListTile(title: Text('engine cc: ${productCar.productCars[index].engineCC}')),
                                      ListTile(title: Text('fuel type: ${productCar.productCars[index].fuelType}')),
                                      ListTile(title: Text('mileage: ${productCar.productCars[index].mileage}')),
                                      ListTile(title: Text('price: ${productCar.productCars[index].price}')),
                                      ListTile(title: Text('rent per hr: ${productCar.productCars[index].rentPerHr}')),
                                      ListTile(title: Text('car type: ${productCar.productCars[index].carType}')),
                                      ListTile(title: Text('description: ${productCar.productCars[index].description}')),
                                    ],
                                  );
                                }),
                          );
                            return Text('');
                        }),
                      ],
                    ),
                  ),
              );
  }
}
