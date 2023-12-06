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


