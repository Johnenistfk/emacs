# Emacs — Configuração Minimalista para Clojure, Python & Bancos de Dados

Configuração do Emacs focada em produtividade para desenvolvimento Clojure, Python e trabalho com bancos de dados (SQL/JSON), com Evil Mode, CIDER REPL, LSP via Eglot, autocomplete via Corfu e Projectile.

---

## Dependências Externas

Antes de usar, instale as seguintes ferramentas no sistema:

| Ferramenta | Finalidade | Instalação |
|------------|------------|------------|
| `clojure-lsp` | LSP para Clojure | [clojure-lsp.io](https://clojure-lsp.io) |
| `pyright` | LSP para Python | `npm install -g pyright` |
| `sqls` | LSP para SQL | `go install github.com/lighttiger2505/sqls@latest` |
| `leiningen` | Gerenciador de projetos Clojure | [leiningen.org](https://leiningen.org) |
| `vterm` | Terminal integrado | Requer `libvterm`, `cmake` e `libtool` na compilação |

> Alternativa ao `pyright`: `python-lsp-server` (`pip install python-lsp-server`), trocando `pyright-langserver` por `pylsp` na config.

---

## Instalação

```bash
# Clone o repositório
git clone https://github.com/Johnenistfk/emacs.git ~/.config/emacs

# Inicie o Emacs — os pacotes serão instalados automaticamente
emacs
```

Na primeira inicialização o Emacs baixa e instala todos os pacotes automaticamente. Aguarde a conclusão antes de abrir qualquer arquivo.

> **Importante:** certifique-se de que não existe uma configuração antiga em `~/.emacs.d`, pois o Emacs prioriza esse caminho sobre `~/.config/emacs`. Renomeie ou remova `~/.emacs.d` antes de usar esta configuração.

---

## Conceitos Básicos — Evil Mode

O Evil Mode emula o Vim dentro do Emacs. Existem três estados principais:

| Estado | Ativação | Finalidade |
|--------|----------|------------|
| Normal | `ESC` ou `C-c` | Navegação e atalhos de leader key |
| Insert | `i` | Digitação e edição de texto |
| Visual | `v` / `V` | Seleção de caracteres ou linhas |

> **Regra de ouro:** todos os atalhos com `SPC` funcionam a partir do Normal Mode.

---

## Navegação

### Movimento do Cursor

| Tecla | Movimento |
|-------|-----------|
| `h` | Esquerda |
| `j` | Baixo |
| `k` | Cima |
| `l` | Direita |
| `w` | Próxima palavra |
| `b` | Palavra anterior |
| `0` | Início da linha |
| `$` | Final da linha |
| `gg` | Início do arquivo |
| `G` | Final do arquivo |
| `C-u` | Rola meia tela para cima |
| `C-d` | Rola meia tela para baixo |

### Edição Rápida

| Tecla | Ação |
|-------|------|
| `i` | Insert Mode antes do cursor |
| `a` | Insert Mode após o cursor |
| `o` | Nova linha abaixo e Insert Mode |
| `x` | Deletar caractere |
| `dd` | Deletar linha inteira |
| `yy` | Copiar linha |
| `p` | Colar |
| `u` | Desfazer |
| `C-r` | Refazer |

---

## Autocomplete — Corfu

Sugestões aparecem automaticamente em um popup enquanto você digita, alimentadas pelos dados do LSP (Eglot) e por `dabbrev`/arquivos locais via Cape. Não exige atalho — funciona em qualquer buffer de código.

| Tecla (no popup) | Ação |
|-------------------|------|
| `TAB` / `C-n` | Próxima sugestão |
| `S-TAB` / `C-p` | Sugestão anterior |
| `RET` | Confirmar seleção |
| `ESC` | Fechar popup |

---

## Atalhos Globais — Leader Key (SPC)

### Arquivos — `SPC f`

| Atalho | Ação |
|--------|------|
| `SPC f f` | Abrir arquivo |
| `SPC f s` | Salvar arquivo |
| `SPC f r` | Arquivos recentes |

### Buffers — `SPC b`

| Atalho | Ação |
|--------|------|
| `SPC b b` | Alternar entre buffers |
| `SPC b d` | Fechar buffer atual |

### Janelas — `SPC w`

| Atalho | Ação |
|--------|------|
| `SPC w v` | Split vertical |
| `SPC w s` | Split horizontal |
| `SPC w d` | Fechar janela atual |
| `SPC w o` | Fechar todas as outras janelas |

### Demais

| Atalho | Ação |
|--------|------|
| `SPC e` | Abrir / fechar Explorer (Treemacs) |
| `SPC t t` | Abrir / fechar terminal (vterm) |
| `SPC s s` | Buscar texto no buffer atual |
| `SPC p f` | Buscar arquivo no projeto |
| `SPC p p` | Trocar de projeto |
| `SPC q q` | Salvar tudo e sair |

---

## LSP — Eglot

O LSP é ativado automaticamente ao abrir arquivos `.clj`, `.py` ou `.sql`. O arquivo é formatado automaticamente ao salvar.

| Atalho | Ação |
|--------|------|
| `SPC l d` | Ir para a definição |
| `SPC l r` | Renomear símbolo no projeto |
| `SPC l f` | Formatar arquivo |
| `SPC l a` | Code actions |

---

## Clojure — CIDER

### Iniciando o REPL

| Atalho | Ação |
|--------|------|
| `SPC c j` | Jack-in — inicia o REPL (Leiningen ou deps.edn) |
| `SPC c J` | Jack-in para ClojureScript |
| `SPC c c` | Conectar a um REPL remoto (nREPL) |
| `SPC c q` | Encerrar o REPL |

### Avaliação de Código

| Atalho | Ação |
|--------|------|
| `SPC c e` | Avaliar a forma antes do cursor |
| `SPC c f` | Avaliar a função atual |
| `SPC c E` | Avaliar o buffer inteiro |
| `SPC c p` | Pretty print do resultado |
| `SPC c i` | Inspecionar o último resultado |

### REPL e Documentação

| Atalho | Ação |
|--------|------|
| `SPC c r` | Alternar entre arquivo e REPL |
| `SPC c n` | Definir namespace no REPL |
| `SPC c d` | Documentação da função sob o cursor |

### Testes

| Atalho | Ação |
|--------|------|
| `SPC c t` | Executar o teste sob o cursor |
| `SPC c T` | Executar todos os testes do namespace |

### Fluxo de Trabalho Típico

```
1. Abrir arquivo .clj          →  SPC f f
2. Iniciar o REPL              →  SPC c j
3. Editar uma função           →  i (Insert Mode)
4. Avaliar a função            →  SPC c f
5. Testar no REPL              →  SPC c r
6. Inspecionar o resultado     →  SPC c i
7. Executar os testes          →  SPC c T
8. Salvar                      →  SPC f s
```

> O Paredit está ativo em arquivos Clojure e no buffer do REPL, garantindo que os parênteses permaneçam sempre balanceados.

---

## Python

### Atalhos — `SPC y`

| Atalho | Ação |
|--------|------|
| `SPC y v` | Ativar virtualenv (pyvenv) |
| `SPC y V` | Desativar virtualenv |
| `SPC y r` | Ir para o REPL do Python |
| `SPC y e` | Avaliar região selecionada |
| `SPC y b` | Avaliar buffer inteiro |

Os atalhos LSP (`SPC l`) também funcionam em arquivos Python, com formatação automática ao salvar via `pyright`.

### Fluxo de Trabalho Típico

```
1. Ativar o virtualenv do projeto   →  SPC y v
2. Abrir arquivo .py                →  SPC f f
3. Editar o código                  →  i (Insert Mode)
4. Avaliar o buffer no REPL         →  SPC y b
5. Aplicar correções do LSP         →  SPC l a
6. Salvar (formata automaticamente) →  SPC f s
```

---

## SQL

### Atalhos — `SPC d`

| Atalho | Ação |
|--------|------|
| `SPC d c` | Conectar a um banco de dados |
| `SPC d r` | Executar região selecionada |
| `SPC d b` | Executar buffer inteiro |

Por padrão o `sql-product` está configurado como `postgres`. Para trocar (MySQL, SQLite, Oracle etc.), ajuste a variável `sql-product` no `init.el`.

Os atalhos LSP (`SPC l`) também funcionam em arquivos `.sql`, incluindo formatação e ida à definição de tabelas/colunas via `sqls`.

### Fluxo de Trabalho Típico

```
1. Abrir arquivo .sql               →  SPC f f
2. Conectar ao banco                →  SPC d c
3. Escrever a query                 →  i (Insert Mode)
4. Executar a região selecionada    →  SPC d r
5. Formatar o arquivo                →  SPC l f
6. Salvar                           →  SPC f s
```

---

## JSON

Arquivos `.json` são reconhecidos automaticamente pelo `json-mode`, com indentação de 2 espaços e realce de sintaxe. Não há LSP dedicado para JSON nesta configuração — o autocomplete de chaves/valores usa `dabbrev` (Corfu/Cape) baseado no que já existe no buffer.

---

## Resolução de Problemas

| Situação | Solução |
|----------|---------|
| Emacs parece travado | Pressione `ESC` várias vezes |
| Atalho `SPC` não funciona | Confirme que está no Normal Mode |
| LSP não inicia (Clojure) | Verifique se `clojure-lsp` está no PATH |
| LSP não inicia (Python) | Verifique se `pyright` está instalado (`npm install -g pyright`) |
| LSP não inicia (SQL) | Verifique se `sqls` está no PATH (`~/go/bin`) |
| Autocomplete não aparece | Confirme que `corfu-mode` está ativo (`M-x corfu-mode`) |
| Aviso sobre `straight.el` ao iniciar | Existe uma configuração antiga em `~/.emacs.d`; remova ou renomeie essa pasta |
| REPL não conecta (Clojure) | Verifique se `project.clj` ou `deps.edn` existe na raiz |
| Terminal não aparece | Execute `SPC t t` duas vezes |
| Quer sair sem salvar | `SPC q q` e responda `no` para os buffers modificados |

---

## Licença

MIT — use como quiser.
