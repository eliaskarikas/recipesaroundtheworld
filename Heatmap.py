#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jun 16 20:10:51 2021

@author: Ashna
"""
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import numpy as np
from secret import *
from wordcloud import WordCloud
from mysql.connector import (connection)
from PIL import Image
import functools
import operator 

cnx = connection.MySQLConnection(user='root', password = password,
                              host='localhost',
                              database='culinary', auth_plugin='mysql_native_password')

cursor = cnx.cursor(buffered=True)



query = ("Select r, c, (ingredients_per_category / total_ingredients) percent_ingredients from ( "
"select r.region_id ra, r.region_name r, count(*) total_ingredients "
"from region r "
"LEFT JOIN recipe rc USING (region_id) "
"LEFT JOIN ingredient_list il USING (recipe_id) "
"LEFT JOIN ingredient i USING (ingredient_id) "
" GROUP BY r.region_id, r.region_name ) as table_a, "
"( "
"select distinct r.region_id ra2, i.category c, count(*) ingredients_per_category "
"from region r "
"LEFT JOIN recipe rc USING (region_id) "
"LEFT JOIN ingredient_list il USING (recipe_id) "
"LEFT JOIN ingredient i USING (ingredient_id) "
"GROUP BY r.region_id, i.category) as table_b "
"where ra = ra2 and c is NOT NULL "
"order by ra, c;")

cursor.execute(query)
table_rows = cursor.fetchall()
print(table_rows)

df = pd.DataFrame(table_rows, columns = ["region", "category", "%_ingredients"])
df = df.replace('\r',' ', regex=True)
df = df.replace('Misc.: ','', regex=True)

g = df.groupby(['region','category','%_ingredients'])
df['%_ingredients'] = df['%_ingredients'].astype('float')
regions = df["region"]

result = df.pivot(index ="region", columns="category", values="%_ingredients")
result.fillna(0, inplace=True)

plt.figure(1)
sns.heatmap(result, square = True)

plt.rcParams['font.family'] = "serif"
plt.xlabel("Ingredient Categories", fontsize = 12)
plt.ylabel("Regions", fontsize = 12)

plt.xticks(np.arange(0,22,1)+0.5, size=8, fontname= "Caslon")
plt.yticks(np.arange(0,26,1)+0.5, labels = np.unique(regions), size = 8, 
            va ="center", fontname= "Caslon")

title = "Recipe Compositions by Ingredient Category per Region"
plt.title(title, fontsize=12, fontweight='bold'                                                                                                                       )
plt.show()

british_ingredients= ("select i.ingredient_name "
"from region r "
"LEFT JOIN recipe rc USING (region_id) "
"LEFT JOIN ingredient_list il USING (recipe_id) "
"LEFT JOIN ingredient i USING (ingredient_id) "
"where r.region_name = 'British Isles\r';" )

cursor.execute(british_ingredients)
table_rows2 = cursor.fetchall()
listToStr = ' '.join([str(elem[0]) for elem in table_rows2])
wordcloud = WordCloud(width=480, height=480, margin=0).generate(listToStr)

plt.figure(2)
plt.imshow(wordcloud, interpolation='bilinear')
plt.axis("off")
plt.title("Most Popular British Ingredients", fontsize = 11)
plt.margins(x=0, y=0)
plt.show()


cursor.close()
cnx.close()



    
