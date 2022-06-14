day_modif <- as.numeric(train_order$date_end - train_order$date_modif_prod)
day_renewal <- as.numeric(train_order$date_end - train_order$date_renewal)

new.df <- data.frame(day, day_modif, day_renewal)
data_combo <- cbind(train_order, new.df)