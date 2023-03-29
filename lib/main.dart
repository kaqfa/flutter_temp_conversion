import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Konversi Temperatur',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const TemperaturPage(title: 'Konversi Temperatur'),
    );
  }
}

bool isNumeric(String str) {
  if(str == null) {
    return false;
  }
  return double.tryParse(str) != null;
}

class TemperaturPage extends StatefulWidget{
  final String title;
  const TemperaturPage({super.key, required this.title});

  @override
  State<TemperaturPage> createState() => _TemperaturPage();
}

class _TemperaturPage extends State<TemperaturPage>{

  TextEditingController inputController = TextEditingController();
  String _pilihan = "kelvin";
  double _hasil = 0;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  handleHitung() {
    double inputTemp = double.parse(inputController.text);

    setState(() {

      if(_pilihan == 'kelvin'){
        _hasil = inputTemp + 273.15;
      } else {
        _hasil = (inputTemp * (9/5)) + 32;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      home: Scaffold(
        appBar: AppBar(title: Text(widget.title),),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: TextFormField(
                        controller: inputController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "Derajat (c)",),
                        validator: (value){
                          if( !isNumeric(value.toString()) ){
                            return 'Inputan harus berupa angka';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: "Konversi ke",
                        ),
                        value: _pilihan,
                        onChanged: (value){
                          _pilihan = value.toString();
                        },
                        items: const [
                          DropdownMenuItem(value: "kelvin",child: Text("Kelvin"),),
                          DropdownMenuItem(value: "fahrenheit",child: Text("Fahrenheit"),)
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: TextField(
                    controller: TextEditingController(text: _hasil.toString()),
                    decoration: const InputDecoration(labelText: "Hasil Konversi", border: OutlineInputBorder()),
                    readOnly: true,
                  ),
                ),
                const SizedBox(height: 20),
                Row(children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if(_key.currentState!.validate()){
                          handleHitung();
                        }
                      },
                      child: const Text('Hitung Temperatur'),
                    ),
                  ),
                ],
                )
              ],
            ),
          )
        )
      ),
    );
  }
}
