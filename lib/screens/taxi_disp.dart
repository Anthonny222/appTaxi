import 'dart:convert';

import 'package:api_app_firebase/models/conductores.dart';
import 'package:api_app_firebase/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class TaxiDisponibleScreen extends StatefulWidget {
   
  const TaxiDisponibleScreen({Key? key}) : super(key: key);

  @override
  State<TaxiDisponibleScreen> createState() => _TaxiDisponibleScreenState();
}

class _TaxiDisponibleScreenState extends State<TaxiDisponibleScreen> {

  final url = Uri.parse("http://10.0.2.2:8000/conductores");

  late Future <List<Conductores>> conductores;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taxis Disponibles'),
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
                    child: Image(image: AssetImage('assets/taxi.png')),
                  ),
                  title: Text(snapshot.data![index].nombres, style: const TextStyle(fontSize: 20)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 7),
                        child: Row(children: [
                            Text('Placa: ${snapshot.data![index].placa}'),
                            const SizedBox(width: 40),
                            Text('Celular: ${snapshot.data![index].celular}')
                          ],
                        ),
                      ),
                      Text('Tiempo de llegada: ${snapshot.data![index].tiempo}')
                    ],
                  ),
                  trailing: const Icon(Icons.add_circle_outline),
                  onTap: (){
                    return showForm(
                      snapshot.data![index].placa, 
                      snapshot.data![index].cedula, 
                      snapshot.data![index].nombres, 
                      snapshot.data![index].celular, 
                      snapshot.data![index].tiempo
                    );
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

  void showForm(placa, cedula, nombres, celular, tiempo){
    nombres = nombres;
    placa = placa;
    cedula = cedula;
    celular = celular; 
    tiempo = tiempo;
    showDialog
    (context: context, 
    builder: (context){
      return AlertDialog(
        title: Text('Aceptar Conductor ($nombres)'),
        content: Text('¿Desea aceptar esta carrera? \n \nPlacas: $placa \nCedula: $cedula \nCelular: $celular' ),
        actions: [
          TextButton(
            onPressed: (){
              
              Navigator.pop(context);
            }, 
            child: const Text('Cancelar', style: TextStyle(color: Colors.redAccent),)
          ),
          TextButton(
            onPressed: (){

              final snackBar = SnackBar(
                content: Text('Tiempo de llegada $tiempo minutos       |       $nombres en camino'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    conductores = getUsuario();
  }

  Future<List<Conductores>> getUsuario() async {
    final res = await http.get(url); 
    final lista = List.from(jsonDecode(res.body));

    List<Conductores> conductores = [];

    lista.forEach((element) { 

      final Conductores user = Conductores.fromJson(element);
      conductores.add(user);

    });

    return conductores;
  }

}