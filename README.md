# Mini ALU de 2 bits

Projeto educacional de uma unidade lógica e aritmética em Verilog para explorar a transformação de código em portas lógicas no Vulkos.

## Funcionamento

O circuito é combinacional: não usa clock nem reset. As saídas dependem das entradas atuais, após o tempo de propagação. `a` e `b` representam números sem sinal de 0 a 3.

| Sinal | Direção | Bits | Função |
| --- | --- | --- | --- |
| a | Entrada | 2 | Primeiro operando |
| b | Entrada | 2 | Segundo operando |
| op | Entrada | 3 | Seleção da operação |
| result | Saída | 2 | Resultado |
| carry | Saída | 1 | Vai um da soma; zero nas operações lógicas |

| op | Operação | Exemplo com a=11 e b=01 | result | carry |
| --- | --- | --- | --- | --- |
| 000 | Soma | 3 + 1 = 4 | 00 | 1 |
| 001 | AND bit a bit | 11 AND 01 | 01 | 0 |
| 010 | OR bit a bit | 11 OR 01 | 11 | 0 |
| 011 | XOR bit a bit | 11 XOR 01 | 10 | 0 |

Os códigos `100`, `101`, `110` e `111` estão reservados e produzem `result = 00` e `carry = 0`. Nesta etapa, `op` passa de 2 para 3 bits; as entradas que selecionam a operação precisam ser atualizadas. A imagem em `docs/mini-alu-schematic.png` corresponde à versão anterior.

Na soma, `{carry, result}` é o resultado completo de 3 bits, entre 0 e 6. `carry` não é um indicador de overflow com sinal.

## Arquivos

- `mini_alu.v`: circuito sintetizável.
- `tb_mini_alu.v`: teste das 128 combinações, percorridas nos dois sentidos, totalizando 256 verificações.
- `.github/workflows/test.yml`: simulação automática no GitHub Actions.
- `docs/validation.md`: registro do que foi ou ainda precisa ser verificado.

## No Vulkos

1. Crie um projeto em **Verilog to gates**, usando **Empty file**.
2. Cole o conteúdo de `mini_alu.v` no editor, substituindo o exemplo inteiro.
3. Clique em **synthesize** e confirme que o módulo construído é `mini_alu`.
4. Teste as quatro linhas da tabela acima, ajustando os bits das entradas no circuito.
5. Observe as portas e salve uma captura em `docs/` para documentar o resultado.

O testbench é exclusivo para simulação: não o cole no arquivo que será sintetizado. A aparência e quantidade de portas dependem das otimizações da ferramenta. O esquema de portas não é um layout físico de fabricação.

## Testes automáticos

Com Icarus Verilog instalado, execute na pasta do projeto:

```sh
iverilog -g2012 -Wall -s tb_mini_alu -o sim mini_alu.v tb_mini_alu.v
vvp sim
```

O resultado esperado é `PASS: 256 checks`. A simulação também gera `mini_alu.vcd`, que pode ser aberto em um visualizador de formas de onda. Uma divergência encerra a simulação com erro.

## Publicação no GitHub

Crie um repositório chamado `mini-alu-2bit` e envie o conteúdo desta pasta, incluindo `.github/workflows/test.yml`. A aba **Actions** mostrará o resultado da simulação após o envio, se Actions estiver habilitado. Consulte `docs/validation.md` antes de declarar os testes aprovados.

Licença de reutilização ainda a definir pelo autor; nenhuma licença foi atribuída automaticamente.
