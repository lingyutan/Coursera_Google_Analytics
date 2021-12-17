library(ggplot2)
library(palmerpenguins)
library(tidyverse)

data(penguins)
View(penguins)

ggplot(data = penguins) +
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g))

ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(na.rm = T)

penguins %>%
  drop_na() %>%
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) + 
  geom_point()

ggplot(data = penguins) +
  geom_point(mapping = aes(x = bill_length_mm, y = bill_depth_mm))

### Changing aes

### Colour by Species
ggplot(data = penguins) +
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, colour = species))

### Shape by Species
ggplot(data = penguins) +
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, shape = species))

### Colour & Shape
ggplot(data = penguins) +
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species, shape = species, size = species))

### Alpha
ggplot(data = penguins) +
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, alpha = species))

### Overall Colour
ggplot(data = penguins) +
  geom_point(mapping = aes(x = bill_length_mm, y = bill_depth_mm), color = "purple")

### Change colour
ggplot(data = penguins) +
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, colour = species)) +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))




### Changing geom
ggplot(data = penguins) +
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g))

ggplot(data = penguins) +
  geom_smooth(mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g))

ggplot(data = penguins, aes(x = flipper_length_mm, y = body_mass_g))+ 
  geom_point() +       
  geom_smooth(method="loess")

ggplot(data = penguins, aes(x = flipper_length_mm, y = body_mass_g))+ 
  geom_point() +       
  geom_smooth(method="gam", formula = y ~s(x))


ggplot(data = penguins) +
  geom_smooth(mapping = aes(x = flipper_length_mm, y = body_mass_g, linetype = species))

ggplot(data = penguins) +
  geom_jitter(mapping = aes(x = flipper_length_mm, y = body_mass_g))


### geom_bar using dataset diamonds
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, color = cut))

diamonds %>%
  group_by(cut) %>%
  summarise(cut_count = n(), col = ifelse(cut_count<10000, 'red', 'blue')) %>%
  ggplot() +
  geom_col(mapping = aes(x = cut, y = cut_count, fill = col)) +
  scale_fill_manual( values = c( "red"="red", "blue"="blue"))

ggplot(diamonds) +
  geom_bar(mapping = aes(x = cut, fill = ifelse(x < 10000, 'red', 'blue')))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))


### facet
ggplot(penguins) +
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  facet_wrap(~species)

ggplot(diamonds) + 
  geom_bar(mapping = aes(x = color, fill = cut)) +
  facet_wrap(~cut)

ggplot(penguins) +
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  facet_grid(sex~species)

ggplot(penguins) +
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  facet_grid(~species)

ggplot(penguins) +
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  facet_grid(~sex)

penguins %>% na.omit() %>% ggplot() +
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  facet_grid(sex~species)


### Anotations

ggplot(penguins) +
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  labs(title = "Plamer Penguins: Body Mass vs. Flipper Length", 
       subtitle = "Sample of Three Penguins Species",
       caption = "Data collected by Dr. Kristen Gorman") +
  annotate("text", x=219, y=3500, label = "The Gentoos are the largest",
           color = "purple", fontface = "bold", size = 4.5, angle = 25)

### ggsave
ggsave("Three_Penguins_Species.png")


### graphics device

png(file = "exampleplot.png", bg = "transparent")
plot(1:10)
rect(1, 5, 3, 7, col = "white")
dev.off()


pdf(file = "example.pdf",    
    width = 4,     
    height = 4) 
plot(x = 1:10,     
     y = 1:10)
abline(v = 0)
text(x = 0, y = 1, labels = "Random text")
dev.off()






