SELECT * FROM banco_dados.ifoodcase;

-- VERIFICO SE A TABELA ACEITAA NULOS E O TIPO DE DADOS
DESC banco_dados.ifoodcase;


-- Aqui captei todos os nomes pois ficam mais facil de editar o proximo select
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ifoodcase'
AND TABLE_SCHEMA = 'banco_dados';

USE banco_dados


-- CRIANDO TABELA E EDITANDO VALOR PARA MIN 
create temporary TABLE  V3 AS (
SELECT 
	id_loja,
    modal,
    flag_atraso_entregador,
    flag_atraso_pedido,
    flag_atraso_restaurante,
    TIME_FORMAT(SEC_TO_TIME(tempo_real_ate_restaurante_seg), '%H:%i:%s') AS Tempo_real_mi2,
    TIME_FORMAT(SEC_TO_TIME(tempo_estimado_ate_restaurante_seg), '%H:%i:%s') AS tempo_estimado_ate_restauranten_min,
    TIME_FORMAT(SEC_TO_TIME(tempo_real_ate_coleta_seg), '%H:%i:%s') AS tempo_real_ate_coleta_min,
    TIME_FORMAT(SEC_TO_TIME(tempo_entrega_real_seg), '%H:%i:%s') AS tempo_entrega_real_min,	
    TIME_FORMAT(SEC_TO_TIME(tempo_entrega_estimado_seg), '%H:%i:%s') AS tempo_entrega_estimado_min,
    TIME_FORMAT(SEC_TO_TIME(atraso_entregador_seg), '%H:%i:%s') AS atraso_entregador_min,
    TIME_FORMAT(SEC_TO_TIME(atraso_restaurante_seg), '%H:%i:%s') AS atraso_restaurante_min
FROM banco_dados.ifoodcase
WHERE modal = 'MOTORCYCLE'
);
 SELECT * FROM V3 ;


-- VERIFICANDO OS NULOS
SELECT 
CASE WHEN Tempo_real_mi2 IS NULL THEN 'NULO' ELSE 'NÃO_NULO' END AS STATUS_TEMPO_R ,
CASE WHEN tempo_estimado_ate_restauranten_min IS NULL THEN 'NULO' ELSE 'NÃO_NULO' END AS STATUS_TEMP_ESTIMADO_RES,
CASE WHEN tempo_real_ate_coleta_min IS NULL THEN 'NULO' ELSE 'NÃO_NULO' END AS STATUS_TEMP_REAL_COLETA,
CASE WHEN tempo_entrega_real_min IS NULL THEN 'NULO' ELSE 'NÃO__NULO' END AS STATUS_tempo_entrega_real_ ,
CASE WHEN tempo_entrega_estimado_min IS NULL THEN 'NULO' ELSE 'NÃO_NULO' END AS STATUS_tempo_entrega_estimado_min,
CASE WHEN atraso_entregador_min IS NULL THEN 'NULO' ELSE 'NÃO_NULO' END AS STATUS_atraso_entregador_min,
CASE WHEN atraso_restaurante_min IS NULL THEN 'NULO' ELSE 'NÃO NULO' END AS STATUS_atraso_restaurante_min 
FROM V3; 

 SELECT * FROM V3 ;
 
 
 
 WITH flag_entregador AS (
SELECT * FROM V3
WHERE flag_atraso_entregador = 'true' and atraso_entregador_min >  '00:04:38' or  flag_atraso_restaurante = 'true'

),
flag_restaurante as (
select * from
















