-- Не используйте JOIN для выполнения заданий!
-- Назовем “успешными” (’rich’) селлерами тех:  кто продает более одной категории товаров и чья суммарная выручка превышает 50 000
-- Остальные селлеры (продают более одной категории, но чья суммарная выручка менее 50 000) будут обозначаться как ‘poor’. 
-- Выведите для каждого продавца 1)количество категорий, 2)средний рейтинг его категорий, 3)суммарную выручку,
-- а также метку ‘poor’ или ‘rich’.
-- Назовите поля: seller_id, total_categ, avg_rating, total_revenue, seller_type.Выведите ответ по возрастанию id селлера.
-- Примечание: Категория “Bedding” не должна учитываться в расчетах.


SELECT 
	   seller_id,
	   COUNT(DISTINCT category) AS totlal_categ, -- Количество уникальных категорий (без 'Bedding')
	   ROUND(AVG(rating), 2) AS avg_rating, -- Средний рейтинг
	   SUM(revenue) AS total_revenue, -- Суммарная выручка
	   CASE -- Используем CASE, ибо требуется метка в одном столбце на основе условий
		   WHEN COUNT(DISTINCT category) > 1 AND SUM(revenue) > 50000 THEN 'rich'
		   WHEN COUNT(DISTINCT category) > 1 THEN 'poor' -- Условия
	   END AS seller_type -- Создание метки успешности	   
FROM 
    sellers 
WHERE 
     category != 'Bedding' -- Это условие выполняется сразу после "FROM"
GROUP BY 
       seller_id -- Группируем по продавцу
ORDER BY  
   		seller_id ASC -- Сортируем по возрастанию идентификатора продавца
