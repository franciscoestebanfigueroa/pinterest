import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      home: const Scaffold(
        body: MyHomePage()),
    );
  }
}


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (contex){return ProviderMenuFlotante();},
      child: Stack(
        children: [
ListView.builder(
  itemBuilder: (context, index) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
    
      alignment: Alignment.bottomCenter,
                  
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                  color: _Colores(),
                  borderRadius: BorderRadius.circular(20)
                ),
                  child: Text("$index"),),
  )),
          
          



          _MenuFlotante(Items: [
            Item(
              icono: Icons.search,
              function: (){print("hola 0");},
              color: _Colores()
             ),
             Item(
              icono: Icons.search,
              function: (){print("hola 1");},
              color: _Colores()
             ),
             Item(
              icono: Icons.search,
              function: (){print("hola 2");},
              color: _Colores()
             ),
             Item(
              icono: Icons.search,
              function: (){print("hola 3");},
              color: _Colores()
             ),


          ])
        ],
        ),
      );
  }
}

class Item{
   IconData icono;
   VoidCallback function;
   Color color;
    
    Item({
      required this.icono,
      required this.function,
      this.color=Colors.blue
      });


  
}

Color _Colores() {

  Random random = Random();

  return Color.fromRGBO(random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);
  
}


class _MenuFlotante extends StatefulWidget {
   List <Item>Items;
   
   _MenuFlotante({
    required this.Items
    });

  @override
  State<_MenuFlotante> createState() => __MenuFlotanteState();
}

class __MenuFlotanteState extends State<_MenuFlotante> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        margin:  const EdgeInsets.only(bottom: 40.0),
        width: MediaQuery.of(context).size.width*.6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow:  const <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 4),
              blurStyle: BlurStyle.inner,
              blurRadius: 80,
              spreadRadius: 4,
            ) 
            ]
        ),
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:List.generate(widget.Items.length, (index){
          return  GestureDetector(
            onTap: widget.Items[index].function,
            child: Icon(widget.Items[index].icono,color: widget.Items[index].color,));
          }) ,
        ),
      ),
    );

  }
}


class ProviderMenuFlotante extends ChangeNotifier{
  




}