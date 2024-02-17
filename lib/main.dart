import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<Item> get listadoDeMenu {
  return [
    Item(
        icono: Icons.search,
        function: () {
          print("hola 0");
        },
        color: Colors.red),
    Item(
        icono: Icons.search,
        function: () {
          print("hola 1");
        },
        color: Colors.orange),
    Item(
        icono: Icons.search,
        function: () {
          print("hola 2");
        },
        color: Colors.indigo),
    Item(
        icono: Icons.search,
        function: () {
          print("hola 3");
        },
        color: Colors.black),
  ];
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(body: MyHomePageMenu()),
    );
  }
}

class MyHomePageMenu extends StatelessWidget {
  MyHomePageMenu({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (contex) {
        return ProviderMenuFlotante();
      },
      child: Builder(builder: (context) {
        bool estado = (Provider.of<ProviderMenuFlotante>(context).estadoMenu);

        return Stack(
          children: [
            const FondoListado(),
             AnimatedOpacity(
              opacity: estado? 0:1,
              duration: const Duration(milliseconds: 800),
              child: _MenuFlotante(Items: listadoDeMenu)) 
          ],
        );
      }),
    );
  }
}

class FondoListado extends StatefulWidget {
  const FondoListado({
    super.key,
  });

  @override
  State<FondoListado> createState() => _FondoListadoState();
}

class _FondoListadoState extends State<FondoListado> {
  final ScrollController controllerScroll = ScrollController();
  double anterior = 0.0;
  @override
  void initState() {
    final estadoM = Provider.of<ProviderMenuFlotante>(context, listen: false);
    controllerScroll.addListener(() {
      //print(controllerScroll.offset);

      if (controllerScroll.offset > anterior) {

        estadoM.estadoMenu = true;
      } else {
        estadoM.estadoMenu = false;
      }
      anterior=controllerScroll.offset;
    });
    super.initState();
  }

  @override
  void dispose() {
    controllerScroll.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: controllerScroll,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.bottomCenter,
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    color: _Colores(), borderRadius: BorderRadius.circular(20)),
                child: Text("$index"),
              ),
            ));
  }
}

class Item {
  IconData icono;
  VoidCallback function;
  Color color;

  Item({required this.icono, required this.function, this.color = Colors.blue});
}

Color _Colores() {
  final Random random = Random();

  //return Color.fromRGBO(
  //    random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);

  return Colors.blue;
}

class _MenuFlotante extends StatefulWidget {
  List<Item> Items;

  _MenuFlotante({required this.Items});

  @override
  State<_MenuFlotante> createState() => __MenuFlotanteState();
}

class __MenuFlotanteState extends State<_MenuFlotante> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 3000),
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        margin: const EdgeInsets.only(bottom: 40.0),
        width: MediaQuery.of(context).size.width * .6,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 4),
                blurStyle: BlurStyle.inner,
                blurRadius: 80,
                spreadRadius: 4,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(widget.Items.length, (index) {
            return GestureDetector(
                onTap: widget.Items[index].function,
                child: Icon(
                  widget.Items[index].icono,
                  color: widget.Items[index].color,
                ));
          }),
        ),
      ),
    );
  }
}

class ProviderMenuFlotante extends ChangeNotifier {
  late bool _estadoMenu;
  ProviderMenuFlotante() {
    _estadoMenu = true;
    print("hola");
  }

  bool get estadoMenu => _estadoMenu;

  set estadoMenu(bool x) {
    _estadoMenu = x;
    print(" estado del provider $_estadoMenu");
    notifyListeners();
  }
}
