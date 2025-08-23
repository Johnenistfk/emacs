# 🚀 Início Rápido
Abrindo o Emacs
Iniciar Emacs limpo
emacs

Abrir arquivo específico
emacs meuarquivo.c
emacs script.js

Abrir em modo gráfico (se estiver no terminal)
emacs &


# 🎯 Conceitos Básicos
Estados do Evil Mode (Como Vim)
Normal Mode 🔵: Para navegação e comandos (padrão ao iniciar)
Insert Mode 🟢: Para digitar texto (pressione i)
Visual Mode 🟡: Para seleção de texto (pressione v)
Como Mudar de Estado
i - Entrar no Insert Mode
ESC ou C-c - Voltar para Normal Mode
v - Visual Mode (seleção)
V - Visual Line Mode (seleção de linhas)

# ⌨️ Atalhos Essenciais (Normal Mode)
📁 Arquivos - SPC f
Atalho
Função
Exemplo
SPC f f
Abrir arquivo
Navega e abre qualquer arquivo
SPC f s
Salvar arquivo
Salva o arquivo atual
SPC f r
Arquivos recentes
Lista arquivos recentemente abertos

# 🗂️ Explorer - SPC e
Atalho
Função
Uso
SPC e
Abrir/fechar explorer
Ver estrutura de pastas do projeto

# 📄 Buffers - SPC b
Atalho
Função
Explicação
SPC b b
Trocar buffer
Alterna entre arquivos abertos
SPC b d
Fechar buffer
Fecha o arquivo atual

# 🪟 Janelas - SPC w
Atalho
Função
Uso
SPC w v
Split vertical
Divide tela em 2 verticalmente
SPC w s
Split horizontal
Divide tela em 2 horizontalmente
SPC w d
Fechar janela
Remove divisão atual
SPC w o
Fechar outras janelas
Mantém só a janela atual

# 💻 Terminal - SPC t
Atalho
Função
Uso
SPC t t
Toggle terminal
Abre/fecha terminal na parte inferior

# 🔍 Busca - SPC s
Atalho
Função
Uso
SPC s s
Buscar no arquivo
Procura texto no arquivo atual


# 🔧 LSP (Language Server) - SPC l
Para C e JavaScript (quando LSP está ativo)
Atalho
Função
Exemplo
SPC l d
Ir para definição
Pula para onde função/variável foi definida
SPC l r
Renomear símbolo
Renomeia variável/função em todo projeto
SPC l f
Formatar código
Auto-formata o código
SPC l a
Code actions
Mostra ações disponíveis (fix erros, etc.)


# 📝 Navegação Básica (Normal Mode)
Movimento do Cursor
Tecla
Movimento
h
← esquerda
j
↓ baixo
k
↑ cima
l
→ direita
w
Próxima palavra
b
Palavra anterior
0
Início da linha
$
Final da linha
gg
Início do arquivo
G
Final do arquivo

Edição Rápida
Tecla
Ação
x
Deletar caractere
dd
Deletar linha inteira
yy
Copiar linha
p
Colar
u
Desfazer (undo)
Ctrl-r
Refazer (redo)


💻 Workflow para C
1. Criando um projeto C
# Criar pasta do projeto
mkdir meu_projeto_c
cd meu_projeto_c

# Abrir Emacs
emacs

2. Estrutura típica
meu_projeto_c/
├── src/
│   ├── main.c
│   └── funcoes.c
├── include/
│   └── funcoes.h
└── Makefile

3. Fluxo de trabalho
SPC f f → Criar/abrir main.c
Digitar código
SPC f s → Salvar
SPC t t → Abrir terminal
No terminal: gcc main.c -o programa
Executar: ./programa
4. Exemplo prático C
#include <stdio.h>

int main() {
    printf("Hello World!\n");
    return 0;
}

Passos:
SPC f f → digite main.c → Enter
i (Insert Mode)
Digite o código acima
ESC (Normal Mode)
SPC f s (Salvar)
SPC t t (Terminal)
gcc main.c -o hello
./hello

# 🌐 Workflow para JavaScript
1. Criando projeto JavaScript
mkdir meu_projeto_js
cd meu_projeto_js
npm init -y  # Se usar Node.js

2. Estrutura típica
meu_projeto_js/
├── src/
│   ├── app.js
│   └── utils.js
├── package.json
└── index.html  # Se for frontend

3. Fluxo de trabalho
SPC f f → Criar/abrir app.js
Digitar código
SPC f s → Salvar
SPC t t → Terminal
node app.js → Executar
4. Exemplo prático JavaScript
// app.js
function saudacao(nome) {
    return `Olá, ${nome}!`;
}

console.log(saudacao("Mundo"));

Passos:
SPC f f → digite app.js → Enter
i (Insert Mode)
Digite código acima
ESC (Normal Mode)
SPC f s (Salvar)
SPC t t (Terminal)
node app.js

# 🔥 Dicas Avançadas
1. Múltiplos arquivos
SPC b b → Alternar rapidamente entre arquivos abertos
SPC w v → Split vertical para ver 2 arquivos lado a lado
2. Busca eficiente
SPC s s → Buscar dentro do arquivo atual
/texto (Normal Mode) → Busca rápida
n → Próxima ocorrência
N → Ocorrência anterior
3. Copy/Paste entre arquivos
Selecione texto com v (Visual Mode)
y → Copiar
SPC b b → Trocar para outro arquivo
p → Colar
4. Formatação automática
Salvar já formata automaticamente (configurado no LSP)
SPC l f → Forçar formatação manual

# 🐛 Debug e Compilação
Para C
# Terminal no Emacs (SPC t t)
gcc -g -Wall main.c -o debug_program
gdb ./debug_program

Para JavaScript
# Terminal no Emacs (SPC t t)
node --inspect app.js
# Ou apenas
node app.js


# 🆘 Comandos de Emergência
Situação
Solução
Travou tudo
ESC várias vezes, depois SPC q q
Quer sair sem salvar
SPC q Q
Salvou errado
u (undo)
Perdeu janela
SPC w o (fechar outras)
Terminal não aparece
SPC t t duas vezes


# 📚 Comandos por Categoria
Essenciais Diários
SPC f f - Abrir arquivo
SPC f s - Salvar
SPC e - Explorer
SPC t t - Terminal
i - Insert Mode
ESC - Normal Mode
Programação
SPC l d - Ir para definição
SPC l r - Renomear
SPC s s - Buscar
SPC w v - Split vertical
Gerenciamento
SPC b b - Trocar buffer
SPC b d - Fechar arquivo
SPC q q - Sair salvando

# 🎯 Exercício Prático
Projeto: Calculadora em C
Criar estrutura:
mkdir calculadora_c
cd calculadora_c
emacs

Criar arquivos:
SPC f f → main.c
SPC f f → calc.h
SPC f f → calc.c
Implementar e testar
Compilar no terminal integrado
Projeto: To-Do List em JavaScript
Criar estrutura:
mkdir todo_js
cd todo_js
emacs

Criar arquivos:
SPC f f → todo.js
SPC f f → index.html
Implementar e testar no browser/node


# ⚡ Resumo dos Atalhos Mais Usados
Função
Atalho
Use quando
Abrir arquivo
SPC f f
Sempre que quiser abrir algo
Salvar
SPC f s
Depois de editar
Explorer
SPC e
Ver estrutura do projeto
Terminal
SPC t t
Compilar/executar código
Insert Mode
i
Digitar código
Normal Mode
ESC
Navegar/comandos
Buscar
SPC s s
Encontrar texto
Ir para definição
SPC l d
Entender código


🤝 Contribuições
Pull requests são bem-vindos! Para mudanças grandes, abra uma issue primeiro.
📄 Licença
MIT - Use como quiser!

Enjoy coding! 🎉
