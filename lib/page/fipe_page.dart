import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'package:tabela_fipe/model/brand_model.dart';
import 'package:tabela_fipe/model/cars_model.dart';
import 'package:tabela_fipe/repository/repository.dart';
import 'package:tabela_fipe/widgets/cardValues.dart';
import 'package:tabela_fipe/widgets/widget_button.dart';

class FipePage extends StatefulWidget {
  const FipePage({Key? key}) : super(key: key);

  @override
  State<FipePage> createState() => _FipePageState();
}

class _FipePageState extends State<FipePage> {
  TextEditingController textBrandController = TextEditingController();
  TextEditingController textModelCarController = TextEditingController();
  TextEditingController textYearCarController = TextEditingController();
  FipeRepository fipeResository = FipeRepository();
  CarsModel car = CarsModel();
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  List<BrandModel> marcasSelect = [];
  List<BrandModel> modelCarSelect = [];
  List<BrandModel> yearSelect = [];

  String codeBrand = '';
  String codeModelCar = '';
  String codeYear = '';

  getBrand() async {
    var result = await FipeRepository().getBrand();

    marcasSelect = result;
    setState(() {});
  }

  getModelCar(String codigo) async {
    var result = await FipeRepository().getModelCar(codigo);
    modelCarSelect = result;
    setState(() {});
  }

  getYears(String codeModelCar, String codeBrand) async {
    var result = await FipeRepository().getYears(codeModelCar, codeBrand);
    yearSelect = result;
    setState(() {});
  }

  getCar(String codeModelCar, String codeBrand, String codeYear) async {
    var result =
        await FipeRepository().getCar(codeModelCar, codeBrand, codeYear);
    car = result;
    setState(() {});
  }

  @override
  void initState() {
    getBrand();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF0B1F38),
        title: Center(
          child: Text(
            "TABELA FIPE",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          //CAMPO DA MARCA
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 8, right: 8),
            child: SearchField(
              searchStyle: TextStyle(fontSize: 12),
              itemHeight: 45,
              searchInputDecoration: InputDecoration(
                  suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
              controller: textBrandController,
              onSuggestionTap: (value) async {
                var brand = value.item as BrandModel;
                codeBrand = brand.codigo!;
                await getModelCar(codeBrand);
              },
              hint: 'MARCA',
              suggestions: marcasSelect
                  .map(
                    (e) => SearchFieldListItem<BrandModel>(e.nome!,
                        child: Text(e.nome!), item: e),
                  )
                  .toList(),
            ),
          ),

          // CAMPO DO MODELO
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 8, right: 8),
            child: SearchField(
              searchStyle: TextStyle(fontSize: 12),
              controller: textModelCarController,
              itemHeight: 45,
              searchInputDecoration: InputDecoration(
                  suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
              hint: 'MODELO',
              onSuggestionTap: (value) async {
                var model = value.item as BrandModel;
                codeModelCar = model.codigo!;
                await getYears(codeModelCar, codeBrand);
              },
              suggestions: modelCarSelect
                  .map(
                    (e) => SearchFieldListItem<BrandModel>(e.nome!,
                        child: Text(e.nome!), item: e),
                  )
                  .toList(),
            ),
          ),

          // CAMPO DO ANO
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 8, right: 8),
            child: SearchField(
              searchStyle: TextStyle(fontSize: 12),
              controller: textYearCarController,
              itemHeight: 45,
              searchInputDecoration: InputDecoration(
                  suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
              onSuggestionTap: (value) async {
                var year = value.item as BrandModel;
                codeYear = year.codigo!;
              },
              hint: 'ANO',
              suggestions: yearSelect
                  .map((e) => SearchFieldListItem<BrandModel>(e.nome!,
                      child: Text(e.nome!), item: e))
                  .toList(),
            ),
          ),
          SizedBox(
            height: 40,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //BUTTON REMOVE
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0XFF0B1F38))),
                    onPressed: () {
                      textBrandController.clear();
                      textModelCarController.clear();
                      textYearCarController.clear();
                    },
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Limpar"),
                          Icon(
                            Icons.cleaning_services_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  width: 120,
                ),
              ),

              //BUTTON SEARCH
              Padding(
                padding: const EdgeInsets.all(9),
                child: Container(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0XFF0B1F38))),
                    onPressed: () {
                      setState(() async {
                        await getCar(codeModelCar, codeBrand, codeYear);
                      });
                    },
                    child: Center(
                      child: Row(
                        children: [
                          Text("Pesquisar"),
                          Icon(
                            Icons.search_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  width: 120,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          FlipCard(
            fill: Fill
                .fillBack, // Fill the back side of the card to make in the same size as the front.
            direction: FlipDirection.HORIZONTAL, // default
            front: Padding(
              padding:
                  const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0XFF0B1F38),
                    borderRadius: BorderRadius.circular(5)),
                height: 260,
                child: Column(
                  children: [
                    CardsValues(
                        label: 'Mês de referência:',
                        textValue: '${car.mesReferencia}'),
                    CardsValues(label: 'Marca:', textValue: '${car.marca}'),
                    CardsValues(label: 'Modelo:  ', textValue: '${car.modelo}'),
                    CardsValues(label: 'Ano:', textValue: '${car.anoModelo}'),
                    CardsValues(
                        label: 'Combustivel:', textValue: '${car.combustivel}'),
                    CardsValues(
                        label: 'Codigo FIPE:', textValue: '${car.codigoFipe}'),
                  ],
                ),
              ),
            ),
            back: Padding(
              padding: const EdgeInsets.only(
                  top: 5, left: 40, right: 40, bottom: 10),
              child: Container(
                height: 260,
                color: Colors.blue,
                child: Text('Back'),
              ),
            ),
          ),

          // Padding(
          //   padding:
          //       const EdgeInsets.only(top: 5, left: 40, right: 40, bottom: 10),
          //   child: Container(
          //     decoration: BoxDecoration(
          //         color: Colors.grey,
          //         borderRadius: BorderRadius.all(Radius.circular(20))),
          //     height: 160,
          //   ),
          // ),
          //AREA DO CARD COM VALORES DA PESQUISA
        ],
      ),
      bottomSheet: Container(
        width: 400,
        color: Color(0XFF0B1F38),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Preço medio:',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                ' ${car.valor}',
                style: TextStyle(color: Colors.white, fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        height: 50,
      ),
    );
  }
}
