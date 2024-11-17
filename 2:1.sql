-- Не используйте JOIN для выполнения заданий!
-- Назовем “успешными” (’rich’) селлерами тех:  кто продает более одной категории товаров и чья суммарная выручка превышает 50 000
-- Остальные селлеры (продают более одной категории, но чья суммарная выручка менее 50 000) будут обозначаться как ‘poor’. 
-- Выведите для каждого продавца 1)количество категорий, 2)средний рейтинг его категорий, 3)суммарную выручку,
-- а также метку ‘poor’ или ‘rich’.
-- Назовите поля: seller_id, total_categ, avg_rating, total_revenue, seller_type.Выведите ответ по возрастанию id селлера.
-- Примечание: Категория “Bedding” не должна учитываться в расчетах.

select 
	   seller_id,
	   count(distinct category) as totlal_categ, -- Количество уникальных категорий (без 'Bedding')
	   round(AVG(rating), 2) AS avg_rating, -- Средний рейтинг
	   sum(revenue) as total_revenue, -- Суммарная выручка
	   case -- Используем CASE, ибо требуется метка в одном столбце на основе условий
		   when count(distinct category) > 1 and sum(revenue) > 50000 then 'rich'
		   when count(distinct category) > 1 then 'poor' -- Условия
	   end as seller_type -- Создание метки успешности	   
from 
    sellers 
where 
     category != 'Bedding' -- Это условие выполняется сразу после "from"
group by 
       seller_id -- Группируем по продавцу
order by  
   		seller_id ASC -- Сортируем по возрастанию идентификатора продавца
