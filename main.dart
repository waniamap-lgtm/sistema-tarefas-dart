// --- 1. FUNÇÃO PRINCIPAL ---
void main() {
  print("Sistema iniciado com sucesso!");
  print("Recebemos ${dadosTarefas.length} tarefas da nossa API simulada.");

  List<Tarefa> listaDeTarefas = [];

  for (var mapa in dadosTarefas) {
    // Limpeza de textos
    dynamic tituloLimpo = mapa['titulo'] ?? 'Sem título';
    dynamic responsavelLimpo = mapa['responsavel'] ?? 'Sem responsável';
    dynamic statusLimpo = (mapa['status'] ?? 'pendente')
        .toString()
        .toLowerCase()
        .replaceAll('á', 'a')
        .trim();

    // RF04: Converter valor monetário (Tira 'R$ ', troca ',' por '.' e vira double)
    String valorTexto = (mapa['valor'] ?? '0')
        .toString()
        .replaceAll('R\$ ', '')
        .replaceAll(',', '.');
    double valorLimpo = double.tryParse(valorTexto) ?? 0.0;

    // RF05: Converter horas para número inteiro (int)
    int horasLimpas = int.tryParse((mapa['horas'] ?? '0').toString()) ?? 0;

    // Criamos a nova tarefa com os dados limpos e convertidos
    Tarefa novaTarefa = Tarefa(
      mapa['id'],
      tituloLimpo,
      responsavelLimpo,
      statusLimpo,
      mapa['prioridade'],
      valorLimpo,
      horasLimpas,
    );

    listaDeTarefas.add(novaTarefa);
  }

  // Testes para validar se a matemática funcionou
  // --- RF06: Exibir todas as tarefas convertidas ---
  print('\n--- TODAS AS TAREFAS CONVERTIDAS ---');
  for (var tarefa in listaDeTarefas) {
    print('ID: ${tarefa.id}');
    print('Título: ${tarefa.titulo}');
    print('Responsável: ${tarefa.responsavel}');
    print('Status: ${tarefa.status}');
    print('Prioridade: ${tarefa.prioridade}');
    print('Valor: R\$ ${tarefa.valor}');
    print('Horas: ${tarefa.horas}');
    print('--------------------------'); // Linha para separar as tarefas
  }

  // --- RF07: Filtrar tarefas por status ---
  // O '.where()' age como uma peneira. Ele filtra e guarda apenas o que atende à condição.
  List<Tarefa> concluidas =
      listaDeTarefas.where((tarefa) => tarefa.status == 'concluida').toList();
  List<Tarefa> pendentes =
      listaDeTarefas.where((tarefa) => tarefa.status == 'pendente').toList();

  print('\n--- TAREFAS FILTRADAS ---');
  print('Total de Tarefas Concluídas: ${concluidas.length}');
  print('Total de Tarefas Pendentes: ${pendentes.length}');

  // --- RF08: Somar valores das tarefas concluídas ---
  double somaConcluidas = 0.0;
  for (var tarefa in concluidas) {
    somaConcluidas = somaConcluidas + tarefa.valor;
  }

  // --- RF09: Calcular a média de valor das tarefas pendentes ---
  double somaPendentes = 0.0;
  for (var tarefa in pendentes) {
    somaPendentes = somaPendentes + tarefa.valor;
  }

  // Para evitar erro matemático (dividir por zero), checamos se a lista não está vazia
  double mediaPendentes = 0.0;
  if (pendentes.isNotEmpty) {
    mediaPendentes = somaPendentes / pendentes.length;
  }

  // --- Exibindo os cálculos no relatório ---
  print('\n--- CÁLCULOS FINANCEIROS ---');
  // O '.toStringAsFixed(2)' garante que o número mostre apenas 2 casas decimais (ex: 150.50)
  print(
      'Soma das Tarefas Concluídas: R\$ ${somaConcluidas.toStringAsFixed(2)}');
  print(
      'Média das Tarefas Pendentes: R\$ ${mediaPendentes.toStringAsFixed(2)}');

  // --- RF10: Total de horas por status ---
  int horasConcluidas = 0;
  for (var tarefa in concluidas) {
    // Adicionamos o 'as int' para garantir ao Dart que o valor é um número inteiro
    horasConcluidas += (tarefa.horas as int);
  }
  print('Total de Horas em Tarefas Concluídas: $horasConcluidas horas');

  // --- RF11: Identificar tarefas com dados incompletos ---
  // Vamos buscar tarefas que tenham o título 'Sem título' ou valor 0.0
  print('\n--- TAREFAS COM DADOS INCOMPLETOS ---');
  List<Tarefa> incompletas = listaDeTarefas
      .where((t) => t.titulo == 'Sem título' || t.valor == 0.0)
      .toList();

  for (var t in incompletas) {
    print('ID: ${t.id} - Revisar: ${t.titulo} (Valor: R\$ ${t.valor})');
  }
  // --- RF (Extra): Status Únicos com Set ---
  var statusUnicos = listaDeTarefas.map((t) => t.status).toSet();
  print('\nStatus encontrados no sistema: $statusUnicos');
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
    'horas': '2',
  },
  {
    'id': 2,
    'titulo': 'Criar tela de perfil',
    'responsavel': 'Bruno',
    'status': 'em andamento',
    'prioridade': 'media',
    'valor': 'R\$ 250,50',
    'horas': '5',
  },
  {
    'id': 3,
    'titulo': null,
    'responsavel': 'Carla',
    'status': 'pendente',
    'prioridade': 'baixa',
    'valor': 'R\$ 80,00',
    'horas': null,
  },
  {
    'id': 4,
    'titulo': 'Ajustar navegação',
    'responsavel': null,
    'status': ' concluída ',
    'prioridade': 'alta',
    'valor': 'R\$ 150,75',
    'horas': '3',
  },
  {
    'id': 5,
    'titulo': 'Revisar regras de negócio',
    'responsavel': 'Daniel',
    'status': 'cancelada',
    'prioridade': 'media',
    'valor': 'R\$ 0,00',
    'horas': '0',
  },
  {
    'id': 6,
    'titulo': 'Implementar validação de dados',
    'responsavel': 'Eduarda',
    'status': 'Concluida',
    'prioridade': 'alta',
    'valor': 'R\$ 200,00',
    'horas': '4',
  },
  {
    'id': 7,
    'titulo': 'Organizar documentação',
    'responsavel': 'Felipe',
    'status': 'pendente',
    'prioridade': 'baixa',
    'valor': 'R\$ 90,00',
    'horas': '2',
  }
];

// --- 3. CLASSES (MOLDES) ---

class ItemTrabalho {
  dynamic id;
  dynamic titulo;
  dynamic responsavel;
  dynamic status;

  ItemTrabalho(this.id, this.titulo, this.responsavel, this.status);
}

class Tarefa extends ItemTrabalho {
  dynamic prioridade;
  dynamic valor;
  dynamic horas;

  Tarefa(
    dynamic id,
    dynamic titulo,
    dynamic responsavel,
    dynamic status,
    this.prioridade,
    this.valor,
    this.horas,
  ) : super(id, titulo, responsavel, status);
}
