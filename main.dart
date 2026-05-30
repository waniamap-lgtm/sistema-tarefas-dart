// --- 3. CLASSES (MOLDES) ---
class ItemTrabalho {
  dynamic id;
  dynamic titulo;
  dynamic responsavel;
  dynamic status;

  ItemTrabalho(this.id, this.titulo, this.responsavel, this.status);

  void exibirDetalhes() => print("Item: $titulo");
}

// RF13: Herança e Polimorfismo
class Tarefa extends ItemTrabalho {
  dynamic prioridade;
  dynamic valor;
  dynamic horas;
  // RF14: Encapsulamento
  dynamic _status;

  Tarefa(dynamic id, dynamic titulo, dynamic responsavel, dynamic status,
      this.prioridade, this.valor, this.horas)
      : _status = status,
        super(id, titulo, responsavel, status);

  @override
  dynamic get status => _status;

  @override
  void exibirDetalhes() => print("Tarefa: $titulo (Status: $status)");
}

// --- 2. BASE DE DADOS SIMULADA ---
final List<Map<String, dynamic>> dadosTarefas = [
  {
    'id': 1,
    'titulo': 'Corrigir bug login',
    'responsavel': 'Ana',
    'status': 'concluida',
    'prioridade': 'alta',
    'valor': 'R\$ 120,00',
    'horas': '2'
  },
  {
    'id': 2,
    'titulo': 'Criar tela de perfil',
    'responsavel': 'Bruno',
    'status': 'em andamento',
    'prioridade': 'media',
    'valor': 'R\$ 250,50',
    'horas': '5'
  },
  {
    'id': 3,
    'titulo': null,
    'responsavel': 'Carla',
    'status': 'pendente',
    'prioridade': 'baixa',
    'valor': 'R\$ 80,00',
    'horas': null
  },
  {
    'id': 4,
    'titulo': 'Ajustar navegação',
    'responsavel': null,
    'status': ' concluída ',
    'prioridade': 'alta',
    'valor': 'R\$ 150,75',
    'horas': '3'
  },
  {
    'id': 5,
    'titulo': 'Revisar regras de negócio',
    'responsavel': 'Daniel',
    'status': 'cancelada',
    'prioridade': 'media',
    'valor': 'R\$ 0,00',
    'horas': '0'
  },
  {
    'id': 6,
    'titulo': 'Implementar validação de dados',
    'responsavel': 'Eduarda',
    'status': 'Concluida',
    'prioridade': 'alta',
    'valor': 'R\$ 200,00',
    'horas': '4'
  },
  {
    'id': 7,
    'titulo': 'Organizar documentação',
    'responsavel': 'Felipe',
    'status': 'pendente',
    'prioridade': 'baixa',
    'valor': 'R\$ 90,00',
    'horas': '2'
  }
];

// --- 1. FUNÇÃO PRINCIPAL ---
void main() {
  print("Sistema iniciado com sucesso!");
  List<Tarefa> listaDeTarefas = [];

  for (var mapa in dadosTarefas) {
    String tituloLimpo = (mapa['titulo'] ?? 'Sem título').toString();
    String statusBruto =
        (mapa['status'] ?? 'pendente').toString().trim().toLowerCase();

    // RECOMENDADO: Switch-case para classificação avançada
    String statusClassificado;
    switch (statusBruto) {
      case 'concluida':
      case 'concluida ':
        statusClassificado = 'concluida';
        break;
      case 'pendente':
        statusClassificado = 'pendente';
        break;
      case 'em andamento':
        statusClassificado = 'em andamento';
        break;
      case 'cancelada':
        statusClassificado = 'cancelada';
        break;
      default:
        statusClassificado = 'pendente';
    }

    double valor = double.tryParse((mapa['valor'] ?? '0')
            .toString()
            .replaceAll('R\$ ', '')
            .replaceAll(',', '.')) ??
        0.0;
    int horas = int.tryParse((mapa['horas'] ?? '0').toString()) ?? 0;

    listaDeTarefas.add(Tarefa(
        mapa['id'],
        tituloLimpo,
        mapa['responsavel'] ?? 'Sem responsável',
        statusClassificado,
        mapa['prioridade'],
        valor,
        horas));
  }

  // Cálculos
  var concluidas =
      listaDeTarefas.where((t) => t.status == 'concluida').toList();
  var pendentes = listaDeTarefas.where((t) => t.status == 'pendente').toList();
  double somaConcluidas = concluidas.fold(0, (sum, item) => sum + item.valor);
  double somaPendentes = pendentes.fold(0, (sum, item) => sum + item.valor);
  int horasConcluidas =
      concluidas.fold(0, (sum, item) => sum + (item.horas as int));
  var statusUnicos = listaDeTarefas.map((t) => t.status).toSet();

  // RF15: Relatório Final
  print('\n=======================================');
  print('      RELATÓRIO FINAL DE TAREFAS        ');
  print('=======================================');
  print('Total de tarefas analisadas: ${listaDeTarefas.length}');
  print('Valor total das concluídas: R\$ ${somaConcluidas.toStringAsFixed(2)}');

  if (pendentes.isEmpty) {
    print('Média de valor das pendentes: R\$ 0.00');
  } else {
    print(
        'Média de valor das pendentes: R\$ ${(somaPendentes / pendentes.length).toStringAsFixed(2)}');
  }

  print('Total de horas concluídas: $horasConcluidas horas');
  print('\nStatus encontrados: $statusUnicos');

  // RF11: Identificar tarefas incompletas
  print('\nTarefas com dados incompletos:');
  for (var t in listaDeTarefas) {
    // RECOMENDADO: Operador Ternário
    String mensagem =
        (t.titulo == 'Sem título' || t.valor == 0.0 || t.horas == 0)
            ? 'ID ${t.id} - Incompleta (${t.titulo})'
            : 'ID ${t.id} - OK';
    if (t.titulo == 'Sem título' || t.valor == 0.0 || t.horas == 0) {
      print(mensagem);
    }
  }
  print('=======================================');
}
