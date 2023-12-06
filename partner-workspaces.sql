-- Databricks notebook source
-- MAGIC %md
-- MAGIC ### Active Sandboxes

-- COMMAND ----------

SELECT * FROM users.vijay_balasubramaniam.sandbox_workspaces
WHERE sandbox_name LIKE '%Deloitte%' AND workspace_status <> 'CANCELLED';

-- COMMAND ----------

SELECT * FROM users.vijay_balasubramaniam.sandbox_workspaces
WHERE account_id = 'cf1714e4-c910-4c9a-9357-6606b25a8174' -- LTI Mindtree
 AND workspace_status <> 'CANCELLED';

-- COMMAND ----------

SELECT * FROM users.vijay_balasubramaniam.sandbox_workspaces
WHERE account_id = 'd26e8185-631a-4b06-b164-7661c6bf7c6f' -- Deloitte
 AND workspace_status <> 'CANCELLED';
 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Running Workspaces belonging to partner

-- COMMAND ----------

SELECT * FROM main.certified.workspaces_latest
WHERE workspace_aggregation_name LIKE '%Deloitte%'
AND workspace_status = 'RUNNING';

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Client Workspaces where Partner is Consumption Partner

-- COMMAND ----------

SELECT * FROM main.sfdc_bronze.account_partner__c
WHERE Partner_Account__c = '00161000005eOe6AAE'  -- Deloitte Consulting (HQ)
AND Consumption_Split_Percentage__c IS NOT NULL
AND Consumption_Split_Percentage__c > 0;

-- COMMAND ----------

SELECT * FROM main.sfdc_bronze.account WHERE Id='00161000005eOe6AAE'  -- Deloitte Consulting (HQ)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Partner Accounts

-- COMMAND ----------

-- Limit to Max processDate to avoid duplicate rows
SELECT * FROM main.sfdc_bronze.account_partner__c ap WHERE ap.processDate = (SELECT MAX(processDate) FROM main.sfdc_bronze.account_partner__c);

-- COMMAND ----------

CREATE OR REPLACE TABLE users.vijay_balasubramaniam.partner_accounts AS 
  SELECT DISTINCT
  ap.Name, ap.PartnerAccount_Manager__c, ap.Partner_Account__c, a.Name AS Partner_Account_Name,
  ap.PartnerSales_Manager__c, ap.Account__c AS Customer_Account, ap.Customer_Account_Name__c, ap.Consumption_Split_Percentage__c, 
  ap.Partner_Engagement_Stage__c, ap.Databricks_BD_Owner_Name__c
  FROM main.sfdc_bronze.account_partner__c ap
  LEFT OUTER JOIN main.sfdc_bronze.account a ON ap.Partner_Account__c = a.Id
  WHERE ap.Consumption_Split_Percentage__c IS NOT NULL
  AND ap.Consumption_Split_Percentage__c > 0
  AND NOT ap.isDeleted
  AND ap.processDate = (SELECT MAX(processDate) FROM main.sfdc_bronze.account_partner__c);

-- COMMAND ----------

-- SELECT regexp_extract(col1, '<a href="/(.*?)"')
-- FROM VALUES ('<a href="/0016100000WTJLX" target="_top">Caserta</a>')

-- COMMAND ----------

SELECT * FROM users.vijay_balasubramaniam.partner_accounts;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Find all customer workspaces linked to partner accounts

-- COMMAND ----------

SELECT pa.*, w.*
FROM users.vijay_balasubramaniam.partner_accounts pa
LEFT OUTER JOIN main.certified.workspaces_latest w ON pa.Customer_Account = w.workspace_aggregation_id
WHERE pa.Partner_Account_Name LIKE '%Deloitte%';

-- COMMAND ----------


