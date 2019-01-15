# Databricks notebook source
# MAGIC %md The notebook below takes input parameters for the test data, and another parameter which specified where the scored file should be saved to (in dbfs). 
# MAGIC * Test values: [Parameter Name] : [Parameter Value]
# MAGIC * input_data_path: /dbfs/mnt/r_model/inputfile/test/r_input_file1.csv
# MAGIC * outputdata_path: /dbfs/mnt/r_model/outputfile/r_output_file1.csv

# COMMAND ----------

# Get Input Parameters

# Scoring Data Input
dbutils.widgets.text("inputdata_path", "","")
dbutils.widgets.get("inputdata_path")
inputdata_path = getArgument("inputdata_path")

# Scored File Output
dbutils.widgets.text("outputdata_path", "","")
dbutils.widgets.get("outputdata_path")
outputdata_path = getArgument("outputdata_path")

print(c(inputdata_path, outputdata_path))

# COMMAND ----------

# Load Input Data
print(inputdata_path)
data <- read.csv(inputdata_path, header=TRUE)
print(data)

# COMMAND ----------

# Load the Model from Blob Storage
inputmodel_path = "/dbfs/mnt/r_model/model/model.rds"
model <- readRDS(inputmodel_path)
print(model)

# COMMAND ----------

# Perform Scoring
x <- data.frame(x = data$height)
y <-  predict(model,x) 
data$weight <- y
print(data)

# COMMAND ----------

# Save output to location
write.csv(data, file=outputdata_path, row.names=F)

# COMMAND ----------

# MAGIC %md Make sure the output file written out.

# COMMAND ----------

# MAGIC %fs
# MAGIC ls "/mnt/r_model/outputfile"