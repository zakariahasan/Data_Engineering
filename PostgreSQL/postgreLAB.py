import pandas as pd
import psycopg2

class CsvToPostgres:
      """
    A class that loads data from a CSV file into a PostgreSQL database.

    Parameters
    ----------
    host : str
        The hostname of the PostgreSQL server.
    database : str
        The name of the PostgreSQL database to connect to.
    user : str
        The username used to authenticate with the PostgreSQL server.
    password : str
        The password used to authenticate with the PostgreSQL server.
    file_path : str
        The file path of the CSV file to load data from.
    table_name : str
        The name of the PostgreSQL table to create.
    sep : str, optional
        The delimiter used in the CSV file. Default is '|'.
    nrows : int, optional
        The number of rows to read from the CSV file. Default is None (read all rows).
    dtype : dict, optional
        A dictionary with column names as keys and data types as values. Default is None (infer data types).

    Methods
    -------
    load_csv_to_dataframe()
        Loads the CSV file into a Pandas DataFrame.
    create_table()
        Creates a table in the PostgreSQL database using the column names from the CSV file.
    load_data_to_table()
        Loads the data from the CSV file into the PostgreSQL table.
    """
  
    def __init__(self, host, database, user, password, file_path, table_name, sep='|', nrows=None, dtype=None):
        self.host = host
        self.database = database
        self.user = user
        self.password = password
        self.file_path = file_path
        self.table_name = table_name
        self.sep = sep
        self.nrows = nrows
        self.dtype = dtype
        # Connect to the PostgreSQL database
        self.conn = psycopg2.connect(
            host=self.host,
            database=self.database,
            user=self.user,
            password=self.password
        )
        
    
    def load_csv_to_dataframe(self):
        # Load the CSV file into a Pandas dataframe
        df = pd.read_csv(self.file_path, sep=self.sep, nrows=self.nrows, dtype=self.dtype)
        return df
    
    def create_table(self):


        # Define the SQL statement to create the table
        df = self.load_csv_to_dataframe()
        columns = ', '.join([f'{col} VARCHAR(255)' for col in df.columns])
        create_table_sql = f"CREATE TABLE dbt.{self.table_name} ({columns});"
        
        # Execute the SQL statement to create the table
        with conn.cursor() as cur:
            cur.execute(create_table_sql)
        
        # Commit the changes to the database
        self.conn.commit()

        # Close the database connection
        self.conn.close()
    
    def load_data_to_table(self):

        # Load the data into the table
        df = self.load_csv_to_dataframe()
        df_columns = list(df)
        with self.conn.cursor() as cur:
            for index, row in df.iterrows():
                sql = f"INSERT INTO dbt.{self.table_name} ({', '.join(df_columns)}) values ({'%s,'*(len(df_columns)-1)}%s)"
                cur.execute(sql, tuple(row))
            
            # Commit the changes to the database
            self.conn.commit()

        # Close the database connection
        self.conn.close()
