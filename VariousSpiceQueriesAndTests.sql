SELECT region_name, ingredient_name, count(*) as total_use
FROM ingredient
	INNER JOIN ingredient_list USING (ingredient_id)
    INNER JOIN recipe USING (recipe_id)
    INNER JOIN region USING (region_id)
WHERE ingredient.category like "%Spice%"
GROUP BY ingredient_name, region_id
ORDER BY ingredient_name, total_use desc;

SELECT region_name, ingredient_name, count(*) as total_use
FROM ingredient
	INNER JOIN ingredient_list USING (ingredient_id)
    INNER JOIN recipe USING (recipe_id)
    INNER JOIN region USING (region_id)
WHERE ingredient.category like "%Spice%"
GROUP BY ingredient_name, region_id
ORDER BY total_use desc, ingredient_name;

SELECT region_name, count(*) as total_used
FROM ingredient
	INNER JOIN ingredient_list USING (ingredient_id)
    INNER JOIN recipe USING (recipe_id)
    INNER JOIN region USING (region_id)
GROUP BY region_id
ORDER BY total_used desc;

select region_name, country_name
from country
	INNER JOIN region USING (region_id)
where region_name not like "%NoMatch%"
order by region_name;

select *
FROM recipe
	inner join region USING (region_id)
WHERE region_name like "%USA%";