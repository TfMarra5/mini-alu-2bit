# Registro de validação

## Atualização: desenvolvimento da v2, etapa 1

- Versão anterior: o usuário confirmou no GitHub Actions `PASS: 128 checks`; lint aprovado e esquema gerado no Vulkos.
- Mudança atual: seletor `op` ampliado para 3 bits. Operações 000–011 preservadas; códigos 100–111 retornam resultado e carry iguais a zero.
- Testbench atualizado para 128 combinações nos dois sentidos, totalizando 256 verificações esperadas.
- Simulação desta etapa: pendente; Icarus Verilog não está instalado neste ambiente. O resultado da versão anterior não valida este novo código.
- O esquema salvo corresponde à versão anterior e deverá ser regenerado para a nova interface.

## Registro original de preparação

- Implementação e testbench preparados.
- Revisão manual: operandos da soma estendidos para 3 bits; carry zerado nas operações lógicas; todas as saídas atribuídas em todos os caminhos.
- Simulação HDL: pendente. Icarus Verilog não está disponível no ambiente de preparação.
- Síntese e teste interativo no Vulkos: pendentes.
- Publicação e execução no GitHub Actions: pendentes.

Após executar, registre data, ferramenta, resultado e evidências. Não confundir valores esperados com resultados medidos.
