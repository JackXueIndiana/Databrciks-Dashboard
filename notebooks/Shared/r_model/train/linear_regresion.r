# Databricks notebook source
print(R.version.string)

# COMMAND ----------

# MAGIC %fs
# MAGIC ls "/mnt/r_model/inputfile/train"

# COMMAND ----------

# Load Training Data
routes<-read.csv("/dbfs/mnt/r_model/inputfile/train/weight_data.csv", header=TRUE)

# The predictor vector (height).
x <- routes$height
# The response vector (weight).
y <- routes$weight
# Apply the lm() function.
model <- lm(y~x)

# COMMAND ----------

# MAGIC %md Show the input data

# COMMAND ----------

routes

# COMMAND ----------

# Make Predictions
df_test_heights <- data.frame(x = as.numeric(c(70,80)))
result <-  predict(model,df_test_heights)
print(result)

# COMMAND ----------

# Save the model to blob storage
saveRDS(model, "/dbfs/mnt/r_model/model/model.rds")

# COMMAND ----------

# MAGIC %md Verify if the model saved.

# COMMAND ----------

# MAGIC %fs
# MAGIC ls "/mnt/r_model/model"

# COMMAND ----------

# Show the model
print(model)