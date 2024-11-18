import 'package:dio/dio.dart';

import '../../models/car.dart';

class CarService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8080/cars/'));

  Future<void> createCar(Car car) async {
    await _dio.post('createCar', data: {
      "car": car.toJson(car)
    });
  }

  Future<void> deleteCar(int id) async {
    await _dio.post('deleteCar', queryParameters: {'id': id});
  }

  Future<void> deleteCars() async {
    final response = await _dio.get('getAllCars');
for(Map element in (response.data as List)){
  await _dio.delete('deleteCar', data: {
    "id": element['id']
  });
}
  }

  Future<List<Car>> getAllCars() async {
    final response = await _dio.get('getAllCars');
    print(response.data);
    return (response.data as List).map((json) => Car.fromJson(json)).toList();
  }

  Future<void> updateCar(Car car) async {
    await _dio.post('updateCar', data: car.toJson(car));
  }

  Future<Car?> getCar(int id) async {
    final response = await _dio.get('getCar', queryParameters: {'id': id});
    return response.data != null ? Car.fromJson(response.data) : null;
  }

  Future<void> createCarsBatch(List<Car> cars) async {
    await _dio.post('createCarsBatch', data: {"cars": cars.map((car) => car.toJson(car)).toList()});
  }
}
