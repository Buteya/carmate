import 'package:carmate/models/productcar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../components/badroute.dart';
import '../../components/customtitle.dart';
import '../../components/forminput.dart';
import '../../components/myappdrawer.dart';
import '../../models/user.dart';

class ViewProductCarsScreen extends StatefulWidget {
  const ViewProductCarsScreen({super.key});

  @override
  State<ViewProductCarsScreen> createState() => _ViewProductCarsScreenState();
}

class _ViewProductCarsScreenState extends State<ViewProductCarsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  User? currentUser;
  String imageAvailable = '';
  String? image = '';

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    try {
      currentUser = Provider.of<User>(context, listen: false).users.last;
      imageAvailable = currentUser!.imageUrl;
      print(imageAvailable);
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
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            'Displays a list of all the cars.',
                            style: GoogleFonts.roboto(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Consumer<ProductCar>(
                            builder: (context, productCar, child) {
                          print(productCar.productCars);
                          print(productCar.productCars.length);
                          for (final item in productCar.productCars) {
                            print(item.id);
                            print(item.userId);
                          }
                          return productCar.productCars.isEmpty
                              ? const Center(
                                  child: Text('no cars to display'),
                                )
                              : SizedBox(
                                  height: 690,
                                  child: ListView.builder(
                                      itemCount: productCar.productCars.length,
                                      itemBuilder: (context, index) {
                                        var status = productCar
                                            .productCars[index].status;
                                        var chasisNumber = productCar
                                            .productCars[index].chasisNumber;
                                        var quantity = productCar
                                            .productCars[index].quantity
                                            .toString();
                                        var yearOfManufacture = productCar
                                            .productCars[index]
                                            .yearOfManufacture
                                            .toString();
                                        var carManufacturer = productCar
                                            .productCars[index].manufacturer;
                                        var carName = productCar
                                            .productCars[index].carName;
                                        var engineType = productCar
                                            .productCars[index].engineType;
                                        var carEngineCC = productCar
                                            .productCars[index].engineCC
                                            .toString();
                                        var fuelType = productCar
                                            .productCars[index].fuelType;
                                        var carMileage = productCar
                                            .productCars[index].mileage
                                            .toString();
                                        var carPrice = productCar
                                            .productCars[index].price
                                            .toString();
                                        var rentPerHr = productCar
                                            .productCars[index].rentPerHr
                                            .toString();
                                        var carType = productCar
                                            .productCars[index].carType;
                                        var description = productCar
                                            .productCars[index].description;
                                        return Dismissible(
                                          key: Key(
                                              productCar.productCars[index].id),
                                          background: Container(
                                            color: Colors.red,
                                            alignment: Alignment.centerRight,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: const Icon(
                                                Icons.delete_forever_sharp,
                                                color: Colors.white),
                                          ),
                                          confirmDismiss: (direction) async {
                                            final confirmed =
                                                await showDialog<bool>(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Confirm Dismissal'),
                                                  content: const Text(
                                                      'Are you sure you want to remove this item?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop(
                                                            false); // Disallow dismissal
                                                      },
                                                      child:
                                                          const Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop(
                                                            true); // Allow dismissal
                                                      },
                                                      child:
                                                          const Text('Confirm'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );

                                            return confirmed ??
                                                false; // Default to disallow dismissal if dialog is dismissed
                                          },
                                          onDismissed: (direction) {
                                            setState(() {
                                              try {
                                                productCar.removeProduct(index);
                                              } catch (e) {
                                                print(e);
                                              }
                                            });
                                          },
                                          direction:
                                              DismissDirection.endToStart,
                                          child: ExpansionTile(
                                            subtitle: Text(productCar
                                                .productCars[index].carName),
                                            leading: Card(
                                              child: Image.network(
                                                  width: 50,
                                                  productCar.productCars[index]
                                                      .carImage),
                                            ),
                                            title: Text(productCar
                                                .productCars[index]
                                                .manufacturer),
                                            trailing: Text(productCar
                                                .productCars[index].status),
                                            children: [
                                              ListTile(
                                                title: Card(
                                                  child: Image.network(
                                                      productCar
                                                          .productCars[index]
                                                          .carImage),
                                                ),
                                              ),
                                              ListTile(
                                                title: const Text(
                                                  'Id',
                                                ),
                                                subtitle: Text(
                                                  productCar
                                                      .productCars[index].id,
                                                ),
                                              ),
                                              ListTile(
                                                title: const Text(
                                                  'User Id',
                                                ),
                                                subtitle: Text(
                                                  productCar.productCars[index]
                                                      .userId,
                                                ),
                                              ),
                                              ListTile(
                                                title: const Text(
                                                  'Chasis Number',
                                                ),
                                                subtitle: Text(
                                                  productCar.productCars[index]
                                                      .chasisNumber,
                                                ),
                                              ),
                                              ListTile(
                                                title: const Text(
                                                  'Year Of Manufacture',
                                                ),
                                                subtitle: Text(
                                                  productCar.productCars[index]
                                                      .yearOfManufacture
                                                      .toString(),
                                                ),
                                              ),
                                              ListTile(
                                                title: const Text(
                                                  'Quantity',
                                                ),
                                                subtitle: Text(
                                                  '${NumberFormat('####,###,###,###').format(
                                                    productCar
                                                        .productCars[index]
                                                        .quantity,
                                                  )} car(s)',
                                                ),
                                              ),
                                              ListTile(
                                                title: const Text(
                                                  'status',
                                                ),
                                                subtitle: Text(
                                                  productCar.productCars[index]
                                                      .status,
                                                ),
                                              ),
                                              ListTile(
                                                title: const Text(
                                                  'Manufacturer',
                                                ),
                                                subtitle: Text(
                                                  productCar.productCars[index]
                                                      .manufacturer,
                                                ),
                                              ),
                                              ListTile(
                                                title: const Text(
                                                  'Car Name',
                                                ),
                                                subtitle: Text(
                                                  productCar.productCars[index]
                                                      .carName,
                                                ),
                                              ),
                                              ListTile(
                                                title: const Text(
                                                  'Engine Type',
                                                ),
                                                subtitle: Text(
                                                  productCar.productCars[index]
                                                      .engineType,
                                                ),
                                              ),
                                              ListTile(
                                                title: const Text('Engine CC'),
                                                subtitle: Text(
                                                  '${NumberFormat.decimalPatternDigits(
                                                    locale:
                                                        'en_US', // Specify the desired locale
                                                  ).format(productCar.productCars[index].engineCC)}CC',
                                                ),
                                              ),
                                              ListTile(
                                                title: const Text(
                                                  'Fuel Type',
                                                ),
                                                subtitle: Text(
                                                  productCar.productCars[index]
                                                      .fuelType,
                                                ),
                                              ),
                                              ListTile(
                                                title: const Text(
                                                  'Mileage',
                                                ),
                                                subtitle: Text(
                                                  '${NumberFormat.decimalPatternDigits(
                                                    locale:
                                                        'en_US', // Specify the desired locale
                                                  ).format(productCar.productCars[index].mileage)}Km',
                                                ),
                                              ),
                                              ListTile(
                                                title: const Text(
                                                  'Price',
                                                ),
                                                subtitle: Text(
                                                  'KSH ${NumberFormat.decimalPatternDigits(
                                                    locale:
                                                        'en_US', // Specify the desired locale
                                                    decimalDigits:
                                                        2, // Set the number of decimal places
                                                  ).format(
                                                    productCar
                                                        .productCars[index]
                                                        .price,
                                                  )}',
                                                ),
                                              ),
                                              ListTile(
                                                title:
                                                    const Text('Rent Per Hr'),
                                                subtitle: Text(
                                                  'KSH ${NumberFormat.decimalPatternDigits(
                                                    locale:
                                                        'en_US', // Specify the desired locale
                                                    decimalDigits:
                                                        2, // Set the number of decimal places
                                                  ).format(
                                                    productCar
                                                        .productCars[index]
                                                        .rentPerHr,
                                                  )}',
                                                ),
                                              ),
                                              ListTile(
                                                title: const Text('Car Type'),
                                                subtitle: Text(
                                                  productCar.productCars[index]
                                                      .carType,
                                                ),
                                              ),
                                              ListTile(
                                                title:
                                                    const Text('Description'),
                                                subtitle: Text(
                                                  productCar.productCars[index]
                                                      .description,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: ElevatedButton.icon(
                                                  onPressed: () {
                                                    // Show the custom overlay
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return StatefulBuilder(
                                                            builder: (BuildContext context, StateSetter setState) {
                                                            return SingleChildScrollView(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(8.0),
                                                                child: Card(
                                                                  child: Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                16.0),
                                                                        child: Text(
                                                                          'Update Product Car',
                                                                          style: GoogleFonts
                                                                              .lato(
                                                                            textStyle: Theme.of(context)
                                                                                .textTheme
                                                                                .displayLarge,
                                                                            fontSize:
                                                                                48,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            fontStyle:
                                                                                FontStyle.italic,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets
                                                                                .all(
                                                                                16.0),
                                                                        child: Card(
                                                                          child: productCar
                                                                                  .productCars[index]
                                                                                  .carImage
                                                                                  .isEmpty
                                                                              ? const Icon(
                                                                                  Icons.image_rounded,
                                                                                  size: 60,
                                                                                )
                                                                              : ClipRRect(
                                                                                  borderRadius: const BorderRadius.all(
                                                                                    Radius.circular(12.0),
                                                                                  ),
                                                                                  child: image!.isEmpty ? Image.network(productCar.productCars[index].carImage) : Image.network(image!),
                                                                                ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets
                                                                                .all(
                                                                                16.0),
                                                                        child:
                                                                            ElevatedButton
                                                                                .icon(
                                                                          onPressed:
                                                                              () async {
                                                                            final pickedImage =
                                                                                await ImagePicker().pickImage(source: ImageSource.gallery);
                                                                            if (pickedImage !=
                                                                                null) {
                                                                              setState(
                                                                                  () {
                                                                                print(pickedImage.name);
                                                                                print(pickedImage.path);
                                                                                image =
                                                                                    pickedImage.path;
                                                                                print(image);
                                                                                print(productCar.productCars[index].carImage);
                                                                              });
                                                                              for (final user
                                                                                  in currentUser!.users) {
                                                                                print('image ${user.imageUrl}');
                                                                              }
                                                                            } else {
                                                                              // Handle the case where the user canceled image selection
                                                                              // (e.g., show a message or revert to a default image)
                                                                            }
                                                                          },
                                                                          label:
                                                                              const Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children: [
                                                                              Text(
                                                                                  "pick Image"),
                                                                              Icon(Icons
                                                                                  .camera),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets
                                                                                .all(
                                                                                16.0),
                                                                        child: Form(
                                                                          key:
                                                                              _formKey,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              FormInput(
                                                                                initialValue:
                                                                                    status,
                                                                                onChangedFunction: (value) =>
                                                                                    status = value!,
                                                                                labelText:
                                                                                    'Status',
                                                                                hintText:
                                                                                    'Enter car status, e.g in-stock',
                                                                                validationFunction:
                                                                                    (value) {
                                                                                  if (value == null || value.isEmpty) {
                                                                                    return "please enter car status";
                                                                                  }
                                                                                  return null;
                                                                                },
                                                                                obscureText:
                                                                                    false,
                                                                              ),
                                                                              FormInput(
                                                                                initialValue:
                                                                                    chasisNumber,
                                                                                onChangedFunction: (value) =>
                                                                                    chasisNumber = value!,
                                                                                labelText:
                                                                                    'Chasis Number',
                                                                                hintText:
                                                                                    'Enter car chasis number',
                                                                                validationFunction:
                                                                                    (value) {
                                                                                  if (value == null || value.isEmpty) {
                                                                                    return "please enter car chasis number";
                                                                                  }
                                                                                  return null;
                                                                                },
                                                                                obscureText:
                                                                                    false,
                                                                              ),
                                                                              FormInput(
                                                                                initialValue:
                                                                                    quantity,
                                                                                onChangedFunction: (value) =>
                                                                                    quantity = value!,
                                                                                labelText:
                                                                                    'Quantity',
                                                                                hintText:
                                                                                    'Enter number of cars, e.g 1',
                                                                                validationFunction:
                                                                                    (value) {
                                                                                  if (value == null || value.isEmpty) {
                                                                                    return "please enter number of cars";
                                                                                  }
                                                                                  return null;
                                                                                },
                                                                                obscureText:
                                                                                    false,
                                                                              ),
                                                                              FormInput(
                                                                                initialValue:
                                                                                    yearOfManufacture,
                                                                                onChangedFunction: (value) =>
                                                                                    yearOfManufacture = value!,
                                                                                labelText:
                                                                                    'Year Of Manufacturer',
                                                                                hintText:
                                                                                    'Enter car year of manufacturer, e.g 2007',
                                                                                validationFunction:
                                                                                    (value) {
                                                                                  if (value == null || value.isEmpty) {
                                                                                    return "please enter year of car manufacturer";
                                                                                  } else if (value.length > 4) {
                                                                                    return "Year cannot have 5 characters";
                                                                                  }
                                                                                  return null;
                                                                                },
                                                                                obscureText:
                                                                                    false,
                                                                              ),
                                                                              FormInput(
                                                                                initialValue:
                                                                                    carManufacturer,
                                                                                onChangedFunction: (value) =>
                                                                                    carManufacturer = value!,
                                                                                labelText:
                                                                                    'Manufacturer',
                                                                                hintText:
                                                                                    'Enter car manufacturer name,e.g Toyota',
                                                                                validationFunction:
                                                                                    (value) {
                                                                                  if (value == null || value.isEmpty) {
                                                                                    return "please enter car manufacturer name";
                                                                                  } else if (value.length > 15) {
                                                                                    return 'Manufacturer`s name is limited to 15 characters';
                                                                                  }
                                                                                  return null;
                                                                                },
                                                                                obscureText:
                                                                                    false,
                                                                              ),
                                                                              FormInput(
                                                                                initialValue:
                                                                                    carName,
                                                                                onChangedFunction: (value) =>
                                                                                    carName = value!,
                                                                                labelText:
                                                                                    'Car Name',
                                                                                hintText:
                                                                                    'Enter name of the car,e.g Impreza',
                                                                                validationFunction:
                                                                                    (value) {
                                                                                  if (value == null || value.isEmpty) {
                                                                                    return "please enter name of the car";
                                                                                  } else if (value.length > 15) {
                                                                                    return 'Car name is limited to 15 characters';
                                                                                  }
                                                                                  return null;
                                                                                },
                                                                                obscureText:
                                                                                    false,
                                                                              ),
                                                                              FormInput(
                                                                                initialValue:
                                                                                    engineType,
                                                                                onChangedFunction: (value) =>
                                                                                    engineType = value!,
                                                                                labelText:
                                                                                    'Engine type',
                                                                                hintText:
                                                                                    'Enter the type of engine, eg.v6',
                                                                                validationFunction:
                                                                                    (value) {
                                                                                  if (value == null || value.isEmpty) {
                                                                                    return "please enter the type of engine";
                                                                                  } else if (value.length > 6) {
                                                                                    return 'Engine type is limited to 6 characters';
                                                                                  }
                                                                                  return null;
                                                                                },
                                                                                obscureText:
                                                                                    false,
                                                                              ),
                                                                              FormInput(
                                                                                initialValue:
                                                                                    carEngineCC,
                                                                                onChangedFunction: (value) =>
                                                                                    carEngineCC = value!,
                                                                                labelText:
                                                                                    'Engine CC',
                                                                                hintText:
                                                                                    'Enter the car engine in cc, e.g 2500cc',
                                                                                validationFunction:
                                                                                    (value) {
                                                                                  if (value == null || value.isEmpty) {
                                                                                    return "please enter the car engine cc";
                                                                                  } else if (value.length > 6) {
                                                                                    return 'Engine cc characters are limited to 6';
                                                                                  }
                                                                                  return null;
                                                                                },
                                                                                obscureText:
                                                                                    false,
                                                                              ),
                                                                              FormInput(
                                                                                initialValue:
                                                                                    fuelType,
                                                                                onChangedFunction: (value) =>
                                                                                    fuelType = value!,
                                                                                labelText:
                                                                                    'Fuel Type',
                                                                                hintText:
                                                                                    'Enter car fuel type,eg.petrol',
                                                                                validationFunction:
                                                                                    (value) {
                                                                                  if (value == null || value.isEmpty) {
                                                                                    return "please enter car fuel type";
                                                                                  }
                                                                                  return null;
                                                                                },
                                                                                obscureText:
                                                                                    false,
                                                                              ),
                                                                              FormInput(
                                                                                initialValue:
                                                                                    carMileage,
                                                                                onChangedFunction: (value) =>
                                                                                    carMileage = value!,
                                                                                labelText:
                                                                                    'Mileage',
                                                                                hintText:
                                                                                    'Enter car mileage,e.g 30000km',
                                                                                validationFunction:
                                                                                    (value) {
                                                                                  if (value == null || value.isEmpty) {
                                                                                    return "please enter car mileage";
                                                                                  }
                                                                                  return null;
                                                                                },
                                                                                obscureText:
                                                                                    false,
                                                                              ),
                                                                              FormInput(
                                                                                initialValue:
                                                                                    carPrice,
                                                                                onChangedFunction: (value) =>
                                                                                    carPrice = value!,
                                                                                labelText:
                                                                                    'Price',
                                                                                hintText:
                                                                                    'Enter car price, eg 1000000',
                                                                                validationFunction:
                                                                                    (value) {
                                                                                  if (value == null || value.isEmpty) {
                                                                                    return "please enter car price";
                                                                                  }
                                                                                  return null;
                                                                                },
                                                                                obscureText:
                                                                                    false,
                                                                              ),
                                                                              FormInput(
                                                                                initialValue:
                                                                                    rentPerHr,
                                                                                onChangedFunction: (value) =>
                                                                                    rentPerHr = value!,
                                                                                labelText:
                                                                                    'Rent Per Hr',
                                                                                hintText:
                                                                                    'Enter car rent per hr,e.g 500',
                                                                                validationFunction:
                                                                                    (value) {
                                                                                  if (value == null || value.isEmpty) {
                                                                                    return "please enter car rent per hr";
                                                                                  }
                                                                                  return null;
                                                                                },
                                                                                obscureText:
                                                                                    false,
                                                                              ),
                                                                              FormInput(
                                                                                initialValue:
                                                                                    carType,
                                                                                onChangedFunction: (value) =>
                                                                                    carType = value!,
                                                                                labelText:
                                                                                    'Car Type',
                                                                                hintText:
                                                                                    'Enter car type, e.g Sedan',
                                                                                validationFunction:
                                                                                    (value) {
                                                                                  if (value == null || value.isEmpty) {
                                                                                    return "please enter car type";
                                                                                  }
                                                                                  return null;
                                                                                },
                                                                                obscureText:
                                                                                    false,
                                                                              ),
                                                                              TextFormField(
                                                                                initialValue:
                                                                                    description,
                                                                                maxLines:
                                                                                    null,
                                                                                onChanged: (value) =>
                                                                                    description = value,
                                                                                decoration:
                                                                                    const InputDecoration(
                                                                                  labelText: 'Description',
                                                                                  hintText: 'Enter car description, e.g A good car: Reliable, efficient, safe, comfortable, stylish, and fun. 🚗',
                                                                                ),
                                                                                validator:
                                                                                    (value) {
                                                                                  if (value == null || value.isEmpty) {
                                                                                    return "please enter car description";
                                                                                  } else if (value.length > 240) {
                                                                                    return 'Description is limited to 240 characters';
                                                                                  }
                                                                                  return null;
                                                                                },
                                                                                obscureText:
                                                                                    false,
                                                                              ),
                                                                              Padding(
                                                                                padding:
                                                                                    const EdgeInsets.all(16.0),
                                                                                child:
                                                                                    Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    ElevatedButton.icon(
                                                                                      onPressed: () {
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                      label: const Row(
                                                                                        children: [
                                                                                          Text('close'),
                                                                                          Icon(Icons.close_rounded),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    ElevatedButton.icon(
                                                                                      onPressed: () {
                                                                                        productCar.updateProduct(
                                                                                            ProductCar(
                                                                                              status: status,
                                                                                              chasisNumber: chasisNumber,
                                                                                              quantity: int.tryParse(quantity)!,
                                                                                              yearOfManufacture: int.tryParse(yearOfManufacture)!,
                                                                                              carImage: image!.isEmpty?productCar.productCars[index].carImage:image!,
                                                                                              userId: productCar.productCars[index].userId,
                                                                                              id: productCar.productCars[index].id,
                                                                                              manufacturer: carManufacturer,
                                                                                              carName: carName,
                                                                                              engineType: engineType,
                                                                                              engineCC: int.tryParse(carEngineCC)!,
                                                                                              fuelType: fuelType,
                                                                                              mileage: int.tryParse(carMileage)!,
                                                                                              price: int.tryParse(carPrice)!,
                                                                                              rentPerHr: int.tryParse(rentPerHr)!,
                                                                                              carType: carType,
                                                                                              description: description,
                                                                                            ),
                                                                                            index);
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                      label: const Row(
                                                                                        children: [
                                                                                          Text('update'),
                                                                                          Icon(Icons.update_rounded),
                                                                                        ],
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        ); // Your custom overlay widget
                                                      },
                                                    );
                                                  },
                                                  label: const Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text('update'),
                                                      Icon(Icons.update_rounded)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                );
                        }),
                      ],
                    ),
                  ),
                ),
              );
  }
}
