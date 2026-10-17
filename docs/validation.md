# Registro de validação

## Atualização: desenvolvimento da v2, etapa 4

- SHL A adicionado em `110`: deslocamento de uma posição à esquerda, inserindo zero e descartando o bit superior. Ignora `b`; carry e borrow ficam zerados.
- Referência do testbench: `(a * 2) % 4`, exercitada com todos os valores de `b`; operações anteriores e código reservado `111` continuam verificados.
- Simulação desta etapa: pendente no GitHub Actions; resultado esperado `PASS: 256 checks`.
- Síntese e atualização do esquema desta etapa: pendentes.

## Atualização: desenvolvimento da v2, etapa 3

- NOT A adicionado em `101`: inversão dos dois bits de `a`, independente de `b`, com carry e borrow zerados.
- Referência do testbench: `3 - a`, verificada para todos os valores de `a` e `b`, mantendo os testes das operações anteriores e dos códigos reservados `110` e `111`.
- Simulação da etapa 3: aprovada; o usuário forneceu `PASS: 256 checks` e encerramento normal em `tb_mini_alu.v:61`.
- Síntese e atualização do esquema desta etapa: pendentes.

## Atualização: desenvolvimento da v2, etapa 2

- Subtração adicionada em `100`, com resultado módulo 4 e `borrow = 1` quando `a < b`.
- `carry` permanece exclusivo da soma; `borrow` é zerado nas demais operações.
- O testbench verifica resultado, carry e borrow nas 128 combinações, em duas ordens: 256 verificações esperadas. Inclui todos os casos de empréstimo e transições para operações sem empréstimo.
- Simulação da etapa 2: aprovada no GitHub Actions; o usuário forneceu o log `PASS: 256 checks` com encerramento normal do testbench.
- Síntese e atualização do esquema desta etapa: pendentes.

## Atualização: desenvolvimento da v2, etapa 1

- Versão anterior: o usuário confirmou no GitHub Actions `PASS: 128 checks`; lint aprovado e esquema gerado no Vulkos.
- Mudança atual: seletor `op` ampliado para 3 bits. Operações 000–011 preservadas; códigos 100–111 retornam resultado e carry iguais a zero.
- Testbench atualizado para 128 combinações nos dois sentidos, totalizando 256 verificações esperadas.
- Simulação da etapa 1: aprovada no GitHub Actions; o usuário forneceu o log `PASS: 256 checks`.
- O esquema salvo corresponde à versão anterior e deverá ser regenerado para a nova interface.

## Registro original de preparação

- Implementação e testbench preparados.
- Revisão manual: operandos da soma estendidos para 3 bits; carry zerado nas operações lógicas; todas as saídas atribuídas em todos os caminhos.
- Simulação HDL: pendente. Icarus Verilog não está disponível no ambiente de preparação.
- Síntese e teste interativo no Vulkos: pendentes.
- Publicação e execução no GitHub Actions: pendentes.

Após executar, registre data, ferramenta, resultado e evidências. Não confundir valores esperados com resultados medidos.
