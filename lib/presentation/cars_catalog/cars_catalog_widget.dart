import 'package:elgamalstatics/cubit/car_catalog/car_catalog_cubit.dart';
import 'package:elgamalstatics/presentation/cars_catalog/sort_catalog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/car.dart';
import 'car_item_widget.dart';
import 'filter_catalog_widget.dart';

class CarsCatalogWidget extends StatelessWidget {
   const CarsCatalogWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
            FilterCatalogWidget(),
          SortWidget(),

          Expanded(
            child: BlocProvider.of<CarCatalogCubit>(context).cars.isEmpty?
            const Center(
              child: Text('There is No Cars'),
            )
                :GridView.builder(
              shrinkWrap: true,
              gridDelegate:SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 500,childAspectRatio: .8,crossAxisSpacing: 5,mainAxisSpacing: 5,),

              itemBuilder: (context, index) {
            
                return CarItem(carItem: BlocProvider.of<CarCatalogCubit>(context).cars[index],);
            
            
              },
              itemCount:BlocProvider.of<CarCatalogCubit>(context).cars.length ,
            ),
          ),
        ],
      ),
    );
  }
}
