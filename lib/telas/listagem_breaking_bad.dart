import 'dart:convert';

import 'package:app_consume/data/personagem_api.dart';
import 'package:app_consume/models/personagem.dart';
import 'package:flutter/material.dart';

class ListaPersonagens extends StatefulWidget {
  const ListaPersonagens({Key? key}) : super(key: key);

  @override
  State<ListaPersonagens> createState() => _ListaPersonagensState();
}

class _ListaPersonagensState extends State<ListaPersonagens> {
  List<Personagem> personagensLista = <Personagem>[];

  void getPersonagensFromApi() async {
    var response = await PersonagemAPI.getPersonagens();
    setState(() {
      Iterable lista = json.decode(response.body);
      personagensLista =
          lista.map((model) => Personagem.fromJson(model)).toList();
    });
  }

  @override
  void initState() {
    getPersonagensFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personagens do BREAKING BAD',
        ),
      ),
      body: ListView.builder(
        itemCount: personagensLista.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(personagensLista[index].name),
            subtitle: Text(personagensLista[index].nickname),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(personagensLista[index].img),
            ),
            onLongPress: () {},
          );
        },
      ),
    );
  }
}
