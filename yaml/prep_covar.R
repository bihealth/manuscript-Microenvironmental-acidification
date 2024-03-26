library(tidyverse)

covar <- read.table("covariate_file.txt_orig", header=TRUE) %>% 
  select(-label) %>%
  rename("label"="group") %>%
  mutate(batch=ifelse(grepl("^P3179", label), "B2", "B1")) %>%
  mutate(label = gsub("^P3179_[^_]*_", "", label)) %>%
  #mutate(replicate=paste0("R", gsub(".*-([0-9])$", "\\1", label))) %>%
  mutate(hepes=ifelse(grepl("HEPES", label), "HEPES", "no_HEPES")) %>%
  mutate(group = "Ctr") %>%
  mutate(group = ifelse(grepl("S_?p[_-]D39", label), "Sp_D39", group)) %>%
  mutate(group = ifelse(grepl("pH-?6", label), "pH_6", group)) %>%
  mutate(group2=gsub("^(Ctr|pH-6|Sp-D39).*", "\\1", label)) %>%
  mutate(group2=gsub("-", "_", group2)) %>%
  mutate(g.h=paste0(group, '.', hepes)) %>%
  mutate(g.h.b=paste0(group, '.', hepes, '.', batch))

write.table(covar, file="covariate_file.txt")
