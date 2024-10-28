Univeral SEP policy builder ... 
Copy and paste the following Az CLI bash script to a local file. I use adb-sep.sh for my filename. 
Open your azure portal cloud shell and select bash (not power shell). 

Upload the file (adb-sep.sh) to your cloud shell storage (using manage files drop down).
Gather the region, resource group and subscription id for where this Service Endpoint Policy will be placed in your Azure environment. 
Run the script. It takes as parameters : region, subscription id and resource group. 
Option : If you choose to run this script from your desktop you will need to supply -x to login to Azure.  
Example: 

The script will create a regional policy called databricks-sep-<region> in the subscription and resource group you specify. If the policy exists it will be overwritten.  In my example I have chosen westus as my region so a policy called databricks-sep-westus was created. 
Attach the policy to the Databricks workspace public subnet : 
Open your workspace vnet in the azure portal. 
Click on the public subnet to edit
