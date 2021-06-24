use recipes;

select *
from diet;

delete from disease;
select *
from disease;

-- Altering intial design
alter table disease add gdp varchar(50);

-- creating view to increase performance?
create view gdprank as
select 
	country_id,
    region_id,
	name, 
    year,
    gdp	
from country c join disease using(country_id);

-- region data / nutrition / gdp
select 
	r.name, 
    round(avg(gdp),2) avg_gdp,
    round(avg(calories),2) avg_calories,
    round(avg(carbs),2) avg_carbs,
	round(avg(fat),2) avg_fat, 
	round(avg(animal_protein),2) avg_animal_protein,
    round(avg(plant_protein),2) avg_plant_protein ,
    round(avg(obesity_popshare),2) avg_obesity,
    round(avg(undernourishment),2) avg_undernourishment
from region r join country using(region_id)
join disease d using(country_id)
join diet_composition dc USING(country_id)
where dc.year > 2000 and d.year> 2000
group by r.name
order by  avg_gdp desc, avg_calories desc;

-- avg gdp per country
select 
	c.name, 
	round(avg(gdp),2) avg_gdp    
from ingredient 
	join ingredient_list using(ingredient_id)
	join recipe re using(recipe_id)
	join region r using(region_id)
	join country c using(region_id)
	join disease d using(country_id)
where d.year > 2000
group by c.name;

-- gdp/undernourishment
select 
	c.name, 
    round(avg(obesity_popshare),2) obesity_pop,
    round(avg(undernourishment),2) undernourishment, 
    round(avg(gdp),2) avg_gdp
from country c join disease using(country_id)
where year > 2000 and undernourishment > 0
group by c.name
order by obesity_pop desc;

-- ingredient counts by gdp/country
select g.name, count(i.name) ingredient_count, round(gdp,1) gdp
from recipe join gdprank g using(region_id)
join ingredient_list using(recipe_id)
join ingredient i using(ingredient_id)
where year = 2016 
group by g.name, g.gdp
order by g.gdp desc;

    
select avg(gdp), r.name, count(i.name)
from gdprank join region r using(region_id)
join recipe using(region_id)
join ingredient_list using(recipe_id)
join ingredient i using(ingredient_id)
group by r.name;

-- creating view with variable info
drop view ingredient_region;

create view ingredient_region as
select count(i.name) ingredient_count, recipe_name, r.name region_name, avg(gdp) gdp
from ingredient i join ingredient_list using(ingredient_id)
join recipe re using(recipe_id)
join region r using(region_id)
join gdprank using(region_id)
where year = 2016
group by r.name, recipe_name;

select *
from ingredient_region;

select count(distinct i.name) ingredient_count, r.name region_name, avg(gdp) gdp
from ingredient i join ingredient_list using(ingredient_id)
join recipe re using(recipe_id)
join region r using(region_id)
join gdprank using(region_id)
where year = 2016
group by r.name;

-- Counting ingredients per region/recipe
select count(i.name), recipe_name, r.name
from ingredient i join ingredient_list using(ingredient_id)
join recipe re using(recipe_id)
join region r using(region_id)
group by recipe_name, r.name;

select avg(i.name) avg_recipe_ingredient, r.name region_name, avg(gdp) gdp
from ingredient i join ingredient_list using(ingredient_id)
join recipe re using(recipe_id)
join region r using(region_id)
join gdprank using(region_id)
where year = 2016
group by r.name;


select *
from ingredient_region
INTO OUTFILE 'C:/eliaskarikas/Desktop/CS3200/project/ingredient_region.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ';' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';

show variables like "secure_file_priv";

