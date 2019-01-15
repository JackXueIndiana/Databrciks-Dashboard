# Databricks notebook source
# Updated to get credential directly 
configs1 = {"dfs.adls.oauth2.access.token.provider.type": "ClientCredential",
           "dfs.adls.oauth2.client.id": "354d9d70-4993-4be6-aef0-8fae7dbf700a",
           "dfs.adls.oauth2.credential": "P/OdSr+KRP0DeYTm6Dr5B12HQRnxT/dbR6NX7zPmQ1g=",
           "dfs.adls.oauth2.refresh.url": "https://login.microsoftonline.com/72f988bf-86f1-41af-91ab-2d7cd011db47/oauth2/token"}

# Optionally, you can add <your-directory-name> to the source URI of your mount point.
dbutils.fs.mount(
  source = "adl://jackadlsg1.azuredatalakestore.net/rmodel",
  mount_point = "/mnt/r_model/",
  extra_configs = configs1)

# COMMAND ----------

# MAGIC %fs
# MAGIC ls "/mnt/r_model/inputfile/train"