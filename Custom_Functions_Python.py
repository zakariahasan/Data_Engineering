def calculate_invoice_due_date(row):
    current_date0 = datetime.now()
    ZFBDT = str(row['ZFBDT']) if not pd.isna(row['ZFBDT']) and row['ZFBDT'] != 0 else '00000000'
    ZBD1T = str(int(row['ZBD1T'])) if not pd.isna(row['ZBD1T']) and row['ZBD1T'] != 0 else '0'
    ZBD2T = str(int(row['ZBD2T'])) if not pd.isna(row['ZBD2T']) and row['ZBD2T'] != 0 else '0'
    ZBD3T = str(int(row['ZBD3T'])) if not pd.isna(row['ZBD3T']) and row['ZBD3T'] != 0 else '0'
    
    if ZFBDT != '00000000' and abs(current_date0.year - datetime.strptime(ZFBDT, '%Y%m%d').year) <= 20:
        invoice_due_date = datetime.strptime(ZFBDT, '%Y%m%d') + timedelta(days=int(ZBD1T) if int(ZBD1T) != 0 else int(ZBD2T) if int(ZBD2T) != 0 else int(ZBD3T))
        return invoice_due_date
    else:
        return None
#df['invoice_due_date'] = df.apply(calculate_invoice_due_date, axis=1)


#########################################################################

import pandas as pd

# Load BSEG data into a pandas DataFrame
df = pd.read_csv('/Users/zakaria/Notebooks/data//sample_BSEG20222.txt',sep='|',dtype=object)

# Group data by document number
grouped = df.groupby(by=['MANDT','BUKRS','BELNR'])
print(grouped)
# Define a function to fill null values with the vendor number of the same document
def fill_vendor_number(group):
    if pd.isnull(group['LIFNR']).any():
        vendor_number = group['LIFNR'].dropna().iloc[0]
        group['LIFNR'].fillna(vendor_number, inplace=True)
    return group

# Apply the function to each group
df_filled = grouped.apply(fill_vendor_number)
print(df_filled)
# Save the filled data to a new CSV file
#df_filled.to_csv('BSEG_table_data_filled.csv', index=False)

#########################################################################
