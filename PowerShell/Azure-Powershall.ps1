#Create a new resource group
New-AzResourceGroup -Name Packtade-powershell -Location 'East US'

# Create a new Azure Storage Account
New-AzStorageAccount -ResourceGroupName Packtade-powershell `
	-Name packtstoragepowershell `
	-SkuName Standard_LRS `
	-Location 'East US' `
	-Kind StorageV2 `
	-AccessTier Hot
  
# Creating a new container in an Azure Storage Account

$storageaccountname="packtadestorage"
$containername="logfiles"
$resourcegroup="packtade"

#Get the Azure Storage account context
$storagecontext = (Get-AzStorageAccount -ResourceGroupName $resourcegroup -Name $storageaccountname).Context;

#Create a new container
New-AzStorageContainer -Name $containername -Context $storagecontext

#upload single file to container

#change the file path and blob name
$file = "C:\ADECookbook\Chapter01\Logfiles\Logfile1.txt"
$blob = "Logfile1.txt"
Set-AzStorageBlobContent -File $file -Context $storagecontext -Blob $blob -Container $containername


#uploading multiple files to a container

$directory  = "C:\ADECookbook\Chapter1\Logfiles"
#get files to be uploaded from the directory
$files = Get-ChildItem -Path $directory

#iterate through each file int the folder and upload it to the azure container

foreach($file in $files){

    Set-AzStorageBlobContent -File $file.FullName -Context $storagecontext -Blob $file.BaseName -Container $containername -Force

}


# Create a new container

#set the parameter values
$storageaccountname="packtadestorage"
$resourcegroup="packtade"
$sourcecontainername="logfiles"
$destcontainername="textfiles"

#Get storage account context
$storagecontext = (Get-AzStorageAccount -ResourceGroupName $resourcegroup -Name $storageaccountname).Context

# create the container 
$destcontainer = New-AzStorageContainer -Name $destcontainername -Context $storagecontext

#copy a single blob from one container to another

# name of the blob to copy from soure to destination container
$blob="Logfile1"
Start-CopyAzureStorageBlob -SrcBlob $blob `
						   -SrcContainer $sourcecontainername `
						   -DestContainer $destcontainername `
						   -Context $storagecontext `
						   -DestContext $storagecontext

# copy all blobs in new container
Get-AzStorageBlob -Container $sourcecontainername -Context $storagecontext | Start-CopyAzureStorageBlob -DestContainer $destcontainername -DestContext $storagecontext -force

# Listing blobs in an Azure storage container

# list the blobs in the destination container

(Get-AzStorageContainer -Name $destcontainername -Context $storagecontext).CloudBlobContainer.ListBlobs()

# Modifying blob access tier

# Get the blob reference 
$blob = Get-AzStorageBlob -Blob *Logfile4* -Container $sourcecontainername -Context $storagecontext

#Get current access tier
$blob

#change access tier to cool
$blob.ICloudBlob.SetStandardBlobTier("Cool")

#Get the modified access tier
$blob


# Change the access tier of all the blobs in a container

#get blob reference
$blobs = Get-AzStorageBlob -Container $destcontainername -Context $storagecontext

#change the access tier of all the blobs in the container
$blobs.icloudblob.setstandardblobtier("Cool")

#verify the access tier
$blobs


# Downloading blob

#get the storage context
$storagecontext = (Get-AzStorageAccount -ResourceGroupName $resourcegroup -Name $storageaccountname).Context

#download the blob

# Name of the blob to be downloaded
$blob = "Logfile1"
Get-AzStorageBlobContent -Blob "Logfile1" `
						 -Container $sourcecontainername `
						 -Destination C:\ADECookbook\Chapter1\Logfiles\ `
						 -Context $storagecontext -Force
						 
# Deleting blob

#get the storage context
$storagecontext = (Get-AzStorageAccount -ResourceGroupName $resourcegroup -Name $storageaccountname).Context

# name of the blob to be removed
$blob="Logfile2"

#remove blob
Remove-AzStorageBlob -Blob $blob -Container $sourcecontainername -Context $storagecontext



# Managing blob Snapshot

#set the parameter values
$storageaccountname="packtadestorage"
$resourcegroup="packtade"
$sourcecontainername ="logfiles"

# Creating blob snapshot

#get the storage context
$storagecontext = (Get-AzStorageAccount -ResourceGroupName $resourcegroup -Name $storageaccountname).Context

#get blob context
$blob = Get-AzStorageBlob -Blob *Logfile5* -Container $sourcecontainername -Context $storagecontext

#create blob snapshot
$blob.ICloudBlob.CreateSnapshot()


#listing blob snapshots

# get blobs in a container
$blobs = Get-AzStorageBlob -Container $sourcecontainername -Context $storagecontext

#list snapshots
$blobs | Where-Object{$_.ICloudBlob.IsSnapshot -eq $true}


# Promoting snapshot

#get reference of original blob
$blob = Get-AzStorageBlob -Blob *Logfile5* -Container $sourcecontainername -Context $storagecontext
$originalblob = $blob | Where-Object{$_.ICloudBlob.IsSnapshot -eq $false}

#get reference of the blob snapshot
$blobsnapshot = $blob | Where-Object{$_.ICloudBlob.IsSnapshot -eq $true}

#overwrite the original blob with the snapshot
Start-CopyAzureStorageBlob -CloudBlob $blobsnapshot.ICloudBlob -DestCloudBlob $originalblob.ICloudBlob -Context $storagecontext -Force

# Deleting blob snapshot
Remove-AzStorageBlob -CloudBlob $originalblob.ICloudBlob -DeleteSnapshot -Context $storagecontext


# Set parameters

$storageaccountname = "$resourcegroupstorage"
$resourcegroup = "$resourcegroup"

# deny access to all networks
Update-AzStorageAccountNetworkRuleSet -ResourceGroupName $resourcegroup -Name $storageaccountname -DefaultAction Deny


#get client/host public IP Address
$mypublicIP = (Invoke-WebRequest -uri "http://ifconfig.me/ip").Content

#Add client IP address firewall rule
Add-AzStorageAccountNetworkRule -ResourceGroupName $resourcegroup -AccountName $storageaccountname -IPAddressOrRange $mypublicIP


# Add/whitelist a custom IP address to firewall

Add-AzStorageAccountNetworkRule -ResourceGroupName $resourcegroup -AccountName $storageaccountname -IPAddressOrRange "20.24.29.30"


#whitelist range of IPs
Add-AzStorageAccountNetworkRule -ResourceGroupName $resourcegroup -AccountName $storageaccountname -IPAddressOrRange "20.24.0.0/24"


# Get existing firewall rules
(Get-AzStorageAccountNetworkRuleSet -ResourceGroupName $resourcegroup -Name $storageaccountname).IpRules

#Remove the client IP from the firewall rule
Remove-AzStorageAccountNetworkRule -ResourceGroupName $resourcegroup -Name $storageaccountname -IPAddressOrRange $mypublicIP

#Remove the single IP from the firewall rule
Remove-AzStorageAccountNetworkRule -ResourceGroupName $resourcegroup -Name $storageaccountname -IPAddressOrRange "20.24.29.30"

#Remove the IP range from the firewall rule
Remove-AzStorageAccountNetworkRule -ResourceGroupName $resourcegroup -Name $storageaccountname -IPAddressOrRange "20.24.0.0/24"

# Allow access to all networks
Update-AzStorageAccountNetworkRuleSet -ResourceGroupName $resourcegroup -Name $storageaccountname -DefaultAction Allow

# set parameters
$resourcegroup = "packtADE"
$location="eastus"
$vnetname = "packtVnet"
$storageaccountname = "packtadestorage"

# deny access to public networks
Update-AzStorageAccountNetworkRuleSet -ResourceGroupName $resourcegroup -Name packtadestorage -DefaultAction Deny


#create a new virtual network
New-AzVirtualNetwork -Name $vnetname -ResourceGroupName $resourcegroup -Location $location -AddressPrefix "10.1.0.0/16"

# get virtual network object
$vnet = Get-AzVirtualNetwork -Name $vnetname -ResourceGroupName $resourcegroup

# Create a new subnet in the virtual network
Add-AzVirtualNetworkSubnetConfig -Name default -VirtualNetwork $vnet -AddressPrefix "10.1.0.0/24" -ServiceEndpoint "Microsoft.Storage"

# apply subnet changes to the virtual network
$vnet | Set-AzVirtualNetwork


# get virtual network object
$vnet = Get-AzVirtualNetwork -Name $vnet -ResourceGroupName $resourcegroup
# get the subnet object
$subnet = Get-AzVirtualNetworkSubnetConfig -Name default -VirtualNetwork $vnet


# Allow access to the virtual network to the Azure storage
Add-AzStorageAccountNetworkRule -ResourceGroupName $resourcegroup -Name $storageaccountname -VirtualNetworkResourceId $subnet.Id

# list out all virtual network rules for an Azure Storage account
Get-AzStorageAccountNetworkRuleSet -ResourceGroupName $resourcegroup -Name $storageaccountname -VirtualNetworkResourceId $subnet.Id).VirtualNetworkRules

# remove the virtual network rule from the Azure Storage account
Remove-AzStorageAccountNetworkRule -ResourceGroupName $resourcegroup -Name $storageaccountname -VirtualNetworkResourceId $subnet.id

# remove the virtual network
Remove-AzVirtualNetwork -Name $vnetname $resourcegroup -Force

# allow access to all networks
Update-AzStorageAccountNetworkRuleSet -ResourceGroupName $resourcegroup -Name $storageaccountname -DefaultAction Allow



 Securing Azure Storage Account with Shared Access Signatures

# Set parameter values
$resourcegroup = "packtade"
$storageaccount = "packtadestorage"
$blobname = "logfile1.txt"
$containername = "logfiles"

# securing blobs with SAS

#get storage context
$storagecontext = (Get-AzStorageAccount -ResourceGroupName $resourcegroup -Name $storageaccount).Context

#set the token expiry time
$starttime = Get-Date
$endtime = $starttime.AddDays(1)

# get the SAS token into a variable
$sastoken = New-AzStorageBlobSASToken -Container "logfiles" -Blob "logfile1.txt" -Permission lr -StartTime $starttime -ExpiryTime $endtime -Context $storagecontext # view the SAS token.

$sastoken

#get storage account context using the SAS token
$ctx = New-AzStorageContext -StorageAccountName $storageaccount -SasToken $sastoken

#list the blob details

Get-AzStorageBlob -blob $blobname  -Container $containername -Context $ctx

# upload blob
$file = "C:\ADECookbook\Chapter1\Logfiles\Logfile1.txt"
# This will error out as the SAS token only has read access
Set-AzStorageBlobContent -File $file -Container $containername -Context $ctx


# Securing container with SAS   


#get storage context
$storagecontext = (Get-AzStorageAccount -ResourceGroupName $resourcegroup -Name $storageaccount).Context

# set the SAS expiry time
$starttime = Get-Date
$endtime = $starttime.AddDays(1)
# create container access policy
New-AzStorageContainerStoredAccessPolicy -Container $containername `
										 -Policy writepolicy `
										 -Permission lw `
										 -StartTime $starttime `
										 -ExpiryTime $endtime `
										 -Context $storagecontext


# get the SAS token
$sastoken = New-AzStorageContainerSASToken -Name $containername -Policy writepolicy -Context $storagecontext

#get the storage context with SAS token
$ctx = New-AzStorageContext -StorageAccountName $storageaccount -SasToken $sastoken



#list blobs using SAS token
Get-AzStorageBlob -Container logfiles -Context $ctx


