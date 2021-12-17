install.packages("palmerpenguins")
library(palmerpenguins)
summary(penguins)
ggplot(data = penguins, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point(aes(color = species, shape = species))

file.copy ("Vector-and-lists-in-R.pdf", "~/Desktop")
file.create ("new_csv_file.csv")
file.copy ("new_csv_file.csv" , "/Users/admin/Desktop")

unlink("new_csv_file.csv")


(54.9+75.77+75.27+80.09+81.07+74.93+65.09+75.68+77.5*4)/12


### Connect to MySQL

# install.packages("RMySQL")
# library(RMySQL)


mydb = dbConnect(MySQL(), user='root', password='???', db = "sql_store")
dbListTables(mydb)
dbListFields(mydb, "customers")
rs <- dbSendQuery(mydb, 'SELECT * FROM customers')
data = fetch(rs, n=-1)
