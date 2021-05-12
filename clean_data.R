# Clean up data associated with the NIJ's Recidivism Challenge. Need to simplify
# for classroom use.

library(tidyverse)
library(janitor)

x <- read_csv("raw_data/NIJ_s_Recidivism_Challenge_Training_Dataset.csv",
              col_types = cols(ID = col_integer(),
                               Gender = col_character(),
                               Race = col_character(),
                               Age_at_Release = col_character(),
                               Residence_PUMA = col_character(),
                               Gang_Affiliated = col_logical(),
                               Supervision_Risk_Score_First = col_integer(),
                               Supervision_Level_First = col_character(),
                               Education_Level = col_character(),
                               Dependents = col_character(),
                               Prison_Offense = col_character(),
                               Prison_Years = col_character(),
                               Prior_Arrest_Episodes_Felony = col_character(),
                               Prior_Arrest_Episodes_Misd = col_character(),
                               Prior_Arrest_Episodes_Violent = col_character(),
                               Prior_Arrest_Episodes_Property = col_character(),
                               Prior_Arrest_Episodes_Drug = col_character(),
                               `_v1` = col_character(),
                               Prior_Arrest_Episodes_DVCharges = col_logical(),
                               Prior_Arrest_Episodes_GunCharges = col_logical(),
                               Prior_Conviction_Episodes_Felony = col_character(),
                               Prior_Conviction_Episodes_Misd = col_character(),
                               Prior_Conviction_Episodes_Viol = col_logical(),
                               Prior_Conviction_Episodes_Prop = col_character(),
                               Prior_Conviction_Episodes_Drug = col_character(),
                               `_v2` = col_logical(),
                               `_v3` = col_logical(),
                               `_v4` = col_logical(),
                               Prior_Revocations_Parole = col_logical(),
                               Prior_Revocations_Probation = col_logical(),
                               Condition_MH_SA = col_logical(),
                               Condition_Cog_Ed = col_logical(),
                               Condition_Other = col_logical(),
                               Violations_ElectronicMonitoring = col_logical(),
                               Violations_Instruction = col_logical(),
                               Violations_FailToReport = col_logical(),
                               Violations_MoveWithoutPermission = col_logical(),
                               Delinquency_Reports = col_character(),
                               Program_Attendances = col_character(),
                               Program_UnexcusedAbsences = col_character(),
                               Residence_Changes = col_character(),
                               Avg_Days_per_DrugTest = col_double(),
                               DrugTests_THC_Positive = col_double(),
                               DrugTests_Cocaine_Positive = col_double(),
                               DrugTests_Meth_Positive = col_double(),
                               DrugTests_Other_Positive = col_double(),
                               Percent_Days_Employed = col_double(),
                               Jobs_Per_Year = col_double(),
                               Employment_Exempt = col_logical(),
                               Recidivism_Within_3years = col_logical(),
                               Recidivism_Arrest_Year1 = col_logical(),
                               Recidivism_Arrest_Year2 = col_logical(),
                               Recidivism_Arrest_Year3 = col_logical())) %>% 
  clean_names() %>% 
  rename(age = age_at_release,
         sup_score = supervision_risk_score_first) %>% 
  mutate(race = parse_factor(race)) %>% 
  mutate(gender = parse_factor(gender)) %>% 
  mutate(age = parse_factor(age, 
                            levels = c("18-22", "23-27", "28-32",
                                       "33-37", "38-42", "43-47",
                                       "48 or older"))) %>% 
  mutate(age = fct_recode(age, "48+" = "48 or older")) %>% 
  mutate(recidivist = ifelse(recidivism_within_3years, 1, 0)) %>% 
  select(id, recidivist, gender, age, race, sup_score)


