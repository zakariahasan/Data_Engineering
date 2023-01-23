UPDATE vendor_master_data 
SET vendor_name = 'Anonymized', 
    vendor_address = 'Anonymized', 
    vendor_phone = 'Anonymized', 
    vendor_email = 'Anonymized' 
WHERE vendor_group = 'EMP';

---------------------------------
UPDATE transaction_table 
SET vendor_name = 'Anonymized', 
    vendor_address = 'Anonymized', 
    vendor_phone = 'Anonymized', 
    vendor_email = 'Anonymized' 
FROM vendor_master_data 
WHERE vendor_master_data.vendor_id = transaction_table.vendor_id 
AND vendor_master_data.vendor_group = 'EMP';
