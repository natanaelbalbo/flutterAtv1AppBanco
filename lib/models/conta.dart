class Conta {
  String id;
  String descricao;
  String valor;

  Conta({required this.id, required this.descricao, required this.valor});

  factory Conta.fromDynamic(dynamic json) {
    return Conta(
      id: json['id'] as String,
      descricao: json['descricao'] as String,
      valor: json['val'] as String,
    );
  }
}
