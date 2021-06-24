#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jun 22 23:34:45 2021

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

def get_data(countries):  
    ingredients = []   
    for value in countries:
        top_100 = '''select i.ingredient_name
                            from region r
                            LEFT JOIN recipe rc USING (region_id)
                            LEFT JOIN ingredient_list il USING (recipe_id)
                            LEFT JOIN ingredient i USING (ingredient_id)
                            where r.region_name like \"%{country}%\"
                            GROUP BY i.ingredient_name
                            ORDER BY count(i.ingredient_name) desc
                            limit 100;'''.format(country = value)
        cursor.execute(top_100)
        table_rows = cursor.fetchall()
        listToStr = [''.join(i) for i in table_rows]
        ingredients.append(listToStr[:])
    df = pd.DataFrame(ingredients) 
    df_tr = df.transpose()
    df_tr.columns = countries   
    
    return df_tr
        
def compare_ingredients(df, countries):
    for i in range(1,len(countries)):
        a_set = set(df[countries[0]])
        b_set = set(df[countries[i]])
      
        if (a_set & b_set):
            d = (a_set & b_set)
            match = len(d)
        else:
            print("No common elements")
    
        df = df.drop(countries[i], axis = 1)
        df[countries[i]] = match / 100
        
    df = df.drop(countries[0], axis = 1)
    df = df.drop(df.index[1:], axis = 0)
    df = df.transpose()
    
    return df
        
if __name__ == "__main__":
    
    cnx = connection.MySQLConnection(user='root', password = password,
                                  host='localhost',
                                  database='culinary', auth_plugin='mysql_native_password')
    
    cursor = cnx.cursor(buffered=True)

    colors = ['blue','purple','brown','teal', 'olive']
    countries = ['British Isles', 'Indian Subcontinent', 'USA', 'Canada', 'Australia & NZ']
    countries2 = ['British Isles', 'China', 'Thailand', 'Japan', 'Korea']
    countries3 = ['British Isles', 'Belgian', 'France', 'DACH', 'Dutch', 'Scandinavia']
    
    
    british_colonies = get_data(countries)
    comp_british = compare_ingredients(british_colonies, countries)
    
    british_nocolonies = get_data(countries2)
    british_nocol = compare_ingredients(british_nocolonies, countries2)
    
    british_proximity = get_data(countries3)
    british_geo = compare_ingredients(british_proximity, countries3)
    
    
    plt.figure(1)
    plt.bar(comp_british.index, comp_british[0], color = colors)
    plt.title('Comparing British Isles\' Most Popular Ingredients\n to those of its Former Colonies', fontsize=14)
    plt.xlabel('Country', fontsize=12)
    plt.ylabel('% Similarity in Top 100 Ingredients', fontsize=12)
    plt.ylim(0,1)
    
    plt.figure(2)
    plt.bar(british_nocol.index, british_nocol[0], color = colors)
    plt.title('Comparing British Isles\' Most Popular Ingredients\n to Countries They Have Not Colonized', fontsize=14)
    plt.xlabel('Country', fontsize=12)
    plt.ylabel('% Similarity in Top 100 Ingredients', fontsize=12)
    plt.ylim(0,1)
    
    plt.figure(3)
    plt.bar(british_geo.index, british_geo[0], color = colors)
    plt.title('Comparing British Isles\' Most Popular Ingredients\n to those of its Geographic Neighbors', fontsize=14)
    plt.xlabel('Region', fontsize=12)
    plt.ylabel('% Similarity in Top 100 Ingredients', fontsize=12)
    plt.ylim(0,1)

    cursor.close()
    cnx.close()









