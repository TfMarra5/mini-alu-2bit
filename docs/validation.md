# Registro de validação

## Atualização: desenvolvimento da v2, etapa 2

- Subtração adicionada em `100`, com resultado módulo 4 e `borrow = 1` quando `a < b`.
- `carry` permanece exclusivo da soma; `borrow` é zerado nas demais operações.
- O testbench verifica resultado, carry e borrow nas 128 combinações, em duas ordens: 256 verificações esperadas. Inclui todos os casos de empréstimo e transições para operações sem empréstimo.
- Simulação desta etapa: pendente de execução no GitHub Actions. O sucesso da etapa 1 não valida a nova subtração.
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
