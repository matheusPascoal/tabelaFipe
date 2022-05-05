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
      padding: const EdgeInsets.only(
        top: 5,
      ),
      child: Container(
        height: 40,
        width: 360,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 219, 217, 217),
            borderRadius: BorderRadius.circular(5)),
        child: Row(children: [
          Center(
            child: Container(
              child: Text(widget.label!,
                  textScaleFactor: 0.7,
                  style: TextStyle(
                    color: Color.fromARGB(255, 26, 26, 48),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start),
            ),
          ),
          SizedBox(width: 80),
          Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                widget.textValue!,
                style: TextStyle(
                  color: Color.fromARGB(255, 62, 62, 78),
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
