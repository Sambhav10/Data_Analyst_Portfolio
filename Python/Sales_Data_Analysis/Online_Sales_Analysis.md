```python
#Online Sales data analysis using python
```


```python
#Business Task

#1. Analyze sales trends over time to identify  patterns or growth opportunities.
#2. Explore the popularity of different product categories across regions.
#3. Investigate the impact of payment methods on sales volume or revenue.
#4. Identify top-selling products within each category to optimize inventory and marketing strategies.
#5. Evaluate the performance of specific products or categories in different regions to tailor marketing campaigns accordingly.
```


```python
#importing pandas and seaborn and matplotlib
```


```python
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
```


```python
# loading the sales data 
df = pd.read_csv('Online Sales Data.csv')
```


```python
df.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 240 entries, 0 to 239
    Data columns (total 9 columns):
     #   Column            Non-Null Count  Dtype  
    ---  ------            --------------  -----  
     0   Transaction ID    240 non-null    int64  
     1   Date              240 non-null    object 
     2   Product Category  240 non-null    object 
     3   Product Name      240 non-null    object 
     4   Units Sold        240 non-null    int64  
     5   Unit Price        240 non-null    float64
     6   Total Revenue     240 non-null    float64
     7   Region            240 non-null    object 
     8   Payment Method    240 non-null    object 
    dtypes: float64(2), int64(2), object(5)
    memory usage: 17.0+ KB
    


```python
df.head(10)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Transaction ID</th>
      <th>Date</th>
      <th>Product Category</th>
      <th>Product Name</th>
      <th>Units Sold</th>
      <th>Unit Price</th>
      <th>Total Revenue</th>
      <th>Region</th>
      <th>Payment Method</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10001</td>
      <td>2024-01-01</td>
      <td>Electronics</td>
      <td>iPhone 14 Pro</td>
      <td>2</td>
      <td>999.99</td>
      <td>1999.98</td>
      <td>North America</td>
      <td>Credit Card</td>
    </tr>
    <tr>
      <th>1</th>
      <td>10002</td>
      <td>2024-01-02</td>
      <td>Home Appliances</td>
      <td>Dyson V11 Vacuum</td>
      <td>1</td>
      <td>499.99</td>
      <td>499.99</td>
      <td>Europe</td>
      <td>PayPal</td>
    </tr>
    <tr>
      <th>2</th>
      <td>10003</td>
      <td>2024-01-03</td>
      <td>Clothing</td>
      <td>Levi's 501 Jeans</td>
      <td>3</td>
      <td>69.99</td>
      <td>209.97</td>
      <td>Asia</td>
      <td>Debit Card</td>
    </tr>
    <tr>
      <th>3</th>
      <td>10004</td>
      <td>2024-01-04</td>
      <td>Books</td>
      <td>The Da Vinci Code</td>
      <td>4</td>
      <td>15.99</td>
      <td>63.96</td>
      <td>North America</td>
      <td>Credit Card</td>
    </tr>
    <tr>
      <th>4</th>
      <td>10005</td>
      <td>2024-01-05</td>
      <td>Beauty Products</td>
      <td>Neutrogena Skincare Set</td>
      <td>1</td>
      <td>89.99</td>
      <td>89.99</td>
      <td>Europe</td>
      <td>PayPal</td>
    </tr>
    <tr>
      <th>5</th>
      <td>10006</td>
      <td>2024-01-06</td>
      <td>Sports</td>
      <td>Wilson Evolution Basketball</td>
      <td>5</td>
      <td>29.99</td>
      <td>149.95</td>
      <td>Asia</td>
      <td>Credit Card</td>
    </tr>
    <tr>
      <th>6</th>
      <td>10007</td>
      <td>2024-01-07</td>
      <td>Electronics</td>
      <td>MacBook Pro 16-inch</td>
      <td>1</td>
      <td>2499.99</td>
      <td>2499.99</td>
      <td>North America</td>
      <td>Credit Card</td>
    </tr>
    <tr>
      <th>7</th>
      <td>10008</td>
      <td>2024-01-08</td>
      <td>Home Appliances</td>
      <td>Blueair Classic 480i</td>
      <td>2</td>
      <td>599.99</td>
      <td>1199.98</td>
      <td>Europe</td>
      <td>PayPal</td>
    </tr>
    <tr>
      <th>8</th>
      <td>10009</td>
      <td>2024-01-09</td>
      <td>Clothing</td>
      <td>Nike Air Force 1</td>
      <td>6</td>
      <td>89.99</td>
      <td>539.94</td>
      <td>Asia</td>
      <td>Debit Card</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10010</td>
      <td>2024-01-10</td>
      <td>Books</td>
      <td>Dune by Frank Herbert</td>
      <td>2</td>
      <td>25.99</td>
      <td>51.98</td>
      <td>North America</td>
      <td>Credit Card</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.shape
```




    (240, 9)




```python
# checking if there is any null values 
df.isna().sum()
```




    Transaction ID      0
    Date                0
    Product Category    0
    Product Name        0
    Units Sold          0
    Unit Price          0
    Total Revenue       0
    Region              0
    Payment Method      0
    dtype: int64




```python
# checking for any duplicates 
df[df.duplicated() == True]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Transaction ID</th>
      <th>Date</th>
      <th>Product Category</th>
      <th>Product Name</th>
      <th>Units Sold</th>
      <th>Unit Price</th>
      <th>Total Revenue</th>
      <th>Region</th>
      <th>Payment Method</th>
    </tr>
  </thead>
  <tbody>
  </tbody>
</table>
</div>




```python
#renaming columns 
df = df.rename(columns = {
     'Transaction ID' : 'transaction_ID',
     'Date' : 'date',
     'Product Category': 'product_category',
     'Product Name' : 'product_name',
    'Units Sold': 'units_sold',
    'Unit Price': 'unit_price', 
    'Total Revenue': 'total_revenue',
    'Region': 'region',
    'Payment Method' : 'payment_method' 
})
```


```python
df.head(10)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>transaction_ID</th>
      <th>date</th>
      <th>product_category</th>
      <th>product_name</th>
      <th>units_sold</th>
      <th>unit_price</th>
      <th>total_revenue</th>
      <th>region</th>
      <th>payment_method</th>
      <th>month_number</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10001</td>
      <td>2024-01-01</td>
      <td>Electronics</td>
      <td>iPhone 14 Pro</td>
      <td>2</td>
      <td>999.99</td>
      <td>1999.98</td>
      <td>North America</td>
      <td>Credit Card</td>
      <td>01</td>
    </tr>
    <tr>
      <th>1</th>
      <td>10002</td>
      <td>2024-01-02</td>
      <td>Home Appliances</td>
      <td>Dyson V11 Vacuum</td>
      <td>1</td>
      <td>499.99</td>
      <td>499.99</td>
      <td>Europe</td>
      <td>PayPal</td>
      <td>01</td>
    </tr>
    <tr>
      <th>2</th>
      <td>10003</td>
      <td>2024-01-03</td>
      <td>Clothing</td>
      <td>Levi's 501 Jeans</td>
      <td>3</td>
      <td>69.99</td>
      <td>209.97</td>
      <td>Asia</td>
      <td>Debit Card</td>
      <td>01</td>
    </tr>
    <tr>
      <th>3</th>
      <td>10004</td>
      <td>2024-01-04</td>
      <td>Books</td>
      <td>The Da Vinci Code</td>
      <td>4</td>
      <td>15.99</td>
      <td>63.96</td>
      <td>North America</td>
      <td>Credit Card</td>
      <td>01</td>
    </tr>
    <tr>
      <th>4</th>
      <td>10005</td>
      <td>2024-01-05</td>
      <td>Beauty Products</td>
      <td>Neutrogena Skincare Set</td>
      <td>1</td>
      <td>89.99</td>
      <td>89.99</td>
      <td>Europe</td>
      <td>PayPal</td>
      <td>01</td>
    </tr>
    <tr>
      <th>5</th>
      <td>10006</td>
      <td>2024-01-06</td>
      <td>Sports</td>
      <td>Wilson Evolution Basketball</td>
      <td>5</td>
      <td>29.99</td>
      <td>149.95</td>
      <td>Asia</td>
      <td>Credit Card</td>
      <td>01</td>
    </tr>
    <tr>
      <th>6</th>
      <td>10007</td>
      <td>2024-01-07</td>
      <td>Electronics</td>
      <td>MacBook Pro 16-inch</td>
      <td>1</td>
      <td>2499.99</td>
      <td>2499.99</td>
      <td>North America</td>
      <td>Credit Card</td>
      <td>01</td>
    </tr>
    <tr>
      <th>7</th>
      <td>10008</td>
      <td>2024-01-08</td>
      <td>Home Appliances</td>
      <td>Blueair Classic 480i</td>
      <td>2</td>
      <td>599.99</td>
      <td>1199.98</td>
      <td>Europe</td>
      <td>PayPal</td>
      <td>01</td>
    </tr>
    <tr>
      <th>8</th>
      <td>10009</td>
      <td>2024-01-09</td>
      <td>Clothing</td>
      <td>Nike Air Force 1</td>
      <td>6</td>
      <td>89.99</td>
      <td>539.94</td>
      <td>Asia</td>
      <td>Debit Card</td>
      <td>01</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10010</td>
      <td>2024-01-10</td>
      <td>Books</td>
      <td>Dune by Frank Herbert</td>
      <td>2</td>
      <td>25.99</td>
      <td>51.98</td>
      <td>North America</td>
      <td>Credit Card</td>
      <td>01</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.tail(10)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>transaction_ID</th>
      <th>date</th>
      <th>product_category</th>
      <th>product_name</th>
      <th>units_sold</th>
      <th>unit_price</th>
      <th>total_revenue</th>
      <th>region</th>
      <th>payment_method</th>
      <th>month_number</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>230</th>
      <td>10231</td>
      <td>2024-08-18</td>
      <td>Clothing</td>
      <td>Adidas Originals Trefoil Hoodie</td>
      <td>4</td>
      <td>64.99</td>
      <td>259.96</td>
      <td>Asia</td>
      <td>Debit Card</td>
      <td>08</td>
    </tr>
    <tr>
      <th>231</th>
      <td>10232</td>
      <td>2024-08-19</td>
      <td>Books</td>
      <td>Dune by Frank Herbert</td>
      <td>2</td>
      <td>9.99</td>
      <td>19.98</td>
      <td>North America</td>
      <td>Credit Card</td>
      <td>08</td>
    </tr>
    <tr>
      <th>232</th>
      <td>10233</td>
      <td>2024-08-20</td>
      <td>Beauty Products</td>
      <td>Fresh Sugar Lip Treatment</td>
      <td>1</td>
      <td>24.00</td>
      <td>24.00</td>
      <td>Europe</td>
      <td>PayPal</td>
      <td>08</td>
    </tr>
    <tr>
      <th>233</th>
      <td>10234</td>
      <td>2024-08-21</td>
      <td>Sports</td>
      <td>Hydro Flask Standard Mouth Water Bottle</td>
      <td>3</td>
      <td>32.95</td>
      <td>98.85</td>
      <td>Asia</td>
      <td>Credit Card</td>
      <td>08</td>
    </tr>
    <tr>
      <th>234</th>
      <td>10235</td>
      <td>2024-08-22</td>
      <td>Electronics</td>
      <td>Bose QuietComfort 35 II Wireless Headphones</td>
      <td>1</td>
      <td>299.00</td>
      <td>299.00</td>
      <td>North America</td>
      <td>Credit Card</td>
      <td>08</td>
    </tr>
    <tr>
      <th>235</th>
      <td>10236</td>
      <td>2024-08-23</td>
      <td>Home Appliances</td>
      <td>Nespresso Vertuo Next Coffee and Espresso Maker</td>
      <td>1</td>
      <td>159.99</td>
      <td>159.99</td>
      <td>Europe</td>
      <td>PayPal</td>
      <td>08</td>
    </tr>
    <tr>
      <th>236</th>
      <td>10237</td>
      <td>2024-08-24</td>
      <td>Clothing</td>
      <td>Nike Air Force 1 Sneakers</td>
      <td>3</td>
      <td>90.00</td>
      <td>270.00</td>
      <td>Asia</td>
      <td>Debit Card</td>
      <td>08</td>
    </tr>
    <tr>
      <th>237</th>
      <td>10238</td>
      <td>2024-08-25</td>
      <td>Books</td>
      <td>The Handmaid's Tale by Margaret Atwood</td>
      <td>3</td>
      <td>10.99</td>
      <td>32.97</td>
      <td>North America</td>
      <td>Credit Card</td>
      <td>08</td>
    </tr>
    <tr>
      <th>238</th>
      <td>10239</td>
      <td>2024-08-26</td>
      <td>Beauty Products</td>
      <td>Sunday Riley Luna Sleeping Night Oil</td>
      <td>1</td>
      <td>55.00</td>
      <td>55.00</td>
      <td>Europe</td>
      <td>PayPal</td>
      <td>08</td>
    </tr>
    <tr>
      <th>239</th>
      <td>10240</td>
      <td>2024-08-27</td>
      <td>Sports</td>
      <td>Yeti Rambler 20 oz Tumbler</td>
      <td>2</td>
      <td>29.99</td>
      <td>59.98</td>
      <td>Asia</td>
      <td>Credit Card</td>
      <td>08</td>
    </tr>
  </tbody>
</table>
</div>




```python
# spliting the month number from the date column and adding it to a new  Month column
```


```python
df['month_number'] = df['date'].str.split('-').str.get(1)
```


```python
df.head(10)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>transaction_ID</th>
      <th>date</th>
      <th>product_category</th>
      <th>product_name</th>
      <th>units_sold</th>
      <th>unit_price</th>
      <th>total_revenue</th>
      <th>region</th>
      <th>payment_method</th>
      <th>month_number</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10001</td>
      <td>2024-01-01</td>
      <td>Electronics</td>
      <td>iPhone 14 Pro</td>
      <td>2</td>
      <td>999.99</td>
      <td>1999.98</td>
      <td>North America</td>
      <td>Credit Card</td>
      <td>01</td>
    </tr>
    <tr>
      <th>1</th>
      <td>10002</td>
      <td>2024-01-02</td>
      <td>Home Appliances</td>
      <td>Dyson V11 Vacuum</td>
      <td>1</td>
      <td>499.99</td>
      <td>499.99</td>
      <td>Europe</td>
      <td>PayPal</td>
      <td>01</td>
    </tr>
    <tr>
      <th>2</th>
      <td>10003</td>
      <td>2024-01-03</td>
      <td>Clothing</td>
      <td>Levi's 501 Jeans</td>
      <td>3</td>
      <td>69.99</td>
      <td>209.97</td>
      <td>Asia</td>
      <td>Debit Card</td>
      <td>01</td>
    </tr>
    <tr>
      <th>3</th>
      <td>10004</td>
      <td>2024-01-04</td>
      <td>Books</td>
      <td>The Da Vinci Code</td>
      <td>4</td>
      <td>15.99</td>
      <td>63.96</td>
      <td>North America</td>
      <td>Credit Card</td>
      <td>01</td>
    </tr>
    <tr>
      <th>4</th>
      <td>10005</td>
      <td>2024-01-05</td>
      <td>Beauty Products</td>
      <td>Neutrogena Skincare Set</td>
      <td>1</td>
      <td>89.99</td>
      <td>89.99</td>
      <td>Europe</td>
      <td>PayPal</td>
      <td>01</td>
    </tr>
    <tr>
      <th>5</th>
      <td>10006</td>
      <td>2024-01-06</td>
      <td>Sports</td>
      <td>Wilson Evolution Basketball</td>
      <td>5</td>
      <td>29.99</td>
      <td>149.95</td>
      <td>Asia</td>
      <td>Credit Card</td>
      <td>01</td>
    </tr>
    <tr>
      <th>6</th>
      <td>10007</td>
      <td>2024-01-07</td>
      <td>Electronics</td>
      <td>MacBook Pro 16-inch</td>
      <td>1</td>
      <td>2499.99</td>
      <td>2499.99</td>
      <td>North America</td>
      <td>Credit Card</td>
      <td>01</td>
    </tr>
    <tr>
      <th>7</th>
      <td>10008</td>
      <td>2024-01-08</td>
      <td>Home Appliances</td>
      <td>Blueair Classic 480i</td>
      <td>2</td>
      <td>599.99</td>
      <td>1199.98</td>
      <td>Europe</td>
      <td>PayPal</td>
      <td>01</td>
    </tr>
    <tr>
      <th>8</th>
      <td>10009</td>
      <td>2024-01-09</td>
      <td>Clothing</td>
      <td>Nike Air Force 1</td>
      <td>6</td>
      <td>89.99</td>
      <td>539.94</td>
      <td>Asia</td>
      <td>Debit Card</td>
      <td>01</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10010</td>
      <td>2024-01-10</td>
      <td>Books</td>
      <td>Dune by Frank Herbert</td>
      <td>2</td>
      <td>25.99</td>
      <td>51.98</td>
      <td>North America</td>
      <td>Credit Card</td>
      <td>01</td>
    </tr>
  </tbody>
</table>
</div>




```python
##### ANALYSIS #####
```


```python
# #1. Analyze sales trends over time to identify patterns or growth opportunities.
```


```python
 monthly_sales = df.groupby('month_number')['total_revenue'].agg(['sum']).sort_values('sum', ascending = False)
monthly_sales
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>sum</th>
    </tr>
    <tr>
      <th>month_number</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>01</th>
      <td>14548.32</td>
    </tr>
    <tr>
      <th>03</th>
      <td>12849.24</td>
    </tr>
    <tr>
      <th>04</th>
      <td>12451.69</td>
    </tr>
    <tr>
      <th>02</th>
      <td>10803.37</td>
    </tr>
    <tr>
      <th>05</th>
      <td>8455.49</td>
    </tr>
    <tr>
      <th>06</th>
      <td>7384.55</td>
    </tr>
    <tr>
      <th>08</th>
      <td>7278.11</td>
    </tr>
    <tr>
      <th>07</th>
      <td>6797.08</td>
    </tr>
  </tbody>
</table>
</div>




```python
plt.figure(figsize= (10, 6))
sns.lineplot(data = monthly_sales, x = 'month_number', y = 'sum',  marker='o')
plt.title('Total Revenue per Month ')
plt.xlabel(' Month ')
plt.ylabel('Total Revenue')
plt.show()
```

    C:\Users\sambh\anaconda3\Lib\site-packages\seaborn\_oldcore.py:1119: FutureWarning: use_inf_as_na option is deprecated and will be removed in a future version. Convert inf values to NaN before operating instead.
      with pd.option_context('mode.use_inf_as_na', True):
    C:\Users\sambh\anaconda3\Lib\site-packages\seaborn\_oldcore.py:1119: FutureWarning: use_inf_as_na option is deprecated and will be removed in a future version. Convert inf values to NaN before operating instead.
      with pd.option_context('mode.use_inf_as_na', True):
    


    
![png](output_19_1.png)
    



```python
#2. Explore the popularity of different product categories across regions.
```


```python
 productcategory_per_region = df.groupby(['region', 'product_category'])['units_sold'].sum().unstack()
productcategory_per_region
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>product_category</th>
      <th>Beauty Products</th>
      <th>Books</th>
      <th>Clothing</th>
      <th>Electronics</th>
      <th>Home Appliances</th>
      <th>Sports</th>
    </tr>
    <tr>
      <th>region</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Asia</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>145.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>88.0</td>
    </tr>
    <tr>
      <th>Europe</th>
      <td>46.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>59.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>North America</th>
      <td>NaN</td>
      <td>114.0</td>
      <td>NaN</td>
      <td>66.0</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>




```python
productcategory_per_region.plot(kind='bar', stacked=True, figsize=(10, 6))

#sns.barplot(df, x= 'region', y = 'units_sold', hue='product_category', multiple = "stack", estimator='sum' , errorbar=None)
plt.title('Products Sold Per Region ')
plt.xlabel(' Region ')
plt.ylabel('Units Sold')
plt.show()
```


    
![png](output_22_0.png)
    



```python
#3. Investigate the impact of payment methods on sales volume or revenue.
```


```python
df.groupby('payment_method')['total_revenue'].agg(['mean', 'sum']).sort_values('mean', ascending = False)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>mean</th>
      <th>sum</th>
    </tr>
    <tr>
      <th>payment_method</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Credit Card</th>
      <td>426.423833</td>
      <td>51170.86</td>
    </tr>
    <tr>
      <th>PayPal</th>
      <td>265.850750</td>
      <td>21268.06</td>
    </tr>
    <tr>
      <th>Debit Card</th>
      <td>203.223250</td>
      <td>8128.93</td>
    </tr>
  </tbody>
</table>
</div>




```python


plt.figure(figsize= (10, 6))
sns.barplot(df , x ='payment_method', y = 'total_revenue', errorbar = None)
plt.title('Total Revenue per Payment Method ')
plt.xlabel(' Payment Method ')
plt.ylabel('Total Revenue')
plt.show()
```


    
![png](output_25_0.png)
    



```python
#4. Identify top-selling products within each category to optimize inventory and marketing strategies.
```


```python
products_sold_per_category = df.groupby(['product_category', 'product_name'])['units_sold'].agg(['sum']).reset_index().sort_values(['sum' ,'product_category'], ascending= False)
top3_selling_products = products_sold_per_category.groupby('product_category').head(3)
(top3_selling_products)

```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>product_category</th>
      <th>product_name</th>
      <th>sum</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>91</th>
      <td>Clothing</td>
      <td>Hanes ComfortSoft T-Shirt</td>
      <td>10</td>
    </tr>
    <tr>
      <th>52</th>
      <td>Books</td>
      <td>The Catcher in the Rye by J.D. Salinger</td>
      <td>7</td>
    </tr>
    <tr>
      <th>220</th>
      <td>Sports</td>
      <td>Spalding NBA Street Basketball</td>
      <td>6</td>
    </tr>
    <tr>
      <th>231</th>
      <td>Sports</td>
      <td>Yeti Rambler Tumbler</td>
      <td>6</td>
    </tr>
    <tr>
      <th>88</th>
      <td>Clothing</td>
      <td>Gap Essential Crewneck T-Shirt</td>
      <td>6</td>
    </tr>
    <tr>
      <th>98</th>
      <td>Clothing</td>
      <td>Nike Air Force 1</td>
      <td>6</td>
    </tr>
    <tr>
      <th>222</th>
      <td>Sports</td>
      <td>Titleist Pro V1 Golf Balls</td>
      <td>5</td>
    </tr>
    <tr>
      <th>56</th>
      <td>Books</td>
      <td>The Girl with the Dragon Tattoo by Stieg Larsson</td>
      <td>5</td>
    </tr>
    <tr>
      <th>70</th>
      <td>Books</td>
      <td>The Silent Patient by Alex Michaelides</td>
      <td>5</td>
    </tr>
    <tr>
      <th>116</th>
      <td>Electronics</td>
      <td>Amazon Echo Dot (4th Gen)</td>
      <td>4</td>
    </tr>
    <tr>
      <th>119</th>
      <td>Electronics</td>
      <td>Anker PowerCore Portable Charger</td>
      <td>4</td>
    </tr>
    <tr>
      <th>171</th>
      <td>Home Appliances</td>
      <td>Eufy RoboVac 11S</td>
      <td>3</td>
    </tr>
    <tr>
      <th>173</th>
      <td>Home Appliances</td>
      <td>Instant Pot Duo</td>
      <td>3</td>
    </tr>
    <tr>
      <th>178</th>
      <td>Home Appliances</td>
      <td>Keurig K-Elite Coffee Maker</td>
      <td>3</td>
    </tr>
    <tr>
      <th>118</th>
      <td>Electronics</td>
      <td>Amazon Fire TV Stick 4K</td>
      <td>3</td>
    </tr>
    <tr>
      <th>0</th>
      <td>Beauty Products</td>
      <td>Anastasia Beverly Hills Brow Wiz</td>
      <td>2</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Beauty Products</td>
      <td>CeraVe Hydrating Facial Cleanser</td>
      <td>2</td>
    </tr>
    <tr>
      <th>13</th>
      <td>Beauty Products</td>
      <td>First Aid Beauty Ultra Repair Cream</td>
      <td>2</td>
    </tr>
  </tbody>
</table>
</div>




```python
plt.figure(figsize = (10, 6))
sns.catplot(data=top3_selling_products , x='sum', y='product_name', hue='product_category', kind='bar', height=7.5, aspect=2.0)
plt.title('Total Selling Product per Category')
plt.xlabel('Product Name')
plt.ylabel('Units Sold ')
plt.show()
```


    <Figure size 1000x600 with 0 Axes>



    
![png](output_28_1.png)
    



```python
#5. Evaluate the performance of specific products or categories in different regions to tailor marketing campaigns accordingly.
```


```python
performing_category_per_region =  df.groupby(['region', 'product_category']) ['total_revenue'].sum().reset_index()
performing_category_per_region.sort_values('total_revenue', ascending = False)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>region</th>
      <th>product_category</th>
      <th>total_revenue</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>5</th>
      <td>North America</td>
      <td>Electronics</td>
      <td>34982.41</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Europe</td>
      <td>Home Appliances</td>
      <td>18646.16</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Asia</td>
      <td>Sports</td>
      <td>14326.52</td>
    </tr>
    <tr>
      <th>0</th>
      <td>Asia</td>
      <td>Clothing</td>
      <td>8128.93</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Europe</td>
      <td>Beauty Products</td>
      <td>2621.90</td>
    </tr>
    <tr>
      <th>4</th>
      <td>North America</td>
      <td>Books</td>
      <td>1861.93</td>
    </tr>
  </tbody>
</table>
</div>




```python
plt.figure(figsize = (10, 6))
sns.barplot(data = performing_category_per_region, x = 'region', y ='total_revenue', hue='product_category' )
plt.title('Performance of Product Categories per  Different Regions')
plt.xlabel('Region')
plt.ylabel('Total Revenue')
plt.show()
```


    
![png](output_31_0.png)
    



```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```
