library(tidyr)
library(dplyr)
library(ggplot2)
library(GGally)

setwd("~/Uni/Master/6.Semester/AngewBioinf/Serien/S7")
train_data <- read.table("cells_train.tsv", sep="\t", header=FALSE)

# get overview on train data
print(summary(train_data))
dim_train <- print(dim(train_data))
cat("DataFrame dimensions:", dim_train)
n_samples <- dim_train[1]
cat("n_samples (cells):", n_samples)
# we have 379 cells in total

n_bad_tumor <- sum(train_data$V1==1)
cat("n_bad_tumor: (positive Class)", n_bad_tumor)
frac_bad_tumor <- n_bad_tumor/n_samples
cat("frac_bad_tumor:", frac_bad_tumor)
# classification problem is lightly unbalanced towards negative class

train_data <- as_tibble(train_data)
theme_set(theme_bw())

train_data_tidy <- train_data |> pivot_longer(cols=-V1, names_to="Feature", values_to="Value")
train_data_tidy <- train_data_tidy |> mutate(Class = factor(V1, levels = c(-1, 1)))
  
# Histograms over data in total and class total data specific                                           
ggplot(train_data_tidy, aes(x=Value)) + geom_histogram(bins=200) +
  labs(title = "Total Data Distribution")

ggplot(train_data_tidy, aes(x=Value)) + geom_histogram(bins=200) +
  facet_wrap(~Class)

# Violin Plot over classes  
ggplot(train_data_tidy, aes(x=Class, y=Value)) + 
  geom_violin(draw_quantiles=c(0.25,0.5,0.75))
# Both classes have left skewed pretty much unimodal distributions.
# They overlap each for a big part of their distributions.
# But bad tumor class is a lot less left skewed and has overall higher values.
# In the histograms of each class compared to each other we see that the counts
# for the good tumor class are a lot higher

train_data_tidy_bad_tumor <- train_data_tidy |> filter(Class == 1)
train_data_tidy_good_tumor <- train_data_tidy |> filter(Class == -1)

# Violin Plot for each of 30 features, first classes together, 
# then class specific
ggplot(train_data_tidy, aes(x=Feature, y=Value)) + 
  geom_violin(draw_quantiles=c(0.25,0.5,0.75)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
ggplot(train_data_tidy, aes(x=Feature, y=Value, fill = Class)) + 
  geom_violin(draw_quantiles=c(0.25,0.5,0.75)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
# For all features for both classes in total we see that 
# the distributions are all unimodal, 
# but there is significant variation
# between the maxima of the ranges of values and the quantiles of those
# although overlap is also common.

# If we also dissect the classes we see that the distributions for
# negative class is always below the distribution of the positive class for the Feature
# we saw this also in the plots for all the features together

train_data_pos <- train_data |> filter(V1==1)
train_data_neg <- train_data |> filter(V1==-1)
set.seed(1)
rand_cells_pos <- sample(1:nrow(train_data_pos), 9)
rand_cells_neg <- sample(1:nrow(train_data_neg), 9)
samp_train_data_pos <- train_data_pos[rand_cells_pos,]
samp_train_data_neg <- train_data_neg[rand_cells_neg,]

samp_train_data_pos <- samp_train_data_pos |> 
  mutate(Sample=paste("pos Sample",rand_cells_pos))
samp_train_data_neg <- samp_train_data_neg |> 
  mutate(Sample=paste("neg Sample",rand_cells_neg))

samp_train_data_pos_td <- samp_train_data_pos |>
  pivot_longer(cols=2:31, names_to = "Feature", values_to="Value")

ggplot(samp_train_data_pos_td, aes(x=Value)) + geom_histogram(bins=20) +
  xlim(0, 9) +
  facet_wrap(~Sample) +
  labs(title = "Feature Distribution for different bad tumor cells")

samp_train_data_neg_td <- samp_train_data_neg |>
  pivot_longer(cols=2:31, names_to = "Feature", values_to="Value")

ggplot(samp_train_data_neg_td, aes(x=Value)) + geom_histogram(bins=20) +
  xlim(0, 9) +
  facet_wrap(~Sample) +
  labs(title = "Feature Distribution for different good tumor cells")

# Distributions of the 30 features for different sampled cells for positive 
# negative class are distribute mainly over the same value ranges.
# But there are also significant differences between the distributions,
# thats not so special because there are only 30 features.


n_cat_samps <- 7
samp_cat <- sample(2:31, n_cat_samps)

train_data <- train_data |> 
  mutate(Color=if_else(V1==1,"red","green"))

ggpairs(train_data, columns=samp_cat, aes(color=as.factor(V1), alpha=0.5),
  lower= list(continuous = wrap("points", size=0.4)),
  upper = list(continuous = wrap("cor", size = 2.5)),
  title = paste("Feature correlation accross cells for 7 sampled cateogries\n",
                     "1=red: bad tumor, -1=green: good tumor")) +
  scale_color_manual(values = c("-1" = "green", "1" = "red"))

# We sample different features and compare the correlation accross cells.
# We see, that the correlation between features is in the range from zero to positive 
# and varies accross that range.
# We again see in the density plots 
# that the values for bad tumor are generally higher.