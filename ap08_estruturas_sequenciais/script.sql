-- geracao de valores aleatorios
DO
$$
DECLARE
    n1 NUMERIC (5,2);
    n2 INT;
    limite_inferior INT := 5;
    limite_superior INT := 17;
BEGIN
    n1 := random();
    RAISE NOTICE 'n1: %', n1;
    n1 := 1 + random() * 9;         --expressao no minimo 1
    RAISE NOTICE '%: ',n1;
    n2 := floor(random() * 10 + 1)::INT;          --no minimo 1 e no maximo 10 sem decimais
    RAISE NOTICE 'n2: %', n2;
    n2 := floor(random() * (limite_superior - limite_inferior + 1 + limite_inferior))::INT;         --limite superior - inferior + 1
    RAISE NOTICE 'intervalo qualquer: %', n2;
END;
$$

-- variaveis v_ para lembrar que e uma variavel
-- DO
-- $$
-- DECLARE
--     v_codigo INTEGER := 1;
--     v_nome_completo VARCHAR(200) := 'João';
--     v_salario NUMERIC (11, 2) := 20.5;
-- BEGIN
--     RAISE NOTICE 'Meu codigo é %, me chamo % e meu salario é %', 
--     v_codigo, v_nome_completo, v_salario;
-- END;
-- $$

-- placeholders de expressoes em strings
-- DO
-- $$
-- BEGIN
--     RAISE NOTICE '% + % = %', 2, 2, 2 + 2;
-- END;
-- $$

-- DO
-- $$
-- BEGIN
--     RAISE NOTICE 'Meu primeiro bloco anônimo!!';
-- END;
-- $$

-- CREATE  DATABASE "2025_fatec_ipi_pbdi_gustavoH";