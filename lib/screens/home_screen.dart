import 'package:api_app_firebase/theme/app_theme.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplicacion APIS'),
        centerTitle: true,
        backgroundColor: AppTheme.primary,
        elevation: 0,
      ),
      body: Center(
         child: Column(
          children: [
            SizedBox(
              height: size.height * 0.1,
            ), 
            const CustomButtonMenu(ruta: 'taxi_d',icono: 'assets/frontal-taxi-cab.png' ,texto: 'Taxis Disponibles'),
            const CustomButtonMenu(ruta: 'conductores',icono: 'assets/taxista.png' ,texto: 'Conductores'),
            const CustomButtonMenu(ruta: 'taxi_s',icono: 'assets/volante.png' ,texto: 'Registrar Conductor'),
          ],
         ),
      ),
    );
  }
}

class CustomButtonMenu extends StatelessWidget {

  final String texto; 
  final String icono;
  final String ruta;
  
  const CustomButtonMenu({
    Key? key, required this.texto, required this.icono, required this.ruta,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, ruta);
        }, 
        style: TextButton.styleFrom(
          backgroundColor: AppTheme.primary,
          minimumSize: const Size(200, 50),
          foregroundColor: Colors.white
        ),
        child: SizedBox(
          width: 250,
          child: Row(
            
            children: [
              ImageIcon(AssetImage(icono)),
              const SizedBox(width: 20),
              Text(texto, style: const TextStyle(color: Colors.white, fontSize: 18),),
            ],
          ),
        )
      ),
    );
  }
}