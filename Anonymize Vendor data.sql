UPDATE Vendor_table
SET MD_VendorDesc = 'Anonymized', 
    MD_VendorAddress = 'Anonymized', 
    MD_VendorCity = 'Anonymized', 
    MD_VendorPostalCode = 'Anonymized', 
	MD_VendorState = 'Anonymized',
	MD_VendorCountry = 'Anonymized',
	MD_VendorCountryCode = 'Anonymized'
WHERE MD_VendorGroupNo = 'EMPL';
---------------------------------
UPDATE transaction_table 
SET vendor_name = 'Anonymized', 
    vendor_address = 'Anonymized', 
    vendor_phone = 'Anonymized', 
    vendor_email = 'Anonymized' 
FROM vendor_master_data 
WHERE vendor_master_data.vendor_id = transaction_table.vendor_id 
AND vendor_master_data.vendor_group = 'EMP';
