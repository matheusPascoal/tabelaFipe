import 'package:flutter/material.dart';
import 'package:tabela_fipe/model/cars_model.dart';

class CardsValues extends StatefulWidget {
  final String? label;
  final String? textValue;
  const CardsValues({Key? key, this.label, this.textValue}) : super(key: key);

  @override
  State<CardsValues> createState() => _CardsValuesState();
}

class _CardsValuesState extends State<CardsValues> {
  CarsModel car = CarsModel();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 8, right: 8),
      child: Container(
        height: 35,
        width: 360,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 236, 236, 236),
            borderRadius: BorderRadius.circular(5)),
        child: Row(children: [
          Center(
            child: Container(
              width: 85,
              child: Text(widget.label!,
                  style: TextStyle(
                    color: Color.fromARGB(255, 122, 122, 145),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start),
            ),
          ),
          SizedBox(width: 80),
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              widget.textValue!,
              style: TextStyle(
                color: Color.fromARGB(255, 122, 122, 145),
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ]),
      ),
    );
  }
}
