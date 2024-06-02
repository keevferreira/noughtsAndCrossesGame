import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const String JOGADOR_1 = "X";
  static const String JOGADOR_2 = "O";

  late String jogadorAtual;
  late bool jogoAcabou;
  late List<String> ocupado;

  @override
  void initState() {
    super.initState();
    inicializarJogo();
  }

  void inicializarJogo() {
    jogadorAtual = JOGADOR_1;
    jogoAcabou = false;
    ocupado = ["", "", "", "", "", "", "", "", ""];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _textoCabecalho(),
            _gameContainer(),
          ],
        ),
      ),
    );
  }

  Widget _textoCabecalho() {
    return Column(
      children: [
        const Text(
          "Jogo da Velha",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Vez do $jogadorAtual",
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Widget _gameContainer() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.height / 2,
      margin: const EdgeInsets.all(8),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemCount: 9,
          itemBuilder: (context, int index) {
            return _box(index);
          }),
    );
  }

  Widget _box(int index) {
    return InkWell(
      onTap: () {
        if (jogoAcabou || ocupado[index].isNotEmpty) {
          return;
        }

        setState(() {
          ocupado[index] = jogadorAtual;
          trocarTurno();
        });
      },
      child: Container(
        color: Colors.black26,
        margin: const EdgeInsets.all(8),
        child: Center(
          child: Text(
            ocupado[index],
            style: const TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }

  trocarTurno() {
    if (jogadorAtual == JOGADOR_1) {
      jogadorAtual = JOGADOR_2;
    } else {
      jogadorAtual = JOGADOR_1;
    }
  }
}
