#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jun 21 15:11:04 2021

@author: eliaskarikas
"""


import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import numpy as np

ob_under = 'nutritiongdp.csv'
#ob_under = 'obesity_gdp.csv'

df_ob = pd.read_csv(ob_under)


corr = df_ob.corr()
# Generate a mask for the upper triangle
mask = np.triu(np.ones_like(corr, dtype=bool))

# Generate a custom diverging colormap
cmap = sns.color_palette("vlag", as_cmap=True)


# Creating correlation matrix, w GDP info
sns.heatmap(df_ob.corr(),cmap=cmap, mask = mask, annot=True,
            xticklabels = ['GDP','Calories','Carbs','Fat',
                           'Animal_Protein','Plant_Protein','Obesity',
                           'Undernourishment'],
            yticklabels=['GDP','Calories','Carbs','Fat',
                           'Animal_Protein','Plant_Protein','Obesity',
                           'Undernourishment'])
plt.yticks(rotation=0)


'''Creating lineplots for nutrition data'''
ob_under = 'nutrition.csv'

df_ob = pd.read_csv(ob_under)

df_new = df_ob.drop(columns= ['avg_gdp'])

g = sns.lineplot(x='name',data=df_new, palette="tab10", linewidth=2.5)

g.set_xticklabels(df_new['name'].tolist(),rotation=90)
plt.legend(loc="upper center", bbox_to_anchor=(0.5, 1.15), ncol=2)


''' graphing undernourishment/obeity & GDP'''
ob_under = 'undernourishment_obesity.csv'

df_ob = pd.read_csv(ob_under)
sns.set_style('whitegrid')
sns.regplot(x=df_ob['obesity_pop'],y=df_ob['undernourishment'],
             logx=True,marker = '+',line_kws={'color':'g'})

plt.title('Undernourishment vs Obesity')



sns.set_style('whitegrid')
sns.regplot(x=df_ob['avg_gdp'],y=df_ob['undernourishment'],
             logx=True,marker = '+',scatter_kws={"color": "b",'alpha' : .7},
             line_kws={'color':'red'})

plt.title('GDP vs Undernourishment')


print(df_ob[df_ob['obesity_pop'] > 40])
