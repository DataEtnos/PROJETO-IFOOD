SELECT * FROM banco_dados.ifoodcase;

CREATE TABLE banco_dados.IFOOD_TRATADO AS (
    SELECT 
        id_loja,
        id_rota, 
        numero_pedido,
        modal,
        flag_atraso_entregador,
        flag_atraso_pedido,
        flag_atraso_restaurante,
        DATE(STR_TO_DATE(SUBSTRING(hora_data_pedido, 1, 19), '%Y-%m-%dT%H:%i:%s')) AS data_pedido,
        TIME(STR_TO_DATE(SUBSTRING(hora_data_pedido, 1, 19), '%Y-%m-%dT%H:%i:%s')) AS hora_pedido, 
        TIME_FORMAT(SEC_TO_TIME(tempo_real_ate_restaurante_seg),'%H:%i:%s') AS tempo_real_ate_restaurante,
        TIME_FORMAT(SEC_TO_TIME(tempo_estimado_ate_restaurante_seg),'%H:%i:%s') AS tempo_estimado_ate_restaurante,
        TIME_FORMAT(SEC_TO_TIME(tempo_real_ate_coleta_seg),'%H:%i:%s') AS tempo_real_ate_coleta,
        TIME_FORMAT(SEC_TO_TIME(tempo_entrega_real_seg),'%H:%i:%s') AS tempo_entrega_real,
        TIME_FORMAT(SEC_TO_TIME(tempo_entrega_estimado_seg),'%H:%i:%s') AS tempo_entrega_estimado,
        TIME_FORMAT(SEC_TO_TIME(atraso_pedido_seg),'%H:%i:%s') AS atraso_pedido,
        TIME_FORMAT(SEC_TO_TIME(atraso_entregador_seg),'%H:%i:%s') AS atraso_entregado,
        TIME_FORMAT(SEC_TO_TIME(atraso_restaurante_seg),'%H:%i:%s') AS atraso_restaurante,
        (distancia_restaurante_cliente_km +	distancia_ate_restaurante_km) AS Distancia_total
    FROM 
        banco_dados.ifoodcase
);
-- verificando o primeiro tratamento dos dados 
SELECT * FROM banco_dados.IFOOD_TRATADO
COMMIT;

-- DROP	TABLE IF EXISTS banco_dados.IFOOD_TRATADO; --- CASO PRECISE EXCLUIR A TABELA

-- Verificando se a tabela esta criada
SHOW TABLES LIKE 'banco_dados.IFOOD_TRATADO';


-- verificando a quantidade de modal existente no Dataset
SELECT DISTINCT(modal) from banco_dados.IFOOD_TRATADO;
-- resultado  = 3 


-- Verificando a quantidade de Loja existente no dataset
SELECT COUNT(distinct(id_loja))
from banco_dados.IFOOD_TRATADO;
-- resultado 2249 restaurante cadastrado



-- verificado quantidade de pedidos  com o qual o entregador se atrasou por loja
SELECT id_loja, count(flag_atraso_entregador) as confirmação_entregador_sim
from banco_dados.ifood_tratado
	where flag_atraso_entregador = 'true'
group by id_loja
order by confirmação_entregador_sim desc;

-- sendo o id_loja = 160510 com 386 pedidos atrasado por conta do entregador. 
-- Neste caso pode ter varias variaveis que possa atrasar o entregador em Sp muito possivelmente o transito , a chuva  ou a distancia que ele aceitou pegar .

 -- nesta cte retirei a diferença entre tempo_coleta ( que seria a forma de medir quanto tempo a coleta do pedido superou as estimativas ). 
 -- tambem nesta cte retirei os valores de diferença de tempo ( que seria a forma de medir quanto tempo a entrega levou a mais do que o previsto).
 WITH diferenca_tempo AS (
    SELECT 
        id_loja, 
        TIME_FORMAT(TIMEDIFF(tempo_entrega_estimado, tempo_entrega_real), '%H:%i:%s') AS diferenca_tempo
    FROM banco_dados.ifood_tratado
), 
tempo_diff AS (
    SELECT 
        t.id_rota,
        t.numero_pedido,
        t.modal,
        t.flag_atraso_entregador,
        t.flag_atraso_pedido,
        t.flag_atraso_restaurante,
        t.data_pedido,
        t.hora_pedido,
        t.tempo_real_ate_coleta,
        t.tempo_estimado_ate_restaurante,
        t.tempo_real_ate_restaurante,
        t.atraso_pedido,
        d.diferenca_tempo
    FROM 
        banco_dados.ifood_tratado t
    LEFT JOIN 
        diferenca_tempo d ON t.id_loja = d.id_loja
), 
entregador_tempo AS (
    SELECT 
		numero_pedido,
        id_rota, 
        modal,
        flag_atraso_entregador,
        flag_atraso_pedido,
        flag_atraso_restaurante,
        data_pedido,
        hora_pedido,
        tempo_real_ate_coleta,
        tempo_estimado_ate_restaurante,
        tempo_real_ate_restaurante,
        atraso_pedido,
        TIME_FORMAT(TIMEDIFF(e.tempo_real_ate_coleta, e.tempo_estimado_ate_restaurante), '%H:%i:%s') AS Tempo_coleta,
        d.diferenca_tempo
       
    FROM 
        banco_dados.ifood_tratado e
    LEFT JOIN 
        diferenca_tempo d ON e.id_loja = d.id_loja
),
limpeza_duplicadas as(
select *, row_number()
over(partition by numero_pedido order by id_loja) as rn,
TIME_FORMAT(TIMEDIFF(tempo_entrega_estimado, tempo_entrega_real), '%H:%i:%s') AS diferenca_tempo,
 TIME_FORMAT(TIMEDIFF(tempo_real_ate_coleta, tempo_estimado_ate_restaurante), '%H:%i:%s') AS Tempo_coleta
 FROM banco_dados.ifood_tratado
)
select * from 
limpeza_duplicadas 
where rn =1;




-- quantidade de atraso por modal
    
SELECT  modal,count(
flag_atraso_entregador) as atraso
from banco_dados.ifood_tratado
WHERE  flag_atraso_entregador = 'true'
group by modal;

-- sendo contado 11.705 entregas atrasadas pelo modal motorcycle e de bicycle temos o numero de 623


SELECT * FROM banco_dados.ifood_tratado;



-- top 100 lojas com os maiores atrasos de pedido (Flag restaurante) -- erro de operação

SELECT id_loja,count(flag_atraso_restaurante) as atraso
from banco_dados.ifood_tratado 
WHERE  flag_atraso_restaurante = 'true'
group by id_loja 
order by atraso desc limit 100;
-- os maiores numeros encontrados de atrasos e de 103 ate 625


-- pedidos atrasado por dia e loja e quantidade de atraso por dia
SELECT id_loja,data_pedido,
 count(
case when flag_atraso_restaurante ='true' then 1 end) as atraso_restaurante
from banco_dados.ifood_tratado
group by id_loja, data_pedido
having   count(
case when flag_atraso_restaurante ='true' then 1 end) >0
order by data_pedido ;

SELECT count(*)
 FROM banco_dados.ifood_tratado;

SELECT modal,
count(modal)
FROM banco_dados.ifood_tratado
group by modal;

select *  from  banco_dados.ifood_tratado
where atraso_pedido >'03:00:00';

