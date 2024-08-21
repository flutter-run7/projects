
import 'package:biogenius4/models/questions.dart';





final List<Question> module1Questions = [
  Question(
    text: 'Qual é a principal função dos ribossomos?',
    options: [
     '0) Reprodução celular',
      '1) Produção de Energia',
      '2) Síntese de Proteínas',
      '3) Transporte de Nutrientes',
      '4) Degradação de Toxinas'
    ],
    correctAnswerIndex:2 // Índice da resposta correta (começando em 0)
  ),
  Question(text: 'Qual dos seguintes organismos é um procarionte?'
      , options: [
        '0)Fungos',
        '1)Plantas',
        '2) Bactérias',
        '3) Protozoários',
        '4) Vírus'], correctAnswerIndex:2),
  
 Question(text: 'Qual é o principal componente da parede celular das bactérias Gram-positivas?',
     options: [
       '0) Quitina',
     '1) Celulose',
     '2) Peptidoglicano',
     '3) Lignina',
     '4) Glicoproteína'], correctAnswerIndex:2),

  Question(text: 'Qual das seguintes estruturas permite que as bactérias se movam?',
      options: [
        '0) Pili',
        '1) Fímbrias',
         '2) Ribossomos',
         '3) Flagelos',
        '4) Nucleóides'
      ], correctAnswerIndex:3),
  
  Question(text: 'O que é uma plasmídio?', options: [
    '0) Uma organela celular',
    '1) Um segmento de RNA',
    '2) Uma proteína de membrana',
    '3) Um pequeno DNA circular extra-cromossômico',
    '4) Uma enzima de replicação'
  ], correctAnswerIndex:3),
  
  Question(text: 'Qual é o agente causador da tuberculose?', options: [
    '0) Streptococcus pneumoniae',
    '1) Mycobacterium tuberculosis',
    '2) Escherichia coli',
    '3) Clostridium botulinum',
    '4) Salmonella Typhi'
  ], correctAnswerIndex:1),

  Question(text: 'Qual é a principal diferença entre bactérias Gram-positivas e Gram-negativas?',
      options: [
        '0) Presença de núcleo',
        '1) Tipo de Ribossomos',
        '2) Composição da parede celular',
        '3) Forma das células',
        '4) Capacidade de Fotossíntese'
      ], correctAnswerIndex:2),
  
  Question(text: 'Qual dos seguintes é um exemplo de um antibiótico que inibe a síntese da parede celular bacteriana?',
      options: [ '0) Tetraciclina',
        '1) Rifampicina',
        '2) Ciprofloxacino',
        '3) Penicilina',
        '4) Cloranfenicol'

  ], correctAnswerIndex:3),
  
  Question(text: 'O que é um bacteriófago?',
      options: [
    '0) Um tipo de bactéria',
        '1) Uma enzima bacteriana',
        '2) Um vírus que infecta bactérias',
        '3) Uma toxina bacteriana',
        '4) Um plasmídeo'
  ], correctAnswerIndex:2),
  
  Question(text: 'Qual dos seguintes processos descreve a transferência de DNA entre bactérias via contato direto?',
      options: [
        '0) Transformação',
        '1) Transdução',
        '2) Conjugação',
        '3) Mutação',
        '4) Tradução'
      ], correctAnswerIndex:2),
  
  Question(text: 'Qual é a função da cápsula em algumas bactérias?',
      options: [
        '0) Produzir energia',
        '1) Realizar fotossíntese',
        '2) Proteger contra fagocitose',
        '3) Realizar a síntese de proteínas'
        '4) Facilitar a locomoção'
      ], correctAnswerIndex:2),

  Question(text: 'Qual dos seguintes é um exemplo de um vírus de RNA?',
      options: [
        '0) Herpes Simplex',
        '1) Papilomavírus humano',
        '2) Hepatite B',
        '3) Vírus da gripe',
        '4) Adenovírus'
      ], correctAnswerIndex:3),
  
  Question(text: 'O que é um esporo bacteriano?',
      options: [
        '0) Uma forma de reprodução sexual',
        '1) Um mecanismo de locomoção',
        '2) Um estado dormente resistente a condições adversas',
        '3) Um organelo envolvido na fotossíntese',
        '4) Uma toxina produzida por algumas bactérias'
      ], correctAnswerIndex:2),
  // Adicione as outras perguntas do módulo 1 aqui...
];
