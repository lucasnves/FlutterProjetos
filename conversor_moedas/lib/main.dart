import 'package:flutter/material.dart';

void main() async {
  runApp(
    MaterialApp(
      home: const Home(),
      theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 247, 247, 114), width: 2),
          ),
          hintStyle: TextStyle(color: Colors.amber),
        ),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real * 5).toStringAsFixed(2);
    euroController.text = (real * 2).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * 4).toStringAsFixed(2);
    euroController.text = (dolar * 2).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * 3).toStringAsFixed(2);
    dolarController.text = (euro * 2).toStringAsFixed(2);
  }

  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "\$ Conversor \$",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 26),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
        toolbarHeight: 70,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.monetization_on,
              size: 150.0,
              color: Colors.amber,
            ),
            const Divider(),
            buildTextField("Reais", "R\$ ", realController, _realChanged),
            const Divider(),
            buildTextField("Dólares", "US\$ ", dolarController, _dolarChanged),
            const Divider(),
            buildTextField("Euros", "€ ", euroController, _euroChanged),
          ],
        ),
      ),
    );
  }
}

Widget buildTextField(
    String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.amber,
      ),
      prefixText: prefix,
    ),
    style: const TextStyle(
      color: Colors.amber,
    ),
    onChanged: f as void Function(String)?,
    keyboardType: TextInputType.number,
    // keyboardType: TextInputType.numberWithOptions(decimal: true),  -- IOS --
  );
}


 /*
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber,
              ),
              child: const Icon(
                Icons.attach_money_sharp,
                color: Colors.black,
                size: 100,
              ),
            ),
            const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Reais',
                hintText: 'Ex. R\$ 403.03',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.amber,
                  ),
                ),
                labelStyle: TextStyle(
                  color: Colors.amber,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.amber,
                    width: 2,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    */