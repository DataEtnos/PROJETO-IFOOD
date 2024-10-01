# PROJETO-IFOOD

-  ![IFOOD](https://github.com/user-attachments/assets/3d97affc-2c17-40ea-906a-d15da9725e64)

Boa tarde, pessoal! Sou o Etnos, seu analista de dados.

Hoje, venho compartilhar mais um trabalho que vou adicionar ao meu portfólio, no qual combino técnicas e ferramentas de análise de dados. Neste projeto, utilizei SQL e o MySQL Workbench para realizar a extração, limpeza e transformação dos dados de um dataset do iFood.

Esse dataset é bastante interessante, pois apresenta desafios como a conversão de dados no formato ISO 8601, algo que exige atenção especial. Vou explicar detalhadamente como fiz a conversão, a separação das colunas de data e hora, além da exclusão de caracteres indesejados que vieram anexados ao dataset. Também realizei a conversão de alguns valores numéricos, como aqueles relacionados a seguros, e vou mostrar o código utilizado para essas transformações.

Para preservar a integridade da tabela original, criei uma nova tabela editada e pronta para análises. Realizei algumas consultas, descobrindo que o número total de lojas cadastradas é de cerca de 2.000. Os tipos de modais cadastrados são três: moto, bicicleta e e-bike (bicicletas de aplicativos). Nesta análise, desconsiderei a categoria e-bike.

Seguindo com as análises, identifiquei a quantidade de atrasos por categoria:

Moto: 11.705
Bicicleta: 623
Após essas análises, criei um CTE (Common Table Expression) para ajustar o dataset e adicionar algumas colunas faltantes. Também calculei a distância máxima percorrida por corrida, desde o aceite do entregador até a entrega, o tempo de atraso em relação ao estimado e o tempo que o entregador levou para chegar ao restaurante.

Em seguida, fiz mais algumas análises, que vou apresentar no Power BI. Toda a parte de limpeza de dados, verificação de valores nulos e duplicados foi realizada no MySQL. Agora, para uma visualização mais clara e interativa, utilizarei o Power BI.

Agora vou apresentar algumas métricas adicionais. O maior tempo de atraso de um pedido foi de 4 horas, 17 minutos e 32 segundos.

Abaixo do card, exibi duas tabelas. A primeira mostra o tempo de atraso de cada pedido por dia, número do pedido e ID da loja. A segunda tabela exibe a distância máxima percorrida por cada pedido. Os filtros de data estão conectados com as informações do dataset, permitindo que datas específicas sejam analisadas conforme necessário.

Na aba 2, mostrei a média de quilômetros rodados por todos os modais, considerando o número máximo de pedidos neste dataset, que é de 126 mil. Também exibi o número máximo de pedidos atrasados, que foi de 12 mil ao longo de todo o período analisado.

Depois, foquei na visualização da quantidade de pedidos por data, que exibi em um gráfico de linha mostrando todos os pedidos feitos no iFood por dia. Logo abaixo, repeti o gráfico para mostrar a quantidade de pedidos atrasados por dia.

Adicionei um gráfico de dispersão que correlaciona a distância máxima percorrida pelos pedidos com o tempo de entrega, dividido por modal — azul para motos e verde para bicicletas.

Na última etapa, mostrei a quantidade de pedidos feitos por hora, uma análise útil para identificar os horários de maior fluxo de pedidos. Essa informação pode ser usada para ajustar a quantidade de mão de obra nesses horários. Também destaquei os horários com maior fluxo de pedidos e, por fim, exibi novamente a quantidade de modais por categoria.

Por último, utilizei três gráficos de barras para analisar o impacto dos atrasos por modal. Vale ressaltar que, embora alguns pedidos sejam marcados como atrasados, nem sempre eles chegam realmente atrasados ao cliente. Portanto, esse gráfico de barras reflete apenas os pedidos que foram sinalizados como atrasados.

Com isso, encerro mais uma análise, combinando duas grandes ferramentas — MySQL e Power BI — e praticando ainda mais com ambas.


![Captura de tela 2024-10-01 154216](https://github.com/user-attachments/assets/f75b9b94-d2e4-4d5b-824b-44249d9f5cc4)

![Captura de tela 2024-10-01 154225](https://github.com/user-attachments/assets/4b43a70a-c3df-4b57-a5cb-983b3a92d632)
![Captura de tela 2024-10-01 154205](https://github.com/user-attachments/assets/47b8c48c-3255-4628-866a-100b15484f60)
