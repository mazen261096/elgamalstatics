import '../../models/car.dart';

class CarsClassification {
  List<Car> cars = [];

  List<Car> repair0 = [];
  List<Car> repair1 = [];
  List<Car> repair2 = [];
  List<Car> repair3 = [];
  List<Car> repair4 = [];

CarsClassification(this.cars);


  Future<List<List<List<Car>>>>  sortCars() async {

    List<List<Car>> sortedByRepairs =await dByRepairsCount(cars);
    List<List<List<Car>>> pdfSortedCars= await dByCounter(sortedByRepairs);

    return pdfSortedCars ;
  }

   Future<List<List<Car>>> dByRepairsCount(List<Car> inputList)async{
    List<List<Car>> outbutList =[];



    for(var car in inputList){

      if(car.repairsCount==0){
        repair0.add(car);
      }else if(car.repairsCount==1){
        repair1.add(car);
      }else if(car.repairsCount==2){
        repair2.add(car);
      }else if(car.repairsCount==3){
        repair3.add(car);
      }else if(car.repairsCount==4){
        repair4.add(car);
      }else {
        print('notfound ');
      }

    }


    outbutList=[repair0,repair1,repair2,repair3,repair4];


    return Future<List<List<Car>>>.value(outbutList);
  }

  Future<List<List<List<Car>>>> dByCounter(List<List<Car>> input)async{
    List<List<List<Car>>> out = [];


    for(var repairsList in input){

      List<Car> counter0 = [];
      List<Car> counter1 = [];
      List<Car> counter2 = [];
      List<Car> counter3 = [];
      List<Car> counter4 = [];


      for(var car in repairsList) {

        if(car.counter<=50000){
          counter0.add(car);

        }else if(car.counter<=100000){


          counter1.add(car);


        }else if(car.counter<=150000){

          counter2.add(car);


        }else if(car.counter<=200000){

          counter3.add(car);


        }else{

          counter4.add(car);


        }
      }
      print([counter0,counter1,counter2,counter3,counter4]);

      out.add([counter0,counter1,counter2,counter3,counter4]);


    }
    print(out);



    return Future<List<List<List<Car>>>>.value(out);

  }

}