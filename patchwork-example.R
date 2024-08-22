library(tidyverse)
library(patchwork)
library(here)

lizards <- read_csv(here("data_tidy", "lizards.csv"))


two_lizards <- lizards %>%
  filter(common_name %in% c("eastern fence", "western whiptail"))

p1 <- ggplot(data = two_lizards, aes(x = total_length, y = weight)) + geom_point(aes(colour = common_name)) + 
  scale_color_manual(values = c("orange", "navy"),
                     name = "Lizard Species:",
                     labels = c("Eastern fence lizard",
                                "Western Whiptail lizard")) +
  theme_minimal() +
  theme(legend.position = c(0.2, 0.8),
        legend.background = element_blank()) +
  labs(x = "total length (mm)",
       y = "weight (g)")


# make another plot

p2 <- ggplot(data = lizards, aes(x = weight, y = site)) + geom_boxplot() +
  labs(x = "Weight (g)",
       y = "Site")



p3 <- ggplot(data = lizards, aes(x = weight)) + geom_histogram() +
  labs(x = "weight (g)",
       y = "counts (n)")

p4 <- (p1 / p2 / p3) & theme_minimal()
ggsave("patchwork-ex.png", p4)

