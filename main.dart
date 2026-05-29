// --- 1. FUNÇÃO PRINCIPAL ---
void main() {
  print("Sistema iniciado com sucesso!");
  print("Recebemos ${dadosTarefas.length} tarefas da nossa API simulada.");

  List<Tarefa> listaDeTarefas = [];

  for (var mapa in dadosTarefas) {
    // Limpeza de textos
    dynamic tituloLimpo = mapa['titulo'] ?? 'Sem título';
    dynamic responsavelLimpo = mapa['responsavel'] ?? 'Sem responsável';
    dynamic statusLimpo =
        (mapa['status'] ?? 'pendente').toString().trim().toLowerCase();

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
  print("Convertemos ${listaDeTarefas.length} tarefas com sucesso!");
  print(
      "O valor da primeira tarefa era texto, agora é o número: ${listaDeTarefas[0].valor}");
  print(
      "A quantidade de horas da segunda tarefa agora é o número: ${listaDeTarefas[1].horas}");
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
