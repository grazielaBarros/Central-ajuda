CREATE DATABASE central_ajuda;

-- Schema: central_ajuda.sql (PostgreSQL)

-- 1. Cria extensão de uuid (opcional)
-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE usuario (
  id_usuario SERIAL PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  telefone VARCHAR(30),
  tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('cliente','tecnico','admin')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TABLE ticket (
  id_ticket SERIAL PRIMARY KEY,
  id_usuario_cliente INTEGER NOT NULL REFERENCES usuario(id_usuario) ON DELETE RESTRICT,
  titulo VARCHAR(200) NOT NULL,
  descricao TEXT NOT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'aberto' CHECK (status IN ('aberto','em_andamento','fechado')),
  prioridade VARCHAR(10) NOT NULL DEFAULT 'media' CHECK (prioridade IN ('baixa','media','alta')),
  criado_em TIMESTAMP WITH TIME ZONE DEFAULT now(),
  atualizado_em TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TABLE mensagem (
  id_mensagem SERIAL PRIMARY KEY,
  id_ticket INTEGER NOT NULL REFERENCES ticket(id_ticket) ON DELETE CASCADE,
  id_usuario_remetente INTEGER NOT NULL REFERENCES usuario(id_usuario) ON DELETE SET NULL,
  conteudo TEXT NOT NULL,
  enviado_em TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TABLE faq (
  id_faq SERIAL PRIMARY KEY,
  pergunta VARCHAR(300) NOT NULL,
  resposta TEXT NOT NULL,
  categoria VARCHAR(100),
  publicado BOOLEAN DEFAULT TRUE,
  criado_em TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TABLE anexo (
  id_anexo SERIAL PRIMARY KEY,
  id_ticket INTEGER NOT NULL REFERENCES ticket(id_ticket) ON DELETE CASCADE,
  nome_arquivo VARCHAR(255) NOT NULL,
  url VARCHAR(500) NOT NULL,
  enviado_em TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Índices sugeridos
CREATE INDEX idx_ticket_status ON ticket(status);
CREATE INDEX idx_ticket_prioridade ON ticket(prioridade);
CREATE INDEX idx_mensagem_ticket ON mensagem(id_ticket);

INSERT INTO usuario (nome, email, telefone, tipo)
VALUES
('Ana Silva', 'ana.silva@example.com', '67999990000', 'cliente'),
('Carlos Tech', 'carlos.tech@example.com', '67988880000', 'tecnico');

-- supondo id_usuario_cliente = 1
INSERT INTO ticket (id_usuario_cliente, titulo, descricao, prioridade)
VALUES (1, 'Erro ao gerar relatório', 'Ao clicar em Relatórios, aparece erro 500', 'alta');

-- id_usuario_remetente = 2 (técnico)
INSERT INTO mensagem (id_ticket, id_usuario_remetente, conteudo)
VALUES (1, 2, 'Recebido. Vou verificar e retorno em breve.');


UPDATE ticket
SET status = 'em_andamento', atualizado_em = now()
WHERE id_ticket = 1;

UPDATE ticket
SET status = 'fechado', atualizado_em = now()
WHERE id_ticket = 1;

--Consultas uteis

SELECT m.enviado_em, u.nome, m.conteudo
FROM mensagem m
LEFT JOIN usuario u ON u.id_usuario = m.id_usuario_remetente
WHERE m.id_ticket = 1
ORDER BY m.enviado_em;

SELECT t.id_ticket, t.titulo, t.prioridade, t.status, u.nome as cliente, t.criado_em
FROM ticket t
JOIN usuario u ON u.id_usuario = t.id_usuario_cliente
WHERE t.status = 'aberto'
ORDER BY t.prioridade DESC, t.criado_em;

-- Inserir FAQ
INSERT INTO faq (pergunta, resposta, categoria)
VALUES ('Como alterar minha senha?', 'Acesse Perfil > Segurança > Alterar senha', 'Conta');

-- Remocao
DELETE FROM ticket WHERE id_ticket = 1;