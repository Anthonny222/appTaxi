import 'dart:convert';

import 'package:api_app_firebase/models/conductores.dart';
import 'package:api_app_firebase/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ConductoresScreen extends StatefulWidget {
   
  const ConductoresScreen({Key? key}) : super(key: key);

  @override
  State<ConductoresScreen> createState() => _ConductoresScreenState();
}

class _ConductoresScreenState extends State<ConductoresScreen> {


  final url = Uri.parse("http://10.0.2.2:8000/conductores");

  late Future <List<Conductores>> conductores;


  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conductores'),
        centerTitle: true,
        backgroundColor: AppTheme.primary,
        elevation: 0,
      ),
      body: FutureBuilder<List<Conductores>>(
        future: conductores,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.separated(
              separatorBuilder:(context, index) => const Divider(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                return ListTile(
                  leading: const CircleAvatar(
                    child: Image(image: AssetImage('assets/avatar_taxi.png')),
                  ),
                  title: Text(snapshot.data![index].nombres, style: const TextStyle(fontSize: 20)),
                  trailing: const Icon(Icons.arrow_circle_right_outlined),
                  onTap: (){
                    return showForm(snapshot.data?[index].cedula, snapshot.data?[index].celular, snapshot.data?[index].nombres);
                  },
                );
                
              },
            );
          }if(snapshot.hasError){
              return const Center(child: Text('Ups hay un error'));
            }
            return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void showForm(cedula, celular, nombres){
    nombres = nombres;
    cedula = cedula;
    celular = celular;
    showDialog
    (context: context, 
    builder: (context){
      return AlertDialog(
        title: Text('$nombres'),
        content: Text('Cedula: $cedula  \nTelefono: $celular' ),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            child: const Text('Aceptar', )
          )
        ],
        
      );
    });
  }


  @override
  void initState() {
    super.initState();
    conductores = getConductores();
  }

  Future<List<Conductores>> getConductores() async {
    final res = await http.get(url); 
    final lista = List.from(jsonDecode(res.body));

    List<Conductores> usuarios = [];

    lista.forEach((element) { 

      final Conductores user = Conductores.fromJson(element);
      usuarios.add(user);

    });

    return usuarios.reversed.toList();

  }


}