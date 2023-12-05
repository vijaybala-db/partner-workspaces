-- Databricks notebook source
-- MAGIC %md
-- MAGIC ### Active Sandboxes

-- COMMAND ----------

SELECT * FROM users.vijay_balasubramaniam.sandbox_workspaces
WHERE sandbox_name LIKE '%Deloitte%' AND workspace_status <> 'CANCELLED';

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


