import 'dart:collection';

import 'package:flutter/material.dart';

class ProductCar extends ChangeNotifier {
  final String userId;
  final String id;
  final String manufacturer;
  final String carName;
  final String engineType;
  final int engineCC;
  final String fuelType;
  final int mileage;
  final int price;
  final int rentPerHr;
  final String carType;
  int? rating;
  List<String>? comments;
  final String description;
  late final String carImage;
  final int yearOfManufacture;
  final String chasisNumber;
  final String status;
  final int quantity;

  final List<ProductCar> _productCars = [];

  UnmodifiableListView<ProductCar> get productCars =>
      UnmodifiableListView(_productCars);

  ProductCar({
    required this.status,
    required this.chasisNumber,
    required this.quantity,
    required this.yearOfManufacture,
    required this.carImage,
    required this.userId,
    required this.id,
    required this.manufacturer,
    required this.carName,
    required this.engineType,
    required this.engineCC,
    required this.fuelType,
    required this.mileage,
    required this.price,
    required this.rentPerHr,
    required this.carType,
    this.rating,
    this.comments,
    required this.description,
  });


  void add(ProductCar car) {
    _productCars.add(car);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void removeProduct(int index) {
    _productCars.removeAt(index);
    notifyListeners();
  }

  void updateProduct(ProductCar updatedProduct,int index){
    _productCars[index]= updatedProduct;
    notifyListeners();
  }

  void removeAll() {
    _productCars.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
