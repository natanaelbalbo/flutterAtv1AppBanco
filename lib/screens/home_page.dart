import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/conta.dart';
import '../screens/adicionar_conta_page.dart';
import '../services/conta_service.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContaService contaService = ContaService("contas");

  List<Conta> contasArray = [];

  void getContas() async {
    var todasContas = await contaService.getAll();
    List<dynamic> contas = [];
    List<Conta> contasObj = [];
    contas = jsonDecode(todasContas);

    for (int i = 0; i < contas.length; i++) {
      contasObj.add(Conta.fromDynamic(contas[i]));
    }

    setState(() {
      contasArray = contasObj;
    });
  }

  void deleteConta(String id) async {
    await contaService.delete(id);
    getContas();
  }

  @override
  void initState() {
    getContas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 170, 191, 182),
        title: const Text(
          "Registro de contas",
          textDirection: TextDirection.ltr,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: contasArray.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            color: const Color.fromARGB(82, 0, 0, 0),
                            width: 1.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Nome da conta: "),
                                Text(contasArray[index].descricao)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Valor: R\$ "),
                                Text(contasArray[index].valor)
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              child: Icon(Icons.edit),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdicionarConta(
                                            conta: contasArray[index],
                                          )),
                                ).then((arg) {
                                  getContas();
                                });
                              },
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            GestureDetector(
                              child: Icon(Icons.delete),
                              onTap: () {
                                deleteConta(contasArray[index].id);
                              },
                            )
                          ],
                        )
                      ],
                    )),
                SizedBox(
                  height: 10.0,
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF00cc73),
        child: Text(
          "+",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdicionarConta()),
          ).then((arg) {
            getContas();
          });
        },
      ),
    );
  }
}
