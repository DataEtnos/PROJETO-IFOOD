SELECT * FROM banco_dados.ifoodcase;

CREATE TABLE IFOOD_TRATADO AS (
    SELECT 
        id_loja,
        id_rota, 
        numero_pedido,
        modal,
        flag_atraso_entregador,
        flag_atraso_pedido,
        flag_atraso_restaurante,
        DATE(STR_TO_DATE(SUBSTRING(hora_data_pedido, 1, 19), '%Y-%m-%dT%H:%i:%s')) AS data_pedido, -- Extrai a data
        TIME(STR_TO_DATE(SUBSTRING(hora_data_pedido, 1, 19), '%Y-%m-%dT%H:%i:%s')) AS hora_pedido, -- Extrai a hora
        TIME_FORMAT(SEC_TO_TIME(tempo_real_ate_restaurante_seg),'%H:%i:%s') AS tempo_real_ate_restaurante,
        TIME_FORMAT(SEC_TO_TIME(tempo_estimado_ate_restaurante_seg),'%H:%i:%s') AS tempo_estimado_ate_restaurante,
        TIME_FORMAT(SEC_TO_TIME(tempo_real_ate_coleta_seg),'%H:%i:%s') AS tempo_real_ate_coleta,
        TIME_FORMAT(SEC_TO_TIME(tempo_entrega_real_seg),'%H:%i:%s') AS tempo_entrega_real,
        TIME_FORMAT(SEC_TO_TIME(tempo_entrega_estimado_seg),'%H:%i:%s') AS tempo_entrega_estimado,
        TIME_FORMAT(SEC_TO_TIME(atraso_pedido_seg),'%H:%i:%s') AS atraso_pedido,
        TIME_FORMAT(SEC_TO_TIME(atraso_entregador_seg),'%H:%i:%s') AS atraso_entregado,
        TIME_FORMAT(SEC_TO_TIME(atraso_restaurante_seg),'%H:%i:%s') AS atraso_restaurante
    FROM 
        banco_dados.ifoodcase
);
-- verificando o primeiro tratamento dos dados 
SELECT * FROM ifood_tratado;

-- verificando a quantidade de modal existente no Dataset
SELECT DISTINCT(modal) from ifood_tratado;
-- resultado  = 3 


-- Verificando a quantidade de Loja existente no dataset
SELECT COUNT(distinct(id_loja))
from ifood_tratado;
-- resultado 2249 restaurante cadastrado