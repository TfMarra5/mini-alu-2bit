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
| carry | Saída | 1 | Vai um da soma; zero nas demais operações |
| borrow | Saída | 1 | Empréstimo da subtração quando a < b; zero nas demais operações |
| zero | Saída | 1 | Vale 1 quando result = 00, em qualquer operação |

O indicador `zero` considera apenas os dois bits de `result`, independentemente de `carry` e `borrow`. Por exemplo, `3 + 1` produz `result = 00`, `carry = 1`, `borrow = 0` e `zero = 1`. Já `0 - 1` produz `result = 11` e `zero = 0`.

| op | Operação | Exemplo com a=11 e b=01 | result | carry |
| --- | --- | --- | --- | --- |
| 000 | Soma | 3 + 1 = 4 | 00 | 1 |
| 001 | AND bit a bit | 11 AND 01 | 01 | 0 |
| 010 | OR bit a bit | 11 OR 01 | 11 | 0 |
| 011 | XOR bit a bit | 11 XOR 01 | 10 | 0 |
| 100 | Subtração | 3 - 1 = 2 | 10 | 0 |
| 101 | NOT A bit a bit | NOT 11 | 00 | 0 |
| 110 | Deslocamento de A à esquerda | 11 << 1 | 10 | 0 |
| 111 | Deslocamento de A à direita | 11 >> 1 | 01 | 0 |

Todos os oito códigos de `op` têm uma operação definida. A interface usa `op` de 3 bits e inclui a nova saída `borrow`. O esquema salvo da versão 1 não representa as operações novas.

SHR A desloca `a` uma posição à direita, insere zero à esquerda e descarta o bit menos significativo: `00 → 00`, `01 → 00`, `10 → 01`, `11 → 01`. É um deslocamento lógico sem sinal, não uma rotação. Ignora `b` e mantém `carry` e `borrow` em zero.

SHL A desloca `a` uma posição à esquerda, insere zero à direita e descarta o bit mais significativo: `00 → 00`, `01 → 10`, `10 → 00`, `11 → 10`. A operação ignora `b` e mantém `carry` e `borrow` em zero; não é uma rotação nem usa `b` como quantidade de deslocamento.

NOT A inverte os dois bits de `a` e ignora `b`: `00 → 11`, `01 → 10`, `10 → 01`, `11 → 00`. `carry` e `borrow` ficam em zero. É uma inversão bit a bit (`~a`), não uma negação lógica (`!a`). Os testes exercitam cada valor de `a` com todos os valores de `b`.

Na subtração, `result` representa `(a - b) módulo 4`; `borrow` vale 1 quando `a < b`. Por exemplo, `0 - 1` produz `result = 11`, `borrow = 1` e `carry = 0`. Em todas as linhas de exemplo da tabela, `borrow = 0`. Ele indica empréstimo, não um bit de sinal.

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
4. Teste as oito linhas da tabela acima e o caso `0 - 1`, ajustando os bits das entradas no circuito.
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
