#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jun 16 20:10:51 2021
@author: Ashna
Modified by Spenser 
"""
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import numpy as np
from secret import *
from wordcloud import WordCloud
from mysql.connector import (connection)

cnx = connection.MySQLConnection(user='root', password = "tsMiL25jRVeRvtuX",
                              host='localhost',
                              database='culinary', auth_plugin='mysql_native_password')

cursor = cnx.cursor(buffered=True)



query = ("""
SELECT region_name, ingredient_name, count(*) as total_use
FROM ingredient
	INNER JOIN ingredient_list USING (ingredient_id)
    INNER JOIN recipe USING (recipe_id)
    INNER JOIN region USING (region_id)
WHERE ingredient.category like "%Spice%"
GROUP BY ingredient_name, region_id
ORDER BY ingredient_name, total_use desc;
""")

cursor.execute(query)
table_rows = cursor.fetchall()

df = pd.DataFrame(table_rows, columns = ["region_name", "spice_name", "total_use"])
df = df.replace('\r',' ', regex=True)

query = ("""
SELECT region_name, ingredient_name, count(*) as total_use
FROM ingredient
	INNER JOIN ingredient_list USING (ingredient_id)
    INNER JOIN recipe USING (recipe_id)
    INNER JOIN region USING (region_id)
WHERE ingredient.category like "%Spice%"
GROUP BY ingredient_name, region_id
ORDER BY ingredient_name, total_use desc;
""")

cursor.execute(query)
table_rows = cursor.fetchall()

df = pd.DataFrame(table_rows, columns = ["region_name", "spice_name", "total_use"])

# g = df.groupby(['region','category','%_ingredients'])
regions = np.unique(df["region_name"])
spices = np.unique(df["spice_name"])
regions = [str.replace("Misc.:", "") for str in regions]

result = df.pivot(index ="region_name", columns="spice_name", values="total_use")
result.fillna(0, inplace=True)
print(result)

plt.figure(1)
sns.heatmap(result, square=True, vmax=500)

plt.rcParams['font.family'] = "serif"
plt.xlabel("Ingredient Categories", fontsize = 12)
plt.ylabel("Regions", fontsize = 12)

plt.xticks(np.arange(0,spices.size,1)+0.5, labels = spices, size=8, fontname= "Caslon")
plt.yticks(np.arange(0,len(regions),1)+0.5, labels = regions, size = 8, 
           va ="center", fontname= "Caslon")
# plt.tight_layout()

title = "Recipe Compositions by Ingredient Category per Region"
plt.title(title, fontsize=12, fontweight='bold')
plt.show()

cursor.close()
cnx.close()