chocolate_df <-read_csv("flavors_of_cacao.csv")

flavors_df <- clean_names(chocolate_df)

colnames(chocolate_df)[1]

flavors_df %>%
  rename(Brand = colnames(chocolate_df)[1])

trimmed_flavors_df <- flavors_df %>%
  select(rating, cocoa_percent, bean_type)

trimmed_flavors_df %>%
  summarise(Rating_mean = mean(rating))

best_trimmed_flavors_df <- trimmed_flavors_df %>% 
  mutate(cocoa_percent2 = as.numeric(sub("%", "", cocoa_percent)) / 100) %>%
  filter(cocoa_percent2 >= 0.8 & rating >= 3.75)
  