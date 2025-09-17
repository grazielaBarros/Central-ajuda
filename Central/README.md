# 🛠️ Central de Ajuda Interativa

Este projeto é uma aplicação web dinâmica que simula uma **Central de Ajuda Interativa**, com foco em melhorar a experiência de suporte ao usuário.  

O sistema permite que usuários:
- Consultem **FAQs** (Perguntas Frequentes);
- Utilizem a **barra de busca** para dúvidas;
- Acessem tutoriais (simulados na seção FAQ);
- Entrem em **contato com a equipe de suporte** através de um formulário.

---

## 🚀 Tecnologias Utilizadas

- **HTML5** → Estrutura semântica das páginas.
- **CSS3** → Estilização personalizada.
- **Bootstrap 5** → Framework front-end para responsividade e componentes prontos.
- **JavaScript (Bootstrap Bundle)** → Funcionalidades interativas (accordion/FAQ).

---

## 📂 Estrutura de Arquivos

---

## 📸 Protótipo (principais telas)

- **Página inicial** com campo de busca.  
- **FAQ dinâmico** com accordion.  
- **Formulário de contato**.  
- **Layout responsivo** adaptado para celular, tablet e desktop.  

---

## 🗄️ Banco de Dados

O sistema possui um banco de dados relacional para gerenciar usuários, chamados, categorias e FAQs.

### Modelo de Dados
As principais entidades são:
- **Usuários** → armazenam informações de clientes e equipe de suporte.
- **Categorias** → organizam os chamados por tipo.
- **Chamados** → registram dúvidas/solicitações dos usuários.
- **FAQ** → perguntas e respostas frequentes.

Diagrama Entidade-Relacionamento (DER):  
![DER](der.png)

### Esquema SQL
O esquema do banco está disponível em [`schema.sql`](schema.sql).  
Exemplo de criação de tabela:

```sql

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    perfil ENUM('cliente','suporte','admin') DEFAULT 'cliente'
);

```

### Inserção
```sql
INSERT INTO usuarios (nome, email, senha, perfil) 
VALUES ('Maria Silva', 'maria@email.com', '123456', 'cliente');
```
### Consulta
```sql
SELECT c.titulo, c.status, u.nome AS cliente, cat.nome_categoria
FROM chamados c
JOIN usuarios u ON c.id_usuario = u.id_usuario
JOIN categorias cat ON c.id_categoria = cat.id_categoria;
```
## 🌀 Controle de Versão

O projeto foi versionado com GitHub, seguindo boas práticas:
- Commits frequentes e descritivos.
- Organização dos arquivos (`centralhelp.html`, `Style.css`, `schema.sql`).
- Registro da evolução do banco de dados e aplicação.

Exemplo de commits:
- `Criação da estrutura inicial com HTML/CSS`
- `Adicionado FAQ interativo com Bootstrap`
- `Implementação do esquema SQL do banco de dados`
- `Adição de consultas SQL e manipulação de dados`