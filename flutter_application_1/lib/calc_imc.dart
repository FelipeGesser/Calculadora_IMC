import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraIMC());
}

class CalculadoraIMC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaCalculadoraIMC(),
    );
  }
}

class TelaCalculadoraIMC extends StatefulWidget {
  @override
  _TelaCalculadoraIMCState createState() => _TelaCalculadoraIMCState();
}

class _TelaCalculadoraIMCState extends State<TelaCalculadoraIMC> {
  TextEditingController _controladorPeso = TextEditingController();
  TextEditingController _controladorAltura = TextEditingController();
  double? _imc;
  String _classificacao = '';
  String _mensagemErro = '';

  void _calcularIMC() {
    String textoPeso = _controladorPeso.text;
    String textoAltura = _controladorAltura.text;

    if (textoPeso.isEmpty || textoAltura.isEmpty) {
      setState(() {
        _mensagemErro = 'Valores não inseridos.';
        _imc = null;
        _classificacao = '';
      });
      return;
    }

    double? peso = double.tryParse(textoPeso);
    double? altura = double.tryParse(textoAltura);

    if (peso == null || altura == null) {
      setState(() {
        _mensagemErro = 'Valor inválido';
        _imc = null;
        _classificacao = '';
      });
      return;
    }

    altura = altura / 100;

    setState(() {
      _imc = peso / (altura! * altura);
      _mensagemErro = '';
      if (_imc! < 18.5) {
        _classificacao = 'Baixo peso';
      } else if (_imc! >= 18.5 && _imc! < 24.9) {
        _classificacao = 'Peso normal';
      } else if (_imc! >= 25 && _imc! < 29.9) {
        _classificacao = 'Sobrepeso';
      } else {
        _classificacao = 'Obesidade';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controladorPeso,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
                errorText: _mensagemErro.isNotEmpty ? _mensagemErro : null,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _controladorAltura,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Altura (cm)',
                errorText: _mensagemErro.isNotEmpty ? _mensagemErro : null,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularIMC,
              child: Text('Calcular IMC'),
            ),
            SizedBox(height: 20),
            if (_imc != null)
              Text(
                'Seu IMC: ${_imc!.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24),
              ),
            SizedBox(height: 10),
            if (_classificacao.isNotEmpty)
              Text(
                'Classificação: $_classificacao',
                style: TextStyle(fontSize: 24),
              ),
          ],
        ),
      ),
    );
  }
}