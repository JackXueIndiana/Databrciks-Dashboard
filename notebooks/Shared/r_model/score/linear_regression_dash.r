# Databricks notebook source
library(SparkR)

# Clean up for the next run
dbutils.widgets.removeAll()

# Scoring Data Input
dbutils.widgets.text("Height", "","")
Height <- dbutils.widgets.get("Height")

# Load the Model from Blob Storage
inputmodel_path <- "/dbfs/mnt/r_model/model/model.rds"
model <- readRDS(inputmodel_path)

# Make a prediction
h <- 60
if (as.numeric(Height) < 60)
{
  h <- 60
} else if (as.numeric(Height) > 80)
{
  h <- 80
} else
{
  h <- as.numeric(Height)
}
  

prediction <- data.frame(height = c(h), weight = c(0))
x <- data.frame(x = prediction$height)
print(x)
y <- predict(model, x)
print(y)
prediction$weight <- y
print(prediction)

#Display prediction
display(prediction)

# COMMAND ----------

# Load Training Data
routes<-read.csv("/dbfs/mnt/r_model/inputfile/train/weight_data.csv", header=TRUE)

plot(routes)
points(prediction,col="red", add=TRUE)