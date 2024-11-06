import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import '../models/conta.dart';
import '../services/conta_service.dart';

class AdicionarConta extends StatefulWidget {
  Conta? conta;

  AdicionarConta({this.conta, super.key});

  @override
  _AdicionarContaState createState() => _AdicionarContaState();
}

class _AdicionarContaState extends State<AdicionarConta> {
  ContaService contaService = ContaService("contas");

  TextEditingController descricao = TextEditingController();
  TextEditingController valor = TextEditingController();

  String buttonText = "";

  Future<void> add() async {
    if (widget.conta != null) {
      var update = {'descricao': descricao.text, 'val': valor.text};
      await contaService.update(widget.conta!.id, update);
    } else {
      String desc = descricao.text;
      String val = valor.text;

      if (desc.isNotEmpty) {
        var conta = {'descricao': desc, 'val': val};

        await contaService.create(conta);
      }
    }
  }

  @override
  void initState() {
    if (widget.conta != null) {
      buttonText = "Atualizar";
      descricao.text = widget.conta!.descricao;
      valor.text = widget.conta!.valor;
    } else {
      buttonText = "Cadastrar";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00cc73),
        title: const Text(
          "Adicionar conta",
          textDirection: TextDirection.ltr,
          style: TextStyle(color: Colors.white),
        ),
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 30.0,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome da conta',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2.0),
                ),
              ),
              controller: descricao,
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Valor da conta (R\$)',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2.0),
                ),
              ),
              inputFormatters: [
                CurrencyTextInputFormatter.currency(
                  locale: 'pt-br',
                  decimalDigits: 2,
                  symbol: '',
                ),
              ],
              controller: valor,
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Expanded(
                    child: Material(
                  color: Color(0xFF00cc73),
                  borderRadius: BorderRadius.circular(15.0),
                  child: InkWell(
                    onTap: () async {
                      await add();
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(15.0),
                    child: GestureDetector(
                      onLongPress: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Tap'),
                        ));
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              buttonText,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
