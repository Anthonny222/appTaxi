import 'dart:convert';

import 'package:api_app_firebase/models/conductores.dart';
import 'package:api_app_firebase/theme/app_theme.dart';
import 'package:api_app_firebase/widgets/custom_input_field.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class SolicitarScreen extends StatefulWidget {
   
  const SolicitarScreen({Key? key}) : super(key: key);

  @override
  State<SolicitarScreen> createState() => _SolicitarScreenState();
}

class _SolicitarScreenState extends State<SolicitarScreen> {

  final url = Uri.parse("http://10.0.2.2:8000/insertarConductor"); 
  
  late Future <List<Conductores>> conductores;




  final nombres = TextEditingController();
  final celular = TextEditingController();
  final placa = TextEditingController();
  final cedula = TextEditingController();
  final tiempo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Conductor'),
        centerTitle: true,
        backgroundColor: AppTheme.primary,
        elevation: 0,
      ),
      body: Center(
         child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
           child: Column(
            children: [
              CustomInputField(
                controller: nombres,
                keyboardType: TextInputType.name,
                hintText: 'Nombres',
                labelText: 'Nombres',
                suffixIcon: Icons.person,
              ),
              CustomInputField(
                controller: celular,
                keyboardType: TextInputType.number,
                hintText: 'Celular',
                labelText: 'Celular',
                suffixIcon: Icons.drag_indicator_sharp,
              ),
              CustomInputField(
                controller: placa,
                hintText: 'Placa',
                labelText: 'Placa',
                helperText: '3 letras y 4 numeros seguidos',
                suffixIcon: Icons.abc,
              ),
              CustomInputField(
                controller: cedula,
                keyboardType: TextInputType.number,
                hintText: 'Cedula',
                labelText: 'Cedula',
                suffixIcon: Icons.numbers,
              ),
              CustomInputField(
                controller: tiempo,
                keyboardType: TextInputType.number,
                hintText: 'Tiempo Llegada en Minutos',
                labelText: 'Tiempo Llegada en Minutos',
                suffixIcon: Icons.timer,
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () async {
                  saveConductor();
                  await Navigator.pushNamed(context, 'taxi_d');
                }, 
                style: TextButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  minimumSize: const Size(200, 50),
                  foregroundColor: Colors.white
                ),
                child: const SizedBox(
                  width: 200,
                  child: 
                      Text('Guardar',textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              )
            ],
           ),
         )
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    
  }

  void saveConductor() async {


    final user = { "nombres": nombres.text, "celular": celular.text, "placa": placa.text, "tiempo": tiempo.text, "cedula": cedula.text};


    await http.post(url, body: user); 
  

    nombres.clear();
    celular.clear();
    placa.clear();
    cedula.clear();
    tiempo.clear();

    setState(() {
    
    });

  }
}