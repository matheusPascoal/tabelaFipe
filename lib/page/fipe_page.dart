import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
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

  List<BrandModel> marcasSelect = [];
  List<BrandModel> modelCarSelect = [];
  List<BrandModel> yearSelect = [];

  String codeBrand = '';
  String codeModelCar = '';
  String codeYear = '';

  bool isloading = false;
  bool validatorFild = false;
  var focus = FocusNode();
  var pageController = PageController();

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
    isloading = false;
    setState(() {});
  }

  int currentPage = 0;
  @override
  void initState() {
    pageController.addListener(
      () {
        currentPage = pageController.page!.round();
        setState(() {});
      },
    );
    getBrand();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF0B1F38),
        title: Padding(
          padding: const EdgeInsets.only(left: 85),
          child: Row(children: [
            Icon(
              Icons.directions_car_rounded,
              size: 40,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "TABELA FIPE",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ),
      ),
      body: SafeArea(
        left: true,
        right: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //CAMPO DA MARCA
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 16, right: 16),
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
                padding: const EdgeInsets.only(top: 5, left: 16, right: 16),
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
                padding: const EdgeInsets.only(top: 5, left: 16, right: 16),
                child: SearchField(
                  searchStyle: TextStyle(fontSize: 12),
                  focusNode: focus,
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
                  //BUTTON SEARCH
                  Container(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0XFF0B1F38))),
                      onPressed: () async {
                        focus.unfocus();
                        setState(() {
                          isloading = true;
                          validatorFild = true;
                        });
                        await getCar(codeModelCar, codeBrand, codeYear);
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Pesquisar   ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Icon(
                              Icons.search_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    width: 160,
                    height: 50,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  //BUTTON CLEAN
                  Container(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0XFF0B1F38))),
                      onPressed: () {
                        textBrandController.clear();
                        textModelCarController.clear();
                        textYearCarController.clear();
                        modelCarSelect.clear();
                        yearSelect.clear();
                        setState(() {
                          validatorFild = false;
                        });
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Limpar   ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.cleaning_services_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    width: 160,
                    height: 50,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //CARD COM DADOS DO VEICULO
              if (validatorFild == true && isloading == false) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: Container(
                    height: 400,
                    child: PageView(
                      controller: pageController,
                      children: [
                        Column(
                          children: [
                            CardsValues(
                                label: ' Mês de referência:',
                                textValue: '${car.mesReferencia}  '),
                            CardsValues(
                                label: ' Marca:', textValue: '${car.marca}  '),
                            CardsValues(
                                label: ' Modelo:  ',
                                textValue: '${car.modelo}  '),
                            CardsValues(
                                label: ' Ano:', textValue: '${car.anoModelo} '),
                            CardsValues(
                                label: ' Combustivel:',
                                textValue: '${car.combustivel} '),
                            CardsValues(
                                label: ' Codigo FIPE:',
                                textValue: '${car.codigoFipe}  '),
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0XFF0B1F38),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20))),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text(
                                          'Preço medio:',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 24, 142, 197),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Text(
                                          ' ${car.valor}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 25),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                height: 50,
                              ),
                            )
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              //color: Colors.pink,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://img1.gratispng.com/20180328/zkq/kisspng-2015-ferrari-laferrari-ferrari-812-superfast-mclar-ferrari-5abc30ebd15fe0.9498101415222827318576.jpg'),
                                  fit: BoxFit.fitWidth)),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      2,
                      (index) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentPage == index
                                  ? Colors.blue
                                  : Colors.grey)),
                    )

                    //AREA DO CARD COM VALORES DA PESQUISA
                    )
              ],
              if (isloading == true)
                // Container(
                //   height: 50,
                //   width: 50,
                //   child: CircularProgressIndicator(),
                // )
                GifView.asset(
                  'assets/loader.gif',
                  height: 200,
                  width: 200,
                  frameRate: 30, // default is 15 FPS
                )
            ],
          ),
        ),
      ),
    );
  }
}
