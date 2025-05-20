-------------------------------------------- RODAR OS CODIGOS DA ORDEM DE BAIXO PARA CIMA --------------------------------------------

-- DO $$
-- DECLARE
--     resultado VARCHAR(500);
--     troco INT := 43;
-- BEGIN
--     CALL sp_obter_notas_para_compor_o_troco (resultado, troco);
--     RAISE NOTICE '%', resultado;
-- END;
-- $$

-- CREATE OR REPLACE PROCEDURE sp_obter_notas_para_compor_o_troco (OUT resultado
-- VARCHAR(500), IN troco INT)
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
--     notas200 INT := 0;
--     notas100 INT := 0;
--     notas50 INT := 0;
--     notas20 INT := 0;
--     notas10 INT := 0;
--     notas5 INT := 0;
--     notas2 INT := 0;
--     moedas1 INT := 0;
-- BEGIN
--     notas200 := troco / 200;
--     notas100 := troco % 200 / 100;
--     notas50 := troco % 200 % 100 / 50;
--     notas20 := troco % 200 % 100 % 50 / 20;
--     notas10 := troco % 200 % 100 % 50 % 20 / 10;
--     notas5 := troco % 200 % 100 % 50 % 20 % 10 / 5;
--     notas2 := troco % 200 % 100 % 50 % 20 % 10 % 5 / 2;
--     moedas1 := troco % 200 % 100 % 50 % 20 % 10 % 5 % 2;
-- resultado := concat (
-- -- E é de escape. Para que \n tenha sentido
-- -- || é um operador de concatenação
--     'Notas de 200: ',
--     notas200 || E'\n',
--     'Notas de 100: ',
--     notas100 || E'\n',
--     'Notas de 50: ',
--     notas50 || E'\n',
--     'Notas de 20: ',
--     notas20 || E'\n',
--     'Notas de 10: ',
--     notas10 || E'\n',
--     'Notas de 5: ',
--     notas5 || E'\n',
--     'Notas de 2: ',
--     notas2 || E'\n',
--     'Moedas de 1: ',
--     moedas1 || E'\n'
-- );
-- END;
-- $$


-- DO $$
-- DECLARE
--     v_troco INT;
--     v_valor_total INT;
--     v_valor_a_pagar INT := 100;
--     v_cod_pedido INT := 7;
-- BEGIN
--     CALL sp_calcular_valor_de_um_pedido(v_cod_pedido, v_valor_total);   --aq valor total esta em modo out
--     CALL sp_calcular_troco(v_troco, v_valor_a_pagar, v_valor_total);    --aq a variavel valor total esta em modo in
--     RAISE NOTICE 'A conta foi de R$% e você pagou R$%. Troco: R$%', v_valor_total, v_valor_a_pagar, v_troco;
-- END;
-- $$

-- CREATE OR REPLACE PROCEDURE sp_calcular_troco(OUT p_troco INT, IN p_valor_a_pagar INT, IN p_valor_total INT)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     p_troco := p_valor_a_pagar - p_valor_total;
-- END;
-- $$


-- DO $$
-- DECLARE
--     v_cod_pedido INT := 1;
-- BEGIN
--     CALL sp_fechar_pedido(200, v_cod_pedido);
-- END;
-- $$

-- SELECT * FROM tb_pedido;

-- CREATE OR REPLACE PROCEDURE sp_fechar_pedido(IN p_valor_a_pagar INT, IN p_cod_pedido INT) 
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
--     v_valor_total INT;
-- BEGIN
--     CALL sp_calcular_valor_de_um_pedido(p_cod_pedido, v_valor_total);
--     IF p_valor_a_pagar < v_valor_total THEN
--         RAISE NOTICE 'R$: % insuficiente para pagar a conta de R$ %', p_valor_a_pagar, v_valor_total;
--     ELSE
--         UPDATE tb_pedido p SET
--         data_modificacao = CURRENT_TIMESTAMP,
--         status = 'Fechado'
--         WHERE p.cod_pedido = p_cod_pedido;
--     END IF; 
-- END;
-- $$


-- DO $$
-- DECLARE
--     v_valor_total INT;
--     v_cod_pedido INT := 1;
-- BEGIN
--     CALL sp_calcular_valor_de_um_pedido(1, v_valor_total);
--     RAISE NOTICE 'Total do Pedido %, R$: %', v_cod_pedido, v_valor_total;
-- END;
-- $$

-- CREATE OR REPLACE PROCEDURE sp_calcular_valor_de_um_pedido(IN p_cod_pedido INT, OUT p_valor_total INT)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     SELECT SUM(i.valor) FROM tb_pedido p
--     INNER JOIN tb_item_pedido ip               -- para pegar o valor de cada pedido
--     ON p.cod_pedido = ip.cod_pedido
--     INNER JOIN tb_item i
--     ON ip.cod_item = i.cod_item
--     WHERE p.cod_pedido = p_cod_pedido
--     INTO p_valor_total;
-- END;
-- $$


-- SELECT * FROM tb_item_pedido;
-- CALL sp_adicionar_item_a_pedido(1, 7);
-- SELECT * FROM tb_pedido;
-- SELECT * FROM tb_item;

-- CREATE OR REPLACE PROCEDURE sp_adicionar_item_a_pedido(IN p_cod_item INT, IN p_cod_pedido INT)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     INSERT INTO tb_item_pedido(cod_item, cod_pedido) VALUES ($1, $2);
--     UPDATE tb_pedido p 
--     SET data_modificacao = CURRENT_TIMESTAMP
--     WHERE p.cod_pedido = $2;    --p_cod_pedido
-- END;
-- $$


-- DO $$       --este bloco de codigo anonimo é o cliente da procedure criar pedido
-- DECLARE
--     v_cod_pedido INT;
--     v_cod_cliente INT;
-- BEGIN
--     SELECT c.cod_cliente FROM tb_cliente c          -- c no final é o apelido q damos para tabela
--      WHERE nome LIKE 'Ana Silva' INTO v_cod_cliente;
--     CALL sp_criar_pedido(v_cod_pedido, v_cod_cliente);
--     RAISE NOTICE 'Código do pedido recém criado: %', v_cod_pedido;    -- é o valor do LASTVAL presente no procedure
-- END;
-- $$

-- SELECT * FROM tb_cliente;

-- INSERT INTO tb_cliente(nome) VALUES ('Ana Silva');

-- CREATE OR REPLACE PROCEDURE  sp_criar_pedido(OUT p_cod_pedido INT, IN p_cod_cliente INT)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     INSERT INTO tb_pedido(cod_cliente) VALUES (p_cod_cliente);
--     SELECT LASTVAL() INTO p_cod_pedido;           --LASTVAL é para pegar e mostrar o valor de uma variavel do tipo SERIAL
-- END;
-- $$

-- CREATE OR REPLACE PROCEDURE sp_cadastrar_cliente(IN p_nome VARCHAR(200), IN p_cod_cliente INT DEFAULT NULL)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     IF p_cod_cliente IS NULL THEN -- usar IS quando compara com null
--         INSERT INTO tb_cliente (nome) VALUES (p_nome);
--     ELSE
--         INSERT INTO tb_cliente (cod_cliente, nome) VALUES (p_cod_cliente, p_nome);
--     END IF;
-- END;
-- $$
 
 
-- CREATE TABLE tb_item_pedido(
--     --surrogate key(chave substituta)
--     cod_item_pedido SERIAL PRIMARY KEY,
--     cod_item INT NOT NULL,
--     cod_pedido INT NOT NULL,
--     CONSTRAINT fk_item FOREIGN KEY (cod_item) REFERENCES tb_item(cod_item),
--     CONSTRAINT fk_pedido FOREIGN KEY (cod_pedido) REFERENCES tb_pedido(cod_pedido)
-- );
 
-- INSERT INTO tb_item (descricao, valor, cod_tipo) VALUES
-- ('Refigerante', 7, 1),
-- ('Suco', 8, 1),
-- ('Batata frita', 9, 2),
-- ('Hamburguer', 12, 2);
 
-- CREATE TABLE tb_item(
--     cod_item SERIAL PRIMARY KEY,
--     descricao VARCHAR(200) NOT NULL,
--     valor NUMERIC(10, 2) NOT NULL,
--     cod_tipo INT NOT NULL,
--     CONSTRAINT fk_tipo_item FOREIGN KEY (cod_tipo) REFERENCES tb_tipo_item(cod_tipo)
-- );
 
-- INSERT INTO tb_tipo_item(descricao) VALUES ('Bebida'), ('Comida');
 
-- CREATE TABLE tb_tipo_item(
--     cod_tipo SERIAL PRIMARY KEY,
--     descricao VARCHAR(200) NOT NULL
-- );
 
-- CREATE TABLE tb_pedido(
--     cod_pedido SERIAL PRIMARY KEY,
--     data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     data_modificacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     status VARCHAR(100) DEFAULT 'aberto',
--     cod_cliente INT NOT NULL,
--     CONSTRAINT fk_cliente FOREIGN KEY (cod_cliente) REFERENCES tb_cliente(cod_cliente) --restrigindo uma coluna
-- );
 
-- CREATE TABLE tb_cliente(
--     cod_cliente SERIAL PRIMARY KEY,
--     nome VARCHAR(200) NOT NULL
-- );
 
 
-- PARAMETROS EM MODO VARIADIC ------------------
-- CALL sp_calcula_media(1, 2, 3);
 
-- CREATE OR REPLACE PROCEDURE sp_calcula_media(VARIADIC p_valores INT[])
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
--     v_media NUMERIC(10, 2) := 0;
--     v_valor INT;
-- BEGIN
--     FOREACH v_valor IN ARRAY p_valores LOOP
--         v_media := v_media + v_valor;
--     END LOOP;
--     RAISE NOTICE 'A média é: %', v_media / array_length(p_valores, 1);  -- 1 é o slice, as dimensões
-- END;
-- $$
 
 
-- PARAMETROS EM MODO INOUT --------------
-- bloco anonimo para colocar em execução
-- DO $$
-- DECLARE
--     v_valor1 INT := 2;
--     v_valor2 INT := 3;
-- BEGIN
--     CALL sp_acha_maior(v_valor1, v_valor2);
--     RAISE NOTICE '% é o maior', v_valor1;
-- END;
-- $$
 
-- DROP PROCEDURE IF EXISTS sp_acha_maior;
-- CREATE OR REPLACE PROCEDURE sp_acha_maior(INOUT p_valor1 INT, IN p_valor2 INT)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     IF p_valor2 > p_valor1 THEN
--         p_valor1 := p_valor2;
--     END IF;
-- END;
-- $$
 
 
--PARAMETROS EM MODO OUT -----------------
-- QUANDO É OUT DEVE SEMRPRE DECLARAR UM BLOCO ANONIMO COMO O ABAIXO
-- DO $$
-- DECLARE
--     v_resultado INT;
-- BEGIN
--     CALL sp_acha_maior(v_resultado, 2, 3);
--     RAISE NOTICE '% é o maior', v_resultado;
-- END;
-- $$
 
-- DROP PROCEDURE IF EXISTS sp_acha_maior;
-- CREATE OR REPLACE PROCEDURE sp_acha_maior(OUT p_resultado INT, IN p_valor1 INT, IN p_valor2 INT)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     CASE
--         WHEN p_valor1 > p_valor2 THEN
--             p_resultado := p_valor1;
--         ELSE
--             p_resultado := p_valor2;
--     END CASE;
-- END;
-- $$
 
 
 
--PARAMETROS EM MODO IN---------------------------
-- CALL sp_acha_maior(2, 3);
 
-- CREATE OR REPLACE PROCEDURE sp_acha_maior(IN p_valor1 INT, p_valor2 INT)  --IN é o modo padrão
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     IF p_valor1 > p_valor2 THEN
--         RAISE NOTICE '% é o maior', p_valor1;  --ou $1
--     ELSE
--         RAISE NOTICE '% é o maior', p_valor2;
--     END IF;
-- END;
-- $$
 
 
-- CALL sp_ola_usuario('Pedro');
 
-- CREATE OR REPLACE PROCEDURE sp_ola_usuario(p_nome VARCHAR(200))   --paramatero nome
-- LANGUAGE plpgsql
-- AS $$ --da seguinte forma...
-- BEGIN
-- --acessar parametro pelo nome dele
--     RAISE NOTICE 'Olá, %', p_nome;
-- --acessar parametro pelo seu nuemro identificador. começando do 1
--     -- RAISE NOTICE 'Olá, %', $1;    -- cifrão e numero do parametro de interesse
-- END;
-- $$
 
 
-- CALL sp_ola_procedures();
 
-- CREATE OR REPLACE PROCEDURE sp_ola_procedures()
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     RAISE NOTICE 'Olá, procedures!';
-- END;
-- $$