-- DO $$
-- BEGIN
--     RAISE NOTICE '%', 1 / 0;
-- EXCEPTION
--     WHEN division_by_zero THEN
--         RAISE NOTICE 'Não divida por zero';
-- END;
-- $$


-- DO $$
-- DECLARE
--     vetor INT[] := ARRAY[1, 2, 3];
--     matriz INT[] := ARRAY[
--         [1, 2, 3],
--         [4, 5, 6],
--         [7, 8, 9]
--     ];
--     var_aux INT;
--     vet_aux INT[];      
-- BEGIN
--     RAISE NOTICE 'SLICE %, vetor', 0;
--     FOREACH var_aux IN ARRAY vetor LOOP
--     RAISE NOTICE '%', var_aux;
--     END LOOP;

--     RAISE NOTICE 'SLICE %, vetor', 1;
--     FOREACH vet_aux SLICE 1 IN ARRAY vetor LOOP       --SLICE é o numero de dimensões que vc quer
--         RAISE NOTICE '%', vet_aux;
--     END LOOP;

--     RAISE NOTICE 'SLICE: %, matriz', 0;
--     FOREACH var_aux IN ARRAY matriz LOOP
--         RAISE NOTICE '%', var_aux;
--     END LOOP;

--     RAISE NOTICE 'SLICE %, matriz', 1;         --Vai entregar a linha inteira de vetor
--     FOREACH vet_aux SLICE 1 IN ARRAY matriz LOOP
--         RAISE NOTICE '%', vet_aux;
--     END LOOP;

--     RAISE NOTICE 'SLICE %, matriz', 2;         --Vai entregar toda a matriz pois ela só tem 2 dimensões
--     FOREACH vet_aux SLICE 2 IN ARRAY matriz LOOP
--         RAISE NOTICE '%', vet_aux;
--     END LOOP;
-- END;
-- $$


-- DO $$
-- DECLARE
--     valores INT[] := ARRAY[
--         valor_aleatorio_entre(1, 10),
--         valor_aleatorio_entre(1, 10),
--         valor_aleatorio_entre(1, 10),
--         valor_aleatorio_entre(1, 10),
--         valor_aleatorio_entre(1, 10)
--     ];
--     valor INT;
--     soma INT := 0;
-- BEGIN
--     FOREACH valor IN ARRAY valores LOOP      --para cada valor no vetor valores
--         RAISE NOTICE 'Valor da vez: %', valor;
--         soma := soma + valor;
--     END LOOP; 
--     RAISE NOTICE 'Soma: %', soma;
-- END;
-- $$


-- DO $$
-- DECLARE
--     aluno RECORD;            --RECORD REPRESENTA A LINHA DE UMA TABELA INDEPENDENTE DA ESTRUTURA
--     media NUMERIC(10, 2) := 0;
--     total_alunos INT;
-- BEGIN
--     FOR aluno IN
--         SELECT * FROM tb_auno
--     LOOP
--         RAISE NOTICE 'Nota do aluno %: %', aluno.cod_alino, aluno.nota;
--         media := media + aluno.nota;
--     END LOOP;
--     SELECT COUNT(*) FROM tb_auno INTO total_alunos;
--     RAISE NOTICE 'Média: %', media / total_alunos;
-- END;
-- $$


-- SELECT * FROM tb_auno;


-- DO $$
-- BEGIN
--     FOR i IN 1..10 LOOP
--         INSERT INTO tb_auno
--         (nota)
--         VALUES
--         (valor_aleatorio_entre(0, 10));
--     END LOOP;
-- END;
-- $$


--criando a table
-- CREATE TABLE tb_auno(
--     cod_alino SERIAL PRIMARY KEY,
--     nota INT
-- );


--LOOP FOR
-- DO $$
-- BEGIN
-- --contar de 1 a 10
-- --intervalo fechado de 1 a 10
--     FOR i IN 1..10 LOOP    --o for conta da esquerda pra direita, então nn pode ser feita contagem regressiva desse jeito
--         RAISE NOTICE '%', i;
--     END LOOP;
-- --contagem regressiva
--     FOR i IN REVERSE 10..1 LOOP
--         RAISE NOTICE '%', i;
--     END LOOP;

-- --de 1 a 50 de 2 em 2
--     FOR i IN 1..50 BY 2 LOOP
--         RAISE NOTICE '%', i;
--     END LOOP;
-- END;
-- $$


-- DO $$
-- DECLARE
--     nota INT;
--     media NUMERIC(10, 2) := 0;
--     contador INT := 1;
--     total_alunos INT := 20;
-- BEGIN
--     WHILE contador <= total_alunos LOOP
--         SELECT valor_aleatorio_entre(0, 10) INTO nota;
--         RAISE NOTICE '%', nota;
--         media := media + nota;
--         contador := contador + 1;
--     END LOOP;
--     RAISE NOTICE 'Media: %', media / contador;
-- END;
-- $$


-- DO $$
-- DECLARE
--     nota INT;
--     media NUMERIC(10, 2) := 0;
--     contador INT := 0;
-- BEGIN
--     SELECT valor_aleatorio_entre(0, 11) - 1 INTO nota;
--     WHILE nota >= 0 LOOP
--         RAISE NOTICE '%', nota;
--         media := media + nota;
--         contador := contador + 1;
--         SELECT valor_aleatorio_entre(0, 11) - 1 INTO nota;
--     END LOOP;
--     IF contador > 0 THEN
--         RAISE NOTICE 'Media: %', media / contador;
--     ELSE
--         RAISE NOTICE 'Nenhuma nota gerada';
--     END IF;
-- END;
-- $$


-- DO $$
-- DECLARE
--     i INT;
--     j INT;
-- BEGIN
--     i := 0;
--     <<externo>>
--     LOOP
--         i := i + 1;
--         EXIT WHEN i> 10;
--         j := 1;
--         <<interno>>
--         LOOP
--             RAISE NOTICE '% %', i, j;
--             j := j + 1;
--             CONTINUE externo WHEN j > 5;
--         END LOOP;
--     END LOOP;
-- END;
-- $$


-- DO $$
-- DECLARE
--     i INT;
--     j INT;
-- BEGIN
--     i := 0;
--     <<externo>>  --dando nome par o loop
--     LOOP
--         i := 1;
--         EXIT WHEN i>10;
--         j := 1;
--         <<interno>>
--         LOOP
--             RAISE NOTICE '% %', i, j;
--             j := j + 1;
--             EXIT externo WHEN j > 5;
--         END LOOP;
--     END LOOP;
-- END;
-- $$


-- DO
-- $$
-- DECLARE
-- contador INT := 0;
-- BEGIN
-- LOOP
-- contador := contador + 1;
-- EXIT WHEN contador > 100;
-- -- ignorando iteração da vez quando contador for múltiplo de 7 com IF/CONTINUE
-- IF contador % 7 = 0 THEN
-- CONTINUE;
-- END IF;
-- --ignorando iteração da vez quando contador for múltiplo de 11 com CONTINUE WHEN
-- CONTINUE WHEN contador % 11 = 0;
-- RAISE NOTICE '%', contador;
-- END LOOP;
-- END;
-- $$


-- Contando de 1 a 10
-- Saída com IF/EXIT
-- DO 
-- $$
-- DECLARE
-- contador INT := 1;
-- BEGIN
--     LOOP
--         RAISE NOTICE '%', contador;
--         contador := contador + 1;
--         IF contador > 10 THEN
--             EXIT;
--         END IF;
--     END LOOP;
-- END;
-- $$

-- DO
-- $$
-- BEGIN
-- 
-- RAISE NOTICE 'Teste loop simples...';
-- END LOOP;
-- END;
-- $$




-- CREATE OR REPLACE FUNCTION valor_aleatorio_entre (lim_inferior INT, lim_superior
-- INT) RETURNS INT AS
-- $$
-- BEGIN
-- RETURN FLOOR(RANDOM() * (lim_superior - lim_inferior + 1) + lim_inferior)::INT;
-- END;
-- $$ LANGUAGE plpgsql;
-- SELECT valor_aleatorio_entre (2, 10);


-- CREATE OR REPLACE FUNCTION valor_aleatorio_entre (lim_inferior INT, lim_superior
-- INT) RETURNS INT AS
-- $$
-- BEGIN
-- RETURN FLOOR(RANDOM() * (lim_superior - lim_inferior + 1) + lim_inferior)::INT;
-- END;
-- $$ LANGUAGE plpgsql;