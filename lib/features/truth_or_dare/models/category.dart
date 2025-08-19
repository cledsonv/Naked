enum CategoryLevel { romantic, intimate, passionate, wild }

class TruthOrDareCategory {
  final String title;
  final String description;
  final String details;
  final CategoryLevel level;
  final List<String> features;

  const TruthOrDareCategory({
    required this.title,
    required this.description,
    required this.details,
    required this.level,
    required this.features,
  });

  static const List<TruthOrDareCategory> categories = [
    TruthOrDareCategory(
      title: 'Romântico',
      description: 'Para começar com carinho e conexão',
      details:
          'Perguntas e desafios suaves que promovem intimidade emocional e momentos românticos entre o casal.',
      level: CategoryLevel.romantic,
      features: [
        'Perguntas sobre sentimentos',
        'Desafios carinhosos',
        'Momentos de conexão',
        'Ideal para começar',
      ],
    ),
    TruthOrDareCategory(
      title: 'Íntimo',
      description: 'Aprofundando a conexão entre vocês',
      details:
          'Questões mais pessoais e desafios que exploram a intimidade física e emocional de forma respeitosa.',
      level: CategoryLevel.intimate,
      features: [
        'Toques mais íntimos',
        'Conversas profundas',
        'Descobertas mútuas',
        'Confiança elevada',
      ],
    ),
    TruthOrDareCategory(
      title: 'Apaixonado',
      description: 'Para casais que querem mais intensidade',
      details:
          'Desafios e verdades que elevam a temperatura e criam momentos mais intensos e apaixonados.',
      level: CategoryLevel.passionate,
      features: [
        'Alta temperatura',
        'Sedução intensa',
        'Fantasias reveladas',
        'Momento a dois',
      ],
    ),
    TruthOrDareCategory(
      title: 'Selvagem',
      description: 'Para os mais aventureiros e ousados',
      details:
          'O nível mais intenso com desafios ousados e verdades provocantes para casais que querem experimentar tudo.',
      level: CategoryLevel.wild,
      features: [
        'Máxima ousadia',
        'Sem limites',
        'Experiências únicas',
        'Apenas para corajosos',
      ],
    ),
  ];
}
