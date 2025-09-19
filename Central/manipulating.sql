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

-- Inserir FAQ
INSERT INTO faq (pergunta, resposta, categoria)
VALUES ('Como alterar minha senha?', 'Acesse Perfil > Segurança > Alterar senha', 'Conta');

-- Remocao
DELETE FROM ticket WHERE id_ticket = 1;