# Alimento
É o cerne da dieta e do algoritmo. Armazena valores quantitativos pré-definidos sobre a composição de um certo alimento, bem como seu nome, descrição e imagem.

A classificação dos nutrientes deve ser separada em dois grupos, um para os macronutrientes e fibras e outro grupo para os cofatores e elementos traço.

Os nutrientes da composição são:
	- CHO;
	- PTN;
	- LIP;
	- Fibras;
	- Sódio;
	- Potássio;
	- Vitamina B1;
	- Vitamina B3;
	- Vitamina C;
	- Vitamina E;

# Algoritmo De Score de Dieta
É a principal do jogo, um algoritmo que recebe dados referentes à dieta dos atletas, toda planejada pelo jogador (nutricionista).

Dividi a pontuação em dois tópicos importantes: **performance esportiva** e **nível de estresse oxidativo.**

- ## Performance Esportiva
Analisa o volume de alimento (quantas proteínas, lipídios e fibras foram prescritas) por refeição para calcular uma classificação, também qualitativa, de fome do atleta naquela refeição e a quantidade de carboidratos que se torna disponível para o atleta praticar suas atividades profissionais.

O score desse tópico é calculado por refeição, mas o geral será calculado a partir da dieta.

- ## Nível de Saúde Geral
Analisa a quantidade de fibras, vitaminas e minerais que atuam para modular a saúde do atleta enquanto ele segue a vida profissional e segue a dieta prescrita.

É bom enfatizar o valor desses nutrientes no score final dentro da dieta quando o jogador receber o feedback do seu cardápio.

A performance esportiva é estudada ao ponto de nos fornecer valores qualitativos para guiar o
profissional nutricionista em como prescrever boas dietas, dessa forma,

O algoritmo que tenta avaliar a composição de uma dieta, precisa seguir guidelines preconizadas para cada esporte e traduzir as recomendações em fórmulas matemáticas. Dessa forma, pensei em começar considerando um teto (que para esportistas profissionais é o VCT) e já que é um protótipo, é possível utilizar um inteiro para simbolizar a quantidade de alimentos máximos, dentro uma única dieta, que um jogador pode prescrever e outro inteiro simbolizando a quantidade de alimentos repetidos dentro da dieta. Esses passos podem aproximar as demandas de um esportista no nosso jogo, das demandas de um esportista real.