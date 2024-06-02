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
            _botaoReiniciar(),
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
          verificarVencedor();
          verificarEmpate();
        });
      },
      child: Container(
        color: ocupado[index].isEmpty
            ? Colors.black26
            : ocupado[index] == JOGADOR_1
                ? Colors.blue
                : Colors.orange,
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

  _botaoReiniciar() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            inicializarJogo();
          });
        },
        child: const Text("Reiniciar jogo"));
  }

  trocarTurno() {
    if (jogadorAtual == JOGADOR_1) {
      jogadorAtual = JOGADOR_2;
    } else {
      jogadorAtual = JOGADOR_1;
    }
  }

  verificarVencedor() {
    List<List<int>> composicoesVencedoras = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var posicaoVencedora in composicoesVencedoras) {
      String posicao0 = ocupado[posicaoVencedora[0]];
      String posicao1 = ocupado[posicaoVencedora[1]];
      String posicao2 = ocupado[posicaoVencedora[2]];

      if (posicao0.isNotEmpty) {
        if (posicao0 == posicao1 && posicao0 == posicao2) {
          mostrarMensagemJogoEncerrado("Jogador '$posicao0' venceu!");
          jogoAcabou = true;
          return;
        }
      }
    }
  }

  verificarEmpate() {
    if (jogoAcabou) {
      return;
    }
    bool empate = true;
    for (var lugarOcupado in ocupado) {
      if (lugarOcupado.isEmpty) {
        empate = false;
      }
    }

    if (empate) {
      mostrarMensagemJogoEncerrado("Empate!");
      jogoAcabou = true;
    }
  }

  mostrarMensagemJogoEncerrado(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Jogo encerrado \n $mensagem",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
            ),
          )),
    );
  }
}
