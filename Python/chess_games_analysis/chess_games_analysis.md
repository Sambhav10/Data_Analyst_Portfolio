```python
# Chess Games Analysis 

#DataSet - https://www.kaggle.com/datasets/ulrikthygepedersen/online-chess-games/data
```



```python
# Task 

# 1. Data Cleaning

#2. Data Analysis 
#- Chess Rating Distribution
#- What are the favorable outcomes for chess different levels of chess players ?
#- Which openings different level of chess players ususally prefer ? 
#- Which openings gives the best outcomes(win, or maybe draw) for white or black ? 
#- Average amount of turns in different openings .
#- What was the victory status(out of time , resign , mate, draw) when using different opening and players of different levels ?
```


```python
import pandas as pd 
import seaborn as sns
import matplotlib.pyplot as plt
```


```python
# importing data set 
df = pd.read_csv("chess_games.csv")
```


```python
df.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 20058 entries, 0 to 20057
    Data columns (total 17 columns):
     #   Column             Non-Null Count  Dtype 
    ---  ------             --------------  ----- 
     0   game_id            20058 non-null  int64 
     1   rated              20058 non-null  bool  
     2   turns              20058 non-null  int64 
     3   victory_status     20058 non-null  object
     4   winner             20058 non-null  object
     5   time_increment     20058 non-null  object
     6   white_id           20058 non-null  object
     7   white_rating       20058 non-null  int64 
     8   black_id           20058 non-null  object
     9   black_rating       20058 non-null  int64 
     10  moves              20058 non-null  object
     11  opening_code       20058 non-null  object
     12  opening_moves      20058 non-null  int64 
     13  opening_fullname   20058 non-null  object
     14  opening_shortname  20058 non-null  object
     15  opening_response   1207 non-null   object
     16  opening_variation  14398 non-null  object
    dtypes: bool(1), int64(5), object(11)
    memory usage: 2.5+ MB
    


```python
df.shape
```




    (20058, 17)




```python
df.describe()
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
      <th>game_id</th>
      <th>turns</th>
      <th>white_rating</th>
      <th>black_rating</th>
      <th>opening_moves</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>20058.000000</td>
      <td>20058.000000</td>
      <td>20058.000000</td>
      <td>20058.000000</td>
      <td>20058.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>10029.500000</td>
      <td>60.465999</td>
      <td>1596.631868</td>
      <td>1588.831987</td>
      <td>4.816981</td>
    </tr>
    <tr>
      <th>std</th>
      <td>5790.390185</td>
      <td>33.570585</td>
      <td>291.253376</td>
      <td>291.036126</td>
      <td>2.797152</td>
    </tr>
    <tr>
      <th>min</th>
      <td>1.000000</td>
      <td>1.000000</td>
      <td>784.000000</td>
      <td>789.000000</td>
      <td>1.000000</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>5015.250000</td>
      <td>37.000000</td>
      <td>1398.000000</td>
      <td>1391.000000</td>
      <td>3.000000</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>10029.500000</td>
      <td>55.000000</td>
      <td>1567.000000</td>
      <td>1562.000000</td>
      <td>4.000000</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>15043.750000</td>
      <td>79.000000</td>
      <td>1793.000000</td>
      <td>1784.000000</td>
      <td>6.000000</td>
    </tr>
    <tr>
      <th>max</th>
      <td>20058.000000</td>
      <td>349.000000</td>
      <td>2700.000000</td>
      <td>2723.000000</td>
      <td>28.000000</td>
    </tr>
  </tbody>
</table>
</div>




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
      <th>game_id</th>
      <th>rated</th>
      <th>turns</th>
      <th>victory_status</th>
      <th>winner</th>
      <th>time_increment</th>
      <th>white_id</th>
      <th>white_rating</th>
      <th>black_id</th>
      <th>black_rating</th>
      <th>moves</th>
      <th>opening_code</th>
      <th>opening_moves</th>
      <th>opening_fullname</th>
      <th>opening_shortname</th>
      <th>opening_response</th>
      <th>opening_variation</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>False</td>
      <td>13</td>
      <td>Out of Time</td>
      <td>White</td>
      <td>15+2</td>
      <td>bourgris</td>
      <td>1500</td>
      <td>a-00</td>
      <td>1191</td>
      <td>d4 d5 c4 c6 cxd5 e6 dxe6 fxe6 Nf3 Bb4+ Nc3 Ba5...</td>
      <td>D10</td>
      <td>5</td>
      <td>Slav Defense: Exchange Variation</td>
      <td>Slav Defense</td>
      <td>NaN</td>
      <td>Exchange Variation</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>True</td>
      <td>16</td>
      <td>Resign</td>
      <td>Black</td>
      <td>5+10</td>
      <td>a-00</td>
      <td>1322</td>
      <td>skinnerua</td>
      <td>1261</td>
      <td>d4 Nc6 e4 e5 f4 f6 dxe5 fxe5 fxe5 Nxe5 Qd4 Nc6...</td>
      <td>B00</td>
      <td>4</td>
      <td>Nimzowitsch Defense: Kennedy Variation</td>
      <td>Nimzowitsch Defense</td>
      <td>NaN</td>
      <td>Kennedy Variation</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>True</td>
      <td>61</td>
      <td>Mate</td>
      <td>White</td>
      <td>5+10</td>
      <td>ischia</td>
      <td>1496</td>
      <td>a-00</td>
      <td>1500</td>
      <td>e4 e5 d3 d6 Be3 c6 Be2 b5 Nd2 a5 a4 c5 axb5 Nc...</td>
      <td>C20</td>
      <td>3</td>
      <td>King's Pawn Game: Leonardis Variation</td>
      <td>King's Pawn Game</td>
      <td>NaN</td>
      <td>Leonardis Variation</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>True</td>
      <td>61</td>
      <td>Mate</td>
      <td>White</td>
      <td>20+0</td>
      <td>daniamurashov</td>
      <td>1439</td>
      <td>adivanov2009</td>
      <td>1454</td>
      <td>d4 d5 Nf3 Bf5 Nc3 Nf6 Bf4 Ng4 e3 Nc6 Be2 Qd7 O...</td>
      <td>D02</td>
      <td>3</td>
      <td>Queen's Pawn Game: Zukertort Variation</td>
      <td>Queen's Pawn Game</td>
      <td>NaN</td>
      <td>Zukertort Variation</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>True</td>
      <td>95</td>
      <td>Mate</td>
      <td>White</td>
      <td>30+3</td>
      <td>nik221107</td>
      <td>1523</td>
      <td>adivanov2009</td>
      <td>1469</td>
      <td>e4 e5 Nf3 d6 d4 Nc6 d5 Nb4 a3 Na6 Nc3 Be7 b4 N...</td>
      <td>C41</td>
      <td>5</td>
      <td>Philidor Defense</td>
      <td>Philidor Defense</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>5</th>
      <td>6</td>
      <td>False</td>
      <td>5</td>
      <td>Draw</td>
      <td>Draw</td>
      <td>10+0</td>
      <td>trelynn17</td>
      <td>1250</td>
      <td>franklin14532</td>
      <td>1002</td>
      <td>e4 c5 Nf3 Qa5 a3</td>
      <td>B27</td>
      <td>4</td>
      <td>Sicilian Defense: Mongoose Variation</td>
      <td>Sicilian Defense</td>
      <td>NaN</td>
      <td>Mongoose Variation</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>True</td>
      <td>33</td>
      <td>Resign</td>
      <td>White</td>
      <td>10+0</td>
      <td>capa_jr</td>
      <td>1520</td>
      <td>daniel_likes_chess</td>
      <td>1423</td>
      <td>d4 d5 e4 dxe4 Nc3 Nf6 f3 exf3 Nxf3 Nc6 Bb5 a6 ...</td>
      <td>D00</td>
      <td>10</td>
      <td>Blackmar-Diemer Gambit: Pietrowsky Defense</td>
      <td>Blackmar-Diemer Gambit</td>
      <td>NaN</td>
      <td>Pietrowsky Defense</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>False</td>
      <td>9</td>
      <td>Resign</td>
      <td>Black</td>
      <td>15+30</td>
      <td>daniel_likes_chess</td>
      <td>1413</td>
      <td>soultego</td>
      <td>2108</td>
      <td>e4 Nc6 d4 e5 d5 Nce7 c3 Ng6 b4</td>
      <td>B00</td>
      <td>5</td>
      <td>Nimzowitsch Defense: Kennedy Variation |  Link...</td>
      <td>Nimzowitsch Defense</td>
      <td>NaN</td>
      <td>Kennedy Variation</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>True</td>
      <td>66</td>
      <td>Resign</td>
      <td>Black</td>
      <td>15+0</td>
      <td>ehabfanri</td>
      <td>1439</td>
      <td>daniel_likes_chess</td>
      <td>1392</td>
      <td>e4 e5 Bc4 Nc6 Nf3 Nd4 d3 Nxf3+ Qxf3 Nf6 h3 Bc5...</td>
      <td>C50</td>
      <td>6</td>
      <td>Italian Game: Schilling-Kostic Gambit</td>
      <td>Italian Game</td>
      <td>NaN</td>
      <td>Schilling-Kostic Gambit</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10</td>
      <td>True</td>
      <td>119</td>
      <td>Mate</td>
      <td>White</td>
      <td>10+0</td>
      <td>daniel_likes_chess</td>
      <td>1381</td>
      <td>mirco25</td>
      <td>1209</td>
      <td>e4 d5 exd5 Qxd5 Nc3 Qe5+ Be2 Na6 d4 Qf5 Bxa6 b...</td>
      <td>B01</td>
      <td>4</td>
      <td>Scandinavian Defense: Mieses-Kotroc Variation</td>
      <td>Scandinavian Defense</td>
      <td>NaN</td>
      <td>Mieses-Kotroc Variation</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Data Cleaning 
```


```python
#creating a copy of original dataset first 
df2 = df.copy()
df2
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
      <th>game_id</th>
      <th>rated</th>
      <th>turns</th>
      <th>victory_status</th>
      <th>winner</th>
      <th>time_increment</th>
      <th>white_id</th>
      <th>white_rating</th>
      <th>black_id</th>
      <th>black_rating</th>
      <th>moves</th>
      <th>opening_code</th>
      <th>opening_moves</th>
      <th>opening_fullname</th>
      <th>opening_shortname</th>
      <th>opening_response</th>
      <th>opening_variation</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>False</td>
      <td>13</td>
      <td>Out of Time</td>
      <td>White</td>
      <td>15+2</td>
      <td>bourgris</td>
      <td>1500</td>
      <td>a-00</td>
      <td>1191</td>
      <td>d4 d5 c4 c6 cxd5 e6 dxe6 fxe6 Nf3 Bb4+ Nc3 Ba5...</td>
      <td>D10</td>
      <td>5</td>
      <td>Slav Defense: Exchange Variation</td>
      <td>Slav Defense</td>
      <td>NaN</td>
      <td>Exchange Variation</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>True</td>
      <td>16</td>
      <td>Resign</td>
      <td>Black</td>
      <td>5+10</td>
      <td>a-00</td>
      <td>1322</td>
      <td>skinnerua</td>
      <td>1261</td>
      <td>d4 Nc6 e4 e5 f4 f6 dxe5 fxe5 fxe5 Nxe5 Qd4 Nc6...</td>
      <td>B00</td>
      <td>4</td>
      <td>Nimzowitsch Defense: Kennedy Variation</td>
      <td>Nimzowitsch Defense</td>
      <td>NaN</td>
      <td>Kennedy Variation</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>True</td>
      <td>61</td>
      <td>Mate</td>
      <td>White</td>
      <td>5+10</td>
      <td>ischia</td>
      <td>1496</td>
      <td>a-00</td>
      <td>1500</td>
      <td>e4 e5 d3 d6 Be3 c6 Be2 b5 Nd2 a5 a4 c5 axb5 Nc...</td>
      <td>C20</td>
      <td>3</td>
      <td>King's Pawn Game: Leonardis Variation</td>
      <td>King's Pawn Game</td>
      <td>NaN</td>
      <td>Leonardis Variation</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>True</td>
      <td>61</td>
      <td>Mate</td>
      <td>White</td>
      <td>20+0</td>
      <td>daniamurashov</td>
      <td>1439</td>
      <td>adivanov2009</td>
      <td>1454</td>
      <td>d4 d5 Nf3 Bf5 Nc3 Nf6 Bf4 Ng4 e3 Nc6 Be2 Qd7 O...</td>
      <td>D02</td>
      <td>3</td>
      <td>Queen's Pawn Game: Zukertort Variation</td>
      <td>Queen's Pawn Game</td>
      <td>NaN</td>
      <td>Zukertort Variation</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>True</td>
      <td>95</td>
      <td>Mate</td>
      <td>White</td>
      <td>30+3</td>
      <td>nik221107</td>
      <td>1523</td>
      <td>adivanov2009</td>
      <td>1469</td>
      <td>e4 e5 Nf3 d6 d4 Nc6 d5 Nb4 a3 Na6 Nc3 Be7 b4 N...</td>
      <td>C41</td>
      <td>5</td>
      <td>Philidor Defense</td>
      <td>Philidor Defense</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>20053</th>
      <td>20054</td>
      <td>True</td>
      <td>24</td>
      <td>Resign</td>
      <td>White</td>
      <td>10+10</td>
      <td>belcolt</td>
      <td>1691</td>
      <td>jamboger</td>
      <td>1220</td>
      <td>d4 f5 e3 e6 Nf3 Nf6 Nc3 b6 Be2 Bb7 O-O Be7 Ne5...</td>
      <td>A80</td>
      <td>2</td>
      <td>Dutch Defense</td>
      <td>Dutch Defense</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>20054</th>
      <td>20055</td>
      <td>True</td>
      <td>82</td>
      <td>Mate</td>
      <td>Black</td>
      <td>10+0</td>
      <td>jamboger</td>
      <td>1233</td>
      <td>farrukhasomiddinov</td>
      <td>1196</td>
      <td>d4 d6 Bf4 e5 Bg3 Nf6 e3 exd4 exd4 d5 c3 Bd6 Bd...</td>
      <td>A41</td>
      <td>2</td>
      <td>Queen's Pawn</td>
      <td>Queen's Pawn</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>20055</th>
      <td>20056</td>
      <td>True</td>
      <td>35</td>
      <td>Mate</td>
      <td>White</td>
      <td>10+0</td>
      <td>jamboger</td>
      <td>1219</td>
      <td>schaaksmurf3</td>
      <td>1286</td>
      <td>d4 d5 Bf4 Nc6 e3 Nf6 c3 e6 Nf3 Be7 Bd3 O-O Nbd...</td>
      <td>D00</td>
      <td>3</td>
      <td>Queen's Pawn Game: Mason Attack</td>
      <td>Queen's Pawn Game</td>
      <td>NaN</td>
      <td>Mason Attack</td>
    </tr>
    <tr>
      <th>20056</th>
      <td>20057</td>
      <td>True</td>
      <td>109</td>
      <td>Resign</td>
      <td>White</td>
      <td>10+0</td>
      <td>marcodisogno</td>
      <td>1360</td>
      <td>jamboger</td>
      <td>1227</td>
      <td>e4 d6 d4 Nf6 e5 dxe5 dxe5 Qxd1+ Kxd1 Nd5 c4 Nb...</td>
      <td>B07</td>
      <td>4</td>
      <td>Pirc Defense</td>
      <td>Pirc Defense</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>20057</th>
      <td>20058</td>
      <td>True</td>
      <td>78</td>
      <td>Mate</td>
      <td>Black</td>
      <td>10+0</td>
      <td>jamboger</td>
      <td>1235</td>
      <td>ffbob</td>
      <td>1339</td>
      <td>d4 d5 Bf4 Na6 e3 e6 c3 Nf6 Nf3 Bd7 Nbd2 b5 Bd3...</td>
      <td>D00</td>
      <td>3</td>
      <td>Queen's Pawn Game: Mason Attack</td>
      <td>Queen's Pawn Game</td>
      <td>NaN</td>
      <td>Mason Attack</td>
    </tr>
  </tbody>
</table>
<p>20058 rows × 17 columns</p>
</div>




```python
# removing the columns that are not relevant 
#1. white_id , black_id , moves, , opening_fullnames, opening_responses, opening_variations  
df2 =df2.drop(['white_id', 'black_id', 'moves', 'opening_fullname', 'opening_response', 'opening_variation'], axis =1 )
```


```python
#2. checing for any null values 
df2.isna().sum()
```




    game_id           0
    rated             0
    turns             0
    victory_status    0
    winner            0
    time_increment    0
    white_rating      0
    black_rating      0
    opening_code      0
    opening_moves     0
    opening_name      0
    dtype: int64




```python
df2
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
      <th>game_id</th>
      <th>rated</th>
      <th>turns</th>
      <th>victory_status</th>
      <th>winner</th>
      <th>time_increment</th>
      <th>white_rating</th>
      <th>black_rating</th>
      <th>opening_code</th>
      <th>opening_moves</th>
      <th>opening_shortname</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>False</td>
      <td>13</td>
      <td>Out of Time</td>
      <td>White</td>
      <td>15+2</td>
      <td>1500</td>
      <td>1191</td>
      <td>D10</td>
      <td>5</td>
      <td>Slav Defense</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>True</td>
      <td>16</td>
      <td>Resign</td>
      <td>Black</td>
      <td>5+10</td>
      <td>1322</td>
      <td>1261</td>
      <td>B00</td>
      <td>4</td>
      <td>Nimzowitsch Defense</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>True</td>
      <td>61</td>
      <td>Mate</td>
      <td>White</td>
      <td>5+10</td>
      <td>1496</td>
      <td>1500</td>
      <td>C20</td>
      <td>3</td>
      <td>King's Pawn Game</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>True</td>
      <td>61</td>
      <td>Mate</td>
      <td>White</td>
      <td>20+0</td>
      <td>1439</td>
      <td>1454</td>
      <td>D02</td>
      <td>3</td>
      <td>Queen's Pawn Game</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>True</td>
      <td>95</td>
      <td>Mate</td>
      <td>White</td>
      <td>30+3</td>
      <td>1523</td>
      <td>1469</td>
      <td>C41</td>
      <td>5</td>
      <td>Philidor Defense</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>20053</th>
      <td>20054</td>
      <td>True</td>
      <td>24</td>
      <td>Resign</td>
      <td>White</td>
      <td>10+10</td>
      <td>1691</td>
      <td>1220</td>
      <td>A80</td>
      <td>2</td>
      <td>Dutch Defense</td>
    </tr>
    <tr>
      <th>20054</th>
      <td>20055</td>
      <td>True</td>
      <td>82</td>
      <td>Mate</td>
      <td>Black</td>
      <td>10+0</td>
      <td>1233</td>
      <td>1196</td>
      <td>A41</td>
      <td>2</td>
      <td>Queen's Pawn</td>
    </tr>
    <tr>
      <th>20055</th>
      <td>20056</td>
      <td>True</td>
      <td>35</td>
      <td>Mate</td>
      <td>White</td>
      <td>10+0</td>
      <td>1219</td>
      <td>1286</td>
      <td>D00</td>
      <td>3</td>
      <td>Queen's Pawn Game</td>
    </tr>
    <tr>
      <th>20056</th>
      <td>20057</td>
      <td>True</td>
      <td>109</td>
      <td>Resign</td>
      <td>White</td>
      <td>10+0</td>
      <td>1360</td>
      <td>1227</td>
      <td>B07</td>
      <td>4</td>
      <td>Pirc Defense</td>
    </tr>
    <tr>
      <th>20057</th>
      <td>20058</td>
      <td>True</td>
      <td>78</td>
      <td>Mate</td>
      <td>Black</td>
      <td>10+0</td>
      <td>1235</td>
      <td>1339</td>
      <td>D00</td>
      <td>3</td>
      <td>Queen's Pawn Game</td>
    </tr>
  </tbody>
</table>
<p>20058 rows × 11 columns</p>
</div>




```python
#3. renaming column names 
df2 = df2.rename(columns = {
    'opening_shortname' : 'opening_name'
})
```


```python
df2
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
      <th>game_id</th>
      <th>rated</th>
      <th>turns</th>
      <th>victory_status</th>
      <th>winner</th>
      <th>time_increment</th>
      <th>white_rating</th>
      <th>black_rating</th>
      <th>opening_code</th>
      <th>opening_moves</th>
      <th>opening_name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>False</td>
      <td>13</td>
      <td>Out of Time</td>
      <td>White</td>
      <td>15+2</td>
      <td>1500</td>
      <td>1191</td>
      <td>D10</td>
      <td>5</td>
      <td>Slav Defense</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>True</td>
      <td>16</td>
      <td>Resign</td>
      <td>Black</td>
      <td>5+10</td>
      <td>1322</td>
      <td>1261</td>
      <td>B00</td>
      <td>4</td>
      <td>Nimzowitsch Defense</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>True</td>
      <td>61</td>
      <td>Mate</td>
      <td>White</td>
      <td>5+10</td>
      <td>1496</td>
      <td>1500</td>
      <td>C20</td>
      <td>3</td>
      <td>King's Pawn Game</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>True</td>
      <td>61</td>
      <td>Mate</td>
      <td>White</td>
      <td>20+0</td>
      <td>1439</td>
      <td>1454</td>
      <td>D02</td>
      <td>3</td>
      <td>Queen's Pawn Game</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>True</td>
      <td>95</td>
      <td>Mate</td>
      <td>White</td>
      <td>30+3</td>
      <td>1523</td>
      <td>1469</td>
      <td>C41</td>
      <td>5</td>
      <td>Philidor Defense</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>20053</th>
      <td>20054</td>
      <td>True</td>
      <td>24</td>
      <td>Resign</td>
      <td>White</td>
      <td>10+10</td>
      <td>1691</td>
      <td>1220</td>
      <td>A80</td>
      <td>2</td>
      <td>Dutch Defense</td>
    </tr>
    <tr>
      <th>20054</th>
      <td>20055</td>
      <td>True</td>
      <td>82</td>
      <td>Mate</td>
      <td>Black</td>
      <td>10+0</td>
      <td>1233</td>
      <td>1196</td>
      <td>A41</td>
      <td>2</td>
      <td>Queen's Pawn</td>
    </tr>
    <tr>
      <th>20055</th>
      <td>20056</td>
      <td>True</td>
      <td>35</td>
      <td>Mate</td>
      <td>White</td>
      <td>10+0</td>
      <td>1219</td>
      <td>1286</td>
      <td>D00</td>
      <td>3</td>
      <td>Queen's Pawn Game</td>
    </tr>
    <tr>
      <th>20056</th>
      <td>20057</td>
      <td>True</td>
      <td>109</td>
      <td>Resign</td>
      <td>White</td>
      <td>10+0</td>
      <td>1360</td>
      <td>1227</td>
      <td>B07</td>
      <td>4</td>
      <td>Pirc Defense</td>
    </tr>
    <tr>
      <th>20057</th>
      <td>20058</td>
      <td>True</td>
      <td>78</td>
      <td>Mate</td>
      <td>Black</td>
      <td>10+0</td>
      <td>1235</td>
      <td>1339</td>
      <td>D00</td>
      <td>3</td>
      <td>Queen's Pawn Game</td>
    </tr>
  </tbody>
</table>
<p>20058 rows × 11 columns</p>
</div>




```python
#4. checking if there is any duplicate data  
df2[df2.duplicated() == True]
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
      <th>game_id</th>
      <th>rated</th>
      <th>turns</th>
      <th>victory_status</th>
      <th>winner</th>
      <th>time_increment</th>
      <th>white_rating</th>
      <th>black_rating</th>
      <th>opening_code</th>
      <th>opening_moves</th>
      <th>opening_name</th>
    </tr>
  </thead>
  <tbody>
  </tbody>
</table>
</div>




```python
#copying the clean dataframe into a new dataframe for analysis 
df3 = df2.copy()
```


```python
# cleaning up the opening names

names =df3['opening_name'].unique()
print(names)
```

    ['Slav Defense' 'Nimzowitsch Defense' "King's Pawn Game"
     "Queen's Pawn Game" 'Philidor Defense' 'Sicilian Defense'
     'Blackmar-Diemer Gambit' 'Italian Game' 'Scandinavian Defense'
     "Van't Kruijs Opening" 'French Defense' 'Four Knights Game'
     'Horwitz Defense' 'English Opening' 'Scotch Game' "Queen's Gambit"
     'Robatsch (Modern) Defense' 'Indian Game' 'Dutch Defense'
     'Zukertort Opening' 'Vienna Game' 'Modern Defense'
     'Blumenfeld Countergambit' "Queen's Pawn" 'Crab Opening'
     "Queen's Indian Defense" 'Gruenfeld Defense' 'Yusupov-Rubinstein System'
     'Ruy Lopez' "Bishop's Opening" 'Benoni Defense' "King's Indian Attack"
     'Alekhine Defense' 'Caro-Kann Defense' 'Goldsmith Defense'
     'Nimzo-Indian Defense' 'Bogo-Indian Defense' "King's Knight Opening"
     'Amar Opening' 'Paleface Attack' 'Hungarian Opening' 'Center Game'
     'Englund Gambit' 'Giuoco Piano' "Petrov's Defense" 'Russian Game'
     'Pirc Defense' 'St. George Defense' 'Bird Opening' 'Owen Defense'
     'Semi-Slav Defense' 'English Defense' "King's Gambit"
     "King's Pawn Opening" 'Polish Opening' 'Ponziani Opening'
     'East Indian Defense' 'Reti Opening' 'Nimzo-Larsen Attack' 'Torre Attack'
     'Creepy Crawly Formation' 'Elephant Gambit' 'Latvian Gambit'
     'Global Opening' 'Trompowsky Attack' 'London System' 'Danish Gambit'
     'Mieses Opening' 'Carr Defense' "King's Indian Defense"
     'Three Knights Opening' 'Ware Opening' 'Budapest Defense'
     'Richter-Veresov Attack' 'Franco-Benoni Defense' 'Van Geet Opening'
     'Polish Defense' 'Old Benoni Defense' 'Kadas Opening' 'System'
     'Rat Defense' 'Englund Gambit Complex' "Gedult's Opening" 'Colle System'
     'Nimzowitsch-Larsen Attack' 'Neo-Gruenfeld Defense' 'Grob Opening'
     'Mikenas Defense' 'Tarrasch Defense' 'Old Indian Defense'
     'Anderssen Opening' 'Portuguese Opening' 'Old Indian' "King's Pawn"
     'Irish Gambit' "Queen's Pawn Opening" 'Clemenz Opening' 'Mexican Defense'
     'Barnes Defense' 'Saragossa Opening' 'Duras Gambit' 'Gunderam Defense'
     'Hippopotamus Defense' 'Catalan Opening' 'Lion Defense'
     'Guatemala Defense' 'Borg Defense' 'Sodium Attack' 'Doery Defense'
     'Benko Gambit' 'Amazon Attack' 'Wade Defense' 'Kangaroo Defense'
     'Semi-Bononi' 'Slav Indian' 'Petrov' 'Lemming Defense'
     "Queen's Indian Accelerated" 'Australian Defense' 'Ware Defense'
     'Valencia Opening' 'Scotch Gambit' 'Czech Defense' "King's Indian"
     'Barnes Opening' 'Canard Opening' 'Pterodactyl Defense'
     'Rubinstein Opening']
    


```python
#some of these opening names can be replaced with their generic names 
# ex  Oueen's pawn game can be replaced by Queen's pawn 
```


```python

df3['opening_name'].replace("Queen's Pawn Game" , "Queen's Pawn", inplace = True)
df3['opening_name'].replace("Queen's Pawn Opening" , "Queen's Pawn", inplace = True)
df3['opening_name'].replace("King's Pawn Game" , "Queen's Pawn", inplace = True)
df3['opening_name'].replace("King's Pawn Opening" , "Queen's Pawn", inplace = True)
df3['opening_name'].replace("Old Indian Defence" , "Old Indian", inplace = True)
df3['opening_name'].replace("Ware Defense" , "Ware Opening", inplace = True)
```


```python
df3
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
      <th>game_id</th>
      <th>rated</th>
      <th>turns</th>
      <th>victory_status</th>
      <th>winner</th>
      <th>time_increment</th>
      <th>white_rating</th>
      <th>black_rating</th>
      <th>opening_code</th>
      <th>opening_moves</th>
      <th>opening_name</th>
      <th>average_rating</th>
      <th>rating_brackets</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>False</td>
      <td>13</td>
      <td>Out of Time</td>
      <td>White</td>
      <td>15+2</td>
      <td>1500</td>
      <td>1191</td>
      <td>D10</td>
      <td>5</td>
      <td>Slav Defense</td>
      <td>1345.5</td>
      <td>1200-1399</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>True</td>
      <td>16</td>
      <td>Resign</td>
      <td>Black</td>
      <td>5+10</td>
      <td>1322</td>
      <td>1261</td>
      <td>B00</td>
      <td>4</td>
      <td>Nimzowitsch Defense</td>
      <td>1291.5</td>
      <td>1200-1399</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>True</td>
      <td>61</td>
      <td>Mate</td>
      <td>White</td>
      <td>5+10</td>
      <td>1496</td>
      <td>1500</td>
      <td>C20</td>
      <td>3</td>
      <td>Queen's Pawn</td>
      <td>1498.0</td>
      <td>1400-1599</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>True</td>
      <td>61</td>
      <td>Mate</td>
      <td>White</td>
      <td>20+0</td>
      <td>1439</td>
      <td>1454</td>
      <td>D02</td>
      <td>3</td>
      <td>Queen's Pawn</td>
      <td>1446.5</td>
      <td>1400-1599</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>True</td>
      <td>95</td>
      <td>Mate</td>
      <td>White</td>
      <td>30+3</td>
      <td>1523</td>
      <td>1469</td>
      <td>C41</td>
      <td>5</td>
      <td>Philidor Defense</td>
      <td>1496.0</td>
      <td>1400-1599</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>20053</th>
      <td>20054</td>
      <td>True</td>
      <td>24</td>
      <td>Resign</td>
      <td>White</td>
      <td>10+10</td>
      <td>1691</td>
      <td>1220</td>
      <td>A80</td>
      <td>2</td>
      <td>Dutch Defense</td>
      <td>1455.5</td>
      <td>1400-1599</td>
    </tr>
    <tr>
      <th>20054</th>
      <td>20055</td>
      <td>True</td>
      <td>82</td>
      <td>Mate</td>
      <td>Black</td>
      <td>10+0</td>
      <td>1233</td>
      <td>1196</td>
      <td>A41</td>
      <td>2</td>
      <td>Queen's Pawn</td>
      <td>1214.5</td>
      <td>1200-1399</td>
    </tr>
    <tr>
      <th>20055</th>
      <td>20056</td>
      <td>True</td>
      <td>35</td>
      <td>Mate</td>
      <td>White</td>
      <td>10+0</td>
      <td>1219</td>
      <td>1286</td>
      <td>D00</td>
      <td>3</td>
      <td>Queen's Pawn</td>
      <td>1252.5</td>
      <td>1200-1399</td>
    </tr>
    <tr>
      <th>20056</th>
      <td>20057</td>
      <td>True</td>
      <td>109</td>
      <td>Resign</td>
      <td>White</td>
      <td>10+0</td>
      <td>1360</td>
      <td>1227</td>
      <td>B07</td>
      <td>4</td>
      <td>Pirc Defense</td>
      <td>1293.5</td>
      <td>1200-1399</td>
    </tr>
    <tr>
      <th>20057</th>
      <td>20058</td>
      <td>True</td>
      <td>78</td>
      <td>Mate</td>
      <td>Black</td>
      <td>10+0</td>
      <td>1235</td>
      <td>1339</td>
      <td>D00</td>
      <td>3</td>
      <td>Queen's Pawn</td>
      <td>1287.0</td>
      <td>1200-1399</td>
    </tr>
  </tbody>
</table>
<p>20058 rows × 13 columns</p>
</div>




```python
# calculating an average rating for creating the rating brackets 
df3['average_rating'] = (df3['white_rating'] + df3['black_rating']) /2
```


```python
df3[['white_rating', 'black_rating','average_rating']]
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
      <th>white_rating</th>
      <th>black_rating</th>
      <th>average_rating</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1500</td>
      <td>1191</td>
      <td>1345.5</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1322</td>
      <td>1261</td>
      <td>1291.5</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1496</td>
      <td>1500</td>
      <td>1498.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1439</td>
      <td>1454</td>
      <td>1446.5</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1523</td>
      <td>1469</td>
      <td>1496.0</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>20053</th>
      <td>1691</td>
      <td>1220</td>
      <td>1455.5</td>
    </tr>
    <tr>
      <th>20054</th>
      <td>1233</td>
      <td>1196</td>
      <td>1214.5</td>
    </tr>
    <tr>
      <th>20055</th>
      <td>1219</td>
      <td>1286</td>
      <td>1252.5</td>
    </tr>
    <tr>
      <th>20056</th>
      <td>1360</td>
      <td>1227</td>
      <td>1293.5</td>
    </tr>
    <tr>
      <th>20057</th>
      <td>1235</td>
      <td>1339</td>
      <td>1287.0</td>
    </tr>
  </tbody>
</table>
<p>20058 rows × 3 columns</p>
</div>




```python
#finding out the max and min rating for rating brackets 
print(df3['average_rating'].max())
print(df3['average_rating'].min())
```

    2475.5
    816.5
    


```python
# to create a ratings brackets I am gonna use the wikipedia's article as a guide 
# https://en.wikipedia.org/wiki/Chess_rating_system
# the chess rating brackets are 
 # 1000 -         (Novices)
 # 1000-1199      (Class E)
 # 1200-1399      (Class D)
 # 1400-1599      (Class C)
 # 1600-1799      (Class B)
 # 1800-1999      (Class A)
 # 2000-2199      (Experts)
 # 2200+          (Masters)
```


```python
df3['rating_brackets'] = pd.cut(df3['average_rating'] , bins=[800, 1000, 1200,1400,1600,1800,2000, 2200, 2500], labels= ['1000-', '1000-1199', 
'1200-1399', '1400-1599', '1600-1799', '1800-1999' , '2000-2199', '2200+'])
```


```python
df3['rating_brackets'].value_counts()
```




    rating_brackets
    1400-1599    6081
    1600-1799    4666
    1200-1399    3682
    1800-1999    2963
    2000-2199    1223
    1000-1199    1080
    2200+         270
    1000-          93
    Name: count, dtype: int64




```python
### ANALYSIS #####
```


```python
# Chess Rating Distribution
rating_distribution = df3.groupby('rating_brackets')['rating_brackets'].agg(['count']).reset_index()
rating_distribution
```

    C:\Users\sambh\AppData\Local\Temp\ipykernel_15744\1253036628.py:2: FutureWarning: The default of observed=False is deprecated and will be changed to True in a future version of pandas. Pass observed=False to retain current behavior or observed=True to adopt the future default and silence this warning.
      rating_distribution = df3.groupby('rating_brackets')['rating_brackets'].agg(['count']).reset_index()
    




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
      <th>rating_brackets</th>
      <th>count</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1000-</td>
      <td>93</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1000-1199</td>
      <td>1080</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1200-1399</td>
      <td>3682</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1400-1599</td>
      <td>6081</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1600-1799</td>
      <td>4666</td>
    </tr>
    <tr>
      <th>5</th>
      <td>1800-1999</td>
      <td>2963</td>
    </tr>
    <tr>
      <th>6</th>
      <td>2000-2199</td>
      <td>1223</td>
    </tr>
    <tr>
      <th>7</th>
      <td>2200+</td>
      <td>270</td>
    </tr>
  </tbody>
</table>
</div>




```python
fig, ax = plt.subplots(figsize=(20, 8))
sns.barplot(data =rating_distribution , x = 'rating_brackets', y = 'count' ,ax = ax, palette= sns.color_palette("Spectral"))
ax.bar_label(ax.containers[0], label_type='edge')
ax.margins(y=0.1)
plt.title('Rating Distribution\n', fontsize =16)
plt.xlabel('\nRating brackets', fontsize =12)
plt.ylabel('Count\n', fontsize =12)

plt.show()
```


![image](https://github.com/Sambhav10/Data_Analyst_Portfolio/assets/85670420/86cab85c-83f2-4e7a-b327-ec7bc2323120)

    



```python
#2. - What are the favorable outcomes for chess different levels of chess players ?
```


```python
outcomes_per_rating_bracket = df3.groupby(['rating_brackets', 'winner'])['winner'].agg(['count']).reset_index()
outcomes_per_rating_bracket

```

    C:\Users\sambh\AppData\Local\Temp\ipykernel_15744\1642937411.py:1: FutureWarning: The default of observed=False is deprecated and will be changed to True in a future version of pandas. Pass observed=False to retain current behavior or observed=True to adopt the future default and silence this warning.
      outcomes_per_rating_bracket = df3.groupby(['rating_brackets', 'winner'])['winner'].agg(['count']).reset_index()
    




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
      <th>rating_brackets</th>
      <th>winner</th>
      <th>count</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1000-</td>
      <td>Black</td>
      <td>42</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1000-</td>
      <td>Draw</td>
      <td>2</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1000-</td>
      <td>White</td>
      <td>49</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1000-1199</td>
      <td>Black</td>
      <td>484</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1000-1199</td>
      <td>Draw</td>
      <td>58</td>
    </tr>
    <tr>
      <th>5</th>
      <td>1000-1199</td>
      <td>White</td>
      <td>538</td>
    </tr>
    <tr>
      <th>6</th>
      <td>1200-1399</td>
      <td>Black</td>
      <td>1640</td>
    </tr>
    <tr>
      <th>7</th>
      <td>1200-1399</td>
      <td>Draw</td>
      <td>132</td>
    </tr>
    <tr>
      <th>8</th>
      <td>1200-1399</td>
      <td>White</td>
      <td>1910</td>
    </tr>
    <tr>
      <th>9</th>
      <td>1400-1599</td>
      <td>Black</td>
      <td>2793</td>
    </tr>
    <tr>
      <th>10</th>
      <td>1400-1599</td>
      <td>Draw</td>
      <td>245</td>
    </tr>
    <tr>
      <th>11</th>
      <td>1400-1599</td>
      <td>White</td>
      <td>3043</td>
    </tr>
    <tr>
      <th>12</th>
      <td>1600-1799</td>
      <td>Black</td>
      <td>2120</td>
    </tr>
    <tr>
      <th>13</th>
      <td>1600-1799</td>
      <td>Draw</td>
      <td>229</td>
    </tr>
    <tr>
      <th>14</th>
      <td>1600-1799</td>
      <td>White</td>
      <td>2317</td>
    </tr>
    <tr>
      <th>15</th>
      <td>1800-1999</td>
      <td>Black</td>
      <td>1349</td>
    </tr>
    <tr>
      <th>16</th>
      <td>1800-1999</td>
      <td>Draw</td>
      <td>165</td>
    </tr>
    <tr>
      <th>17</th>
      <td>1800-1999</td>
      <td>White</td>
      <td>1449</td>
    </tr>
    <tr>
      <th>18</th>
      <td>2000-2199</td>
      <td>Black</td>
      <td>564</td>
    </tr>
    <tr>
      <th>19</th>
      <td>2000-2199</td>
      <td>Draw</td>
      <td>84</td>
    </tr>
    <tr>
      <th>20</th>
      <td>2000-2199</td>
      <td>White</td>
      <td>575</td>
    </tr>
    <tr>
      <th>21</th>
      <td>2200+</td>
      <td>Black</td>
      <td>115</td>
    </tr>
    <tr>
      <th>22</th>
      <td>2200+</td>
      <td>Draw</td>
      <td>35</td>
    </tr>
    <tr>
      <th>23</th>
      <td>2200+</td>
      <td>White</td>
      <td>120</td>
    </tr>
  </tbody>
</table>
</div>




```python
 fig, ax = plt.subplots(figsize = (20, 8))
palette = ["#fee090","#4575b4","#a50026"]
sns.barplot( data = outcomes_per_rating_bracket, x = 'rating_brackets', y = 'count', ax = ax, hue= 'winner', palette= palette)
 for container in ax.containers:
    ax.bar_label(container, label_type='edge')
ax.margins(y=0.1)
plt.title("Favourable Outcomes per Rating Brackets\n", fontsize =16)
plt.xlabel('\nRating Brackets', fontsize =12)
plt.ylabel('Count\n', fontsize =12)
plt.legend(fontsize =14)
plt.show()
```


    
![image](https://github.com/Sambhav10/Data_Analyst_Portfolio/assets/85670420/e7f4199d-0172-4821-9468-1d4004e8ac34)

    

```python
#3- Which openings different level of chess players ususally prefer ? 
```


```python
df3['opening_name'].value_counts()
```




    opening_name
    Sicilian Defense       2632
    Queen's Pawn           2306
    French Defense         1412
    Italian Game            981
    Queen's Gambit          912
                           ... 
    Pterodactyl Defense       1
    Global Opening            1
    Valencia Opening          1
    Doery Defense             1
    Australian Defense        1
    Name: count, Length: 123, dtype: int64




```python
# since there are 123 unique opening played , we are only gonna analyze  those opening which has been played more than 500 times 
# trying to remove outliers 
# 500/20,000 = 0.025 / 100 % = 2.5 
# there is a chance of selecting the particular opening 2.5 times out of 100.

#filtering the openings that has been played more than 500 times 
opening_played = df3.groupby('opening_name').filter(lambda n: len(n) > 500)
#assigning the count of opening_names played to a variable and then mapping to the names in the opening_played table
opening_counts = opening_played['opening_name'].value_counts()
opening_played['opening_played_count'] = opening_played['opening_name'].map(opening_counts)
opening_played
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
      <th>game_id</th>
      <th>rated</th>
      <th>turns</th>
      <th>victory_status</th>
      <th>winner</th>
      <th>time_increment</th>
      <th>white_rating</th>
      <th>black_rating</th>
      <th>opening_code</th>
      <th>opening_moves</th>
      <th>opening_name</th>
      <th>average_rating</th>
      <th>rating_brackets</th>
      <th>opening_played_count</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>True</td>
      <td>61</td>
      <td>Mate</td>
      <td>White</td>
      <td>5+10</td>
      <td>1496</td>
      <td>1500</td>
      <td>C20</td>
      <td>3</td>
      <td>Queen's Pawn</td>
      <td>1498.0</td>
      <td>1400-1599</td>
      <td>2306</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>True</td>
      <td>61</td>
      <td>Mate</td>
      <td>White</td>
      <td>20+0</td>
      <td>1439</td>
      <td>1454</td>
      <td>D02</td>
      <td>3</td>
      <td>Queen's Pawn</td>
      <td>1446.5</td>
      <td>1400-1599</td>
      <td>2306</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>True</td>
      <td>95</td>
      <td>Mate</td>
      <td>White</td>
      <td>30+3</td>
      <td>1523</td>
      <td>1469</td>
      <td>C41</td>
      <td>5</td>
      <td>Philidor Defense</td>
      <td>1496.0</td>
      <td>1400-1599</td>
      <td>691</td>
    </tr>
    <tr>
      <th>5</th>
      <td>6</td>
      <td>False</td>
      <td>5</td>
      <td>Draw</td>
      <td>Draw</td>
      <td>10+0</td>
      <td>1250</td>
      <td>1002</td>
      <td>B27</td>
      <td>4</td>
      <td>Sicilian Defense</td>
      <td>1126.0</td>
      <td>1000-1199</td>
      <td>2632</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>True</td>
      <td>66</td>
      <td>Resign</td>
      <td>Black</td>
      <td>15+0</td>
      <td>1439</td>
      <td>1392</td>
      <td>C50</td>
      <td>6</td>
      <td>Italian Game</td>
      <td>1415.5</td>
      <td>1400-1599</td>
      <td>981</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>20050</th>
      <td>20051</td>
      <td>True</td>
      <td>9</td>
      <td>Out of Time</td>
      <td>White</td>
      <td>10+0</td>
      <td>1243</td>
      <td>1142</td>
      <td>A20</td>
      <td>2</td>
      <td>English Opening</td>
      <td>1192.5</td>
      <td>1000-1199</td>
      <td>720</td>
    </tr>
    <tr>
      <th>20051</th>
      <td>20052</td>
      <td>True</td>
      <td>58</td>
      <td>Mate</td>
      <td>Black</td>
      <td>10+10</td>
      <td>1237</td>
      <td>1231</td>
      <td>C00</td>
      <td>3</td>
      <td>French Defense</td>
      <td>1234.0</td>
      <td>1200-1399</td>
      <td>1412</td>
    </tr>
    <tr>
      <th>20054</th>
      <td>20055</td>
      <td>True</td>
      <td>82</td>
      <td>Mate</td>
      <td>Black</td>
      <td>10+0</td>
      <td>1233</td>
      <td>1196</td>
      <td>A41</td>
      <td>2</td>
      <td>Queen's Pawn</td>
      <td>1214.5</td>
      <td>1200-1399</td>
      <td>2306</td>
    </tr>
    <tr>
      <th>20055</th>
      <td>20056</td>
      <td>True</td>
      <td>35</td>
      <td>Mate</td>
      <td>White</td>
      <td>10+0</td>
      <td>1219</td>
      <td>1286</td>
      <td>D00</td>
      <td>3</td>
      <td>Queen's Pawn</td>
      <td>1252.5</td>
      <td>1200-1399</td>
      <td>2306</td>
    </tr>
    <tr>
      <th>20057</th>
      <td>20058</td>
      <td>True</td>
      <td>78</td>
      <td>Mate</td>
      <td>Black</td>
      <td>10+0</td>
      <td>1235</td>
      <td>1339</td>
      <td>D00</td>
      <td>3</td>
      <td>Queen's Pawn</td>
      <td>1287.0</td>
      <td>1200-1399</td>
      <td>2306</td>
    </tr>
  </tbody>
</table>
<p>11825 rows × 14 columns</p>
</div>




```python
opening_played_per_rating_brackets = opening_played.groupby(['rating_brackets', 'opening_name']).size().unstack()
opening_played_per_rating_brackets =opening_played_per_rating_brackets.astype(int)
opening_played_per_rating_brackets
```

    C:\Users\sambh\AppData\Local\Temp\ipykernel_15744\147765932.py:1: FutureWarning: The default of observed=False is deprecated and will be changed to True in a future version of pandas. Pass observed=False to retain current behavior or observed=True to adopt the future default and silence this warning.
      opening_played_per_rating_brackets = opening_played.groupby(['rating_brackets', 'opening_name']).size().unstack()
    




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
      <th>opening_name</th>
      <th>Caro-Kann Defense</th>
      <th>English Opening</th>
      <th>French Defense</th>
      <th>Italian Game</th>
      <th>Philidor Defense</th>
      <th>Queen's Gambit</th>
      <th>Queen's Pawn</th>
      <th>Ruy Lopez</th>
      <th>Scandinavian Defense</th>
      <th>Sicilian Defense</th>
    </tr>
    <tr>
      <th>rating_brackets</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
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
      <th>1000-</th>
      <td>0</td>
      <td>1</td>
      <td>5</td>
      <td>1</td>
      <td>1</td>
      <td>2</td>
      <td>25</td>
      <td>0</td>
      <td>8</td>
      <td>5</td>
    </tr>
    <tr>
      <th>1000-1199</th>
      <td>15</td>
      <td>24</td>
      <td>77</td>
      <td>25</td>
      <td>50</td>
      <td>21</td>
      <td>192</td>
      <td>24</td>
      <td>66</td>
      <td>61</td>
    </tr>
    <tr>
      <th>1200-1399</th>
      <td>88</td>
      <td>104</td>
      <td>221</td>
      <td>176</td>
      <td>176</td>
      <td>134</td>
      <td>603</td>
      <td>139</td>
      <td>171</td>
      <td>274</td>
    </tr>
    <tr>
      <th>1400-1599</th>
      <td>162</td>
      <td>262</td>
      <td>384</td>
      <td>340</td>
      <td>257</td>
      <td>253</td>
      <td>733</td>
      <td>264</td>
      <td>211</td>
      <td>753</td>
    </tr>
    <tr>
      <th>1600-1799</th>
      <td>144</td>
      <td>146</td>
      <td>368</td>
      <td>279</td>
      <td>140</td>
      <td>280</td>
      <td>443</td>
      <td>218</td>
      <td>122</td>
      <td>696</td>
    </tr>
    <tr>
      <th>1800-1999</th>
      <td>126</td>
      <td>112</td>
      <td>251</td>
      <td>107</td>
      <td>56</td>
      <td>149</td>
      <td>222</td>
      <td>134</td>
      <td>90</td>
      <td>541</td>
    </tr>
    <tr>
      <th>2000-2199</th>
      <td>51</td>
      <td>63</td>
      <td>94</td>
      <td>40</td>
      <td>11</td>
      <td>54</td>
      <td>69</td>
      <td>64</td>
      <td>47</td>
      <td>243</td>
    </tr>
    <tr>
      <th>2200+</th>
      <td>11</td>
      <td>8</td>
      <td>12</td>
      <td>13</td>
      <td>0</td>
      <td>19</td>
      <td>19</td>
      <td>15</td>
      <td>1</td>
      <td>59</td>
    </tr>
  </tbody>
</table>
</div>




```python
fig, ax = plt.subplots(figsize=(12, 8))
sns.heatmap(opening_played_per_rating_brackets, cmap=sns.color_palette("rocket_r", as_cmap=True), fmt='g', linecolor='black', linewidths=0.0028, ax=ax)
plt.title("Opening Played by Rating Brackets\n")
plt.ylabel('Rating Brackets\n')
plt.yticks(fontsize=10, rotation=0)
plt.xticks(fontsize=10, rotation= 60)
plt.xlabel("Name of Openings")
plt.show()

```


    
![image](https://github.com/Sambhav10/Data_Analyst_Portfolio/assets/85670420/6d9ccc84-f356-4103-b246-57b3c0dc0f28)

    



```python
#- Which openings gives the best outcomes(win, or maybe draw) for white or black ? 
```


```python
outcomes_per_opening = opening_played.groupby(['opening_name', 'winner'])['winner'].agg(['count']).reset_index()
print(outcomes_per_opening)
```

                opening_name winner  count
    0      Caro-Kann Defense  Black    269
    1      Caro-Kann Defense   Draw     34
    2      Caro-Kann Defense  White    294
    3        English Opening  Black    296
    4        English Opening   Draw     29
    5        English Opening  White    395
    6         French Defense  Black    653
    7         French Defense   Draw     70
    8         French Defense  White    689
    9           Italian Game  Black    451
    10          Italian Game   Draw     47
    11          Italian Game  White    483
    12      Philidor Defense  Black    267
    13      Philidor Defense   Draw     28
    14      Philidor Defense  White    396
    15        Queen's Gambit  Black    365
    16        Queen's Gambit   Draw     35
    17        Queen's Gambit  White    512
    18          Queen's Pawn  Black   1095
    19          Queen's Pawn   Draw    102
    20          Queen's Pawn  White   1109
    21             Ruy Lopez  Black    358
    22             Ruy Lopez   Draw     49
    23             Ruy Lopez  White    451
    24  Scandinavian Defense  Black    332
    25  Scandinavian Defense   Draw     26
    26  Scandinavian Defense  White    358
    27      Sicilian Defense  Black   1299
    28      Sicilian Defense   Draw    130
    29      Sicilian Defense  White   1203
    


```python
fig, ax = plt.subplots(figsize =(18, 8)) 
palette = ["#000000","#4575b4","#a50026"]
sns.lineplot(data =outcomes_per_opening, x = 'opening_name', y = 'count', hue= 'winner', palette= palette )
plt.title('Favourable Outcomes Per Opening\n' , fontsize =16)
plt.ylabel('Count\n', fontsize = 12)
plt.xlabel('\nOpenings', fontsize = 12)
plt.legend( fontsize=18)
plt.show()


```


    
![image](https://github.com/Sambhav10/Data_Analyst_Portfolio/assets/85670420/601b8523-79b2-466d-86d4-c9ef52f96d8b)

    



```python
#5- Average amount of turns in different openings .
```


```python
turns_per_each_opening= opening_played.groupby(['opening_name','rated' ])['turns'].agg('mean').reset_index()
turns_per_each_opening.round().sort_values('turns', ascending = False)
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
      <th>opening_name</th>
      <th>rated</th>
      <th>turns</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1</th>
      <td>Caro-Kann Defense</td>
      <td>True</td>
      <td>66.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>English Opening</td>
      <td>True</td>
      <td>65.0</td>
    </tr>
    <tr>
      <th>9</th>
      <td>Philidor Defense</td>
      <td>True</td>
      <td>65.0</td>
    </tr>
    <tr>
      <th>19</th>
      <td>Sicilian Defense</td>
      <td>True</td>
      <td>64.0</td>
    </tr>
    <tr>
      <th>11</th>
      <td>Queen's Gambit</td>
      <td>True</td>
      <td>64.0</td>
    </tr>
    <tr>
      <th>15</th>
      <td>Ruy Lopez</td>
      <td>True</td>
      <td>64.0</td>
    </tr>
    <tr>
      <th>5</th>
      <td>French Defense</td>
      <td>True</td>
      <td>63.0</td>
    </tr>
    <tr>
      <th>13</th>
      <td>Queen's Pawn</td>
      <td>True</td>
      <td>61.0</td>
    </tr>
    <tr>
      <th>14</th>
      <td>Ruy Lopez</td>
      <td>False</td>
      <td>60.0</td>
    </tr>
    <tr>
      <th>7</th>
      <td>Italian Game</td>
      <td>True</td>
      <td>59.0</td>
    </tr>
    <tr>
      <th>17</th>
      <td>Scandinavian Defense</td>
      <td>True</td>
      <td>57.0</td>
    </tr>
    <tr>
      <th>0</th>
      <td>Caro-Kann Defense</td>
      <td>False</td>
      <td>57.0</td>
    </tr>
    <tr>
      <th>12</th>
      <td>Queen's Pawn</td>
      <td>False</td>
      <td>56.0</td>
    </tr>
    <tr>
      <th>8</th>
      <td>Philidor Defense</td>
      <td>False</td>
      <td>56.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>English Opening</td>
      <td>False</td>
      <td>56.0</td>
    </tr>
    <tr>
      <th>18</th>
      <td>Sicilian Defense</td>
      <td>False</td>
      <td>56.0</td>
    </tr>
    <tr>
      <th>10</th>
      <td>Queen's Gambit</td>
      <td>False</td>
      <td>55.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>French Defense</td>
      <td>False</td>
      <td>53.0</td>
    </tr>
    <tr>
      <th>16</th>
      <td>Scandinavian Defense</td>
      <td>False</td>
      <td>52.0</td>
    </tr>
    <tr>
      <th>6</th>
      <td>Italian Game</td>
      <td>False</td>
      <td>49.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
fig, ax = plt.subplots(figsize=(18, 8))
sns.violinplot(x="opening_name", y='turns', data=opening_played, hue = 'rated')
plt.title('Turns taken Per Opening Across Rated Games\n', fontsize =16)
plt.xlabel("\nOpenings " , fontsize= 12)
plt.ylabel("Turns \n" , fontsize= 12)
plt.show()
```


    
![image](https://github.com/Sambhav10/Data_Analyst_Portfolio/assets/85670420/6c20d9aa-19ac-40e8-b530-a0271bfb569f)

    



```python
#6- What was the victory status(out of time , resign , mate, draw) when using different opening and players of different levels ?
```


```python
victory_status = opening_played.groupby([ 'opening_name', 'victory_status'] )['victory_status'].agg(['count']).reset_index()
victory_status
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
      <th>opening_name</th>
      <th>victory_status</th>
      <th>count</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Caro-Kann Defense</td>
      <td>Draw</td>
      <td>32</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Caro-Kann Defense</td>
      <td>Mate</td>
      <td>166</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Caro-Kann Defense</td>
      <td>Out of Time</td>
      <td>51</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Caro-Kann Defense</td>
      <td>Resign</td>
      <td>348</td>
    </tr>
    <tr>
      <th>4</th>
      <td>English Opening</td>
      <td>Draw</td>
      <td>28</td>
    </tr>
    <tr>
      <th>5</th>
      <td>English Opening</td>
      <td>Mate</td>
      <td>202</td>
    </tr>
    <tr>
      <th>6</th>
      <td>English Opening</td>
      <td>Out of Time</td>
      <td>72</td>
    </tr>
    <tr>
      <th>7</th>
      <td>English Opening</td>
      <td>Resign</td>
      <td>418</td>
    </tr>
    <tr>
      <th>8</th>
      <td>French Defense</td>
      <td>Draw</td>
      <td>65</td>
    </tr>
    <tr>
      <th>9</th>
      <td>French Defense</td>
      <td>Mate</td>
      <td>428</td>
    </tr>
    <tr>
      <th>10</th>
      <td>French Defense</td>
      <td>Out of Time</td>
      <td>112</td>
    </tr>
    <tr>
      <th>11</th>
      <td>French Defense</td>
      <td>Resign</td>
      <td>807</td>
    </tr>
    <tr>
      <th>12</th>
      <td>Italian Game</td>
      <td>Draw</td>
      <td>46</td>
    </tr>
    <tr>
      <th>13</th>
      <td>Italian Game</td>
      <td>Mate</td>
      <td>309</td>
    </tr>
    <tr>
      <th>14</th>
      <td>Italian Game</td>
      <td>Out of Time</td>
      <td>74</td>
    </tr>
    <tr>
      <th>15</th>
      <td>Italian Game</td>
      <td>Resign</td>
      <td>552</td>
    </tr>
    <tr>
      <th>16</th>
      <td>Philidor Defense</td>
      <td>Draw</td>
      <td>27</td>
    </tr>
    <tr>
      <th>17</th>
      <td>Philidor Defense</td>
      <td>Mate</td>
      <td>243</td>
    </tr>
    <tr>
      <th>18</th>
      <td>Philidor Defense</td>
      <td>Out of Time</td>
      <td>60</td>
    </tr>
    <tr>
      <th>19</th>
      <td>Philidor Defense</td>
      <td>Resign</td>
      <td>361</td>
    </tr>
    <tr>
      <th>20</th>
      <td>Queen's Gambit</td>
      <td>Draw</td>
      <td>33</td>
    </tr>
    <tr>
      <th>21</th>
      <td>Queen's Gambit</td>
      <td>Mate</td>
      <td>255</td>
    </tr>
    <tr>
      <th>22</th>
      <td>Queen's Gambit</td>
      <td>Out of Time</td>
      <td>67</td>
    </tr>
    <tr>
      <th>23</th>
      <td>Queen's Gambit</td>
      <td>Resign</td>
      <td>557</td>
    </tr>
    <tr>
      <th>24</th>
      <td>Queen's Pawn</td>
      <td>Draw</td>
      <td>96</td>
    </tr>
    <tr>
      <th>25</th>
      <td>Queen's Pawn</td>
      <td>Mate</td>
      <td>850</td>
    </tr>
    <tr>
      <th>26</th>
      <td>Queen's Pawn</td>
      <td>Out of Time</td>
      <td>200</td>
    </tr>
    <tr>
      <th>27</th>
      <td>Queen's Pawn</td>
      <td>Resign</td>
      <td>1160</td>
    </tr>
    <tr>
      <th>28</th>
      <td>Ruy Lopez</td>
      <td>Draw</td>
      <td>48</td>
    </tr>
    <tr>
      <th>29</th>
      <td>Ruy Lopez</td>
      <td>Mate</td>
      <td>269</td>
    </tr>
    <tr>
      <th>30</th>
      <td>Ruy Lopez</td>
      <td>Out of Time</td>
      <td>51</td>
    </tr>
    <tr>
      <th>31</th>
      <td>Ruy Lopez</td>
      <td>Resign</td>
      <td>490</td>
    </tr>
    <tr>
      <th>32</th>
      <td>Scandinavian Defense</td>
      <td>Draw</td>
      <td>25</td>
    </tr>
    <tr>
      <th>33</th>
      <td>Scandinavian Defense</td>
      <td>Mate</td>
      <td>234</td>
    </tr>
    <tr>
      <th>34</th>
      <td>Scandinavian Defense</td>
      <td>Out of Time</td>
      <td>63</td>
    </tr>
    <tr>
      <th>35</th>
      <td>Scandinavian Defense</td>
      <td>Resign</td>
      <td>394</td>
    </tr>
    <tr>
      <th>36</th>
      <td>Sicilian Defense</td>
      <td>Draw</td>
      <td>122</td>
    </tr>
    <tr>
      <th>37</th>
      <td>Sicilian Defense</td>
      <td>Mate</td>
      <td>721</td>
    </tr>
    <tr>
      <th>38</th>
      <td>Sicilian Defense</td>
      <td>Out of Time</td>
      <td>228</td>
    </tr>
    <tr>
      <th>39</th>
      <td>Sicilian Defense</td>
      <td>Resign</td>
      <td>1561</td>
    </tr>
  </tbody>
</table>
</div>




```python
fig = plt.subplots(figsize =(18, 8))
palette = ['#1f77b4', '#000000', '#2ca02c', '#d62728']
sns.lineplot(data =victory_status, x = "opening_name", y = "count", hue = "victory_status", palette= palette )
plt.title("Victory Status per Opening\n", fontsize = 16)
plt.xlabel("\nOpening", fontsize= 12)
plt.ylabel("Count\n", fontsize= 12)
plt.legend(fontsize =14)
plt.show()
```


![image](https://github.com/Sambhav10/Data_Analyst_Portfolio/assets/85670420/b856c252-29d6-4b2d-bb6c-1e4e5b47cbe2)



# Conclusion 
1. A significant portion, around 30% of chess players, have an average rating between 1400 and 1599, totaling approximately 6081 players.
2. Across all rating levels, players consistently have a higher chance of winning games when playing with the white pieces compared to the black pieces.
3. The Sicilian Defense is the most frequently played opening among chess players, accounting for 13% of all games (2632 games). This means in every 100 games, 13 feature the Sicilian Defense.
4. When played with the black pieces, the Sicilian Defense offers a higher chance of winning compared to playing with the white pieces. Specifically, out of 2632 games, 50% were won by black, 46% by white, and 4% ended in a draw.
5. The Caro-Kann Defense stands out as a solid opening, characterized by games averaging 66 turns (each turn being a move made by both players).
6. Interestingly, a significant number of chess players choose to resign rather than face checkmate. Approximately one out of every two games results in a resignation.
   
   








    



```python



```
