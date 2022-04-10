

# Para insertar datos en las tabla con sql-conector

def insert(df, table):
    for i in range(len(df)):
        insert_query = f"insert into {table} ({','.join(df.columns)}) values {tuple(df.iloc[i].values)};"

        cursor.execute(insert_query)

    db.commit()
    print('Comiteado!')


# Para select con sqlalchemy

def show_df(query='select * from film;'):
    return pd.read_sql(query, motor)

