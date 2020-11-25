### PH250B ~ Week 11, Topic 1. Problem set, Problem 2

# step 1: put the numbers together. 
?matrix 

youngr_strata <-
  matrix(c(20, 60, 6, 36), nrow = 2, byrow = T, 
         dimnames = list(c("Exposed", "Unexposed"),
                         c("Preterm", "Term")))
# View output
youngr_strata
View(youngr_strata)

oldr_strata <- 
  matrix(c(30, 40, 4, 54), nrow = 2, byrow = T, 
         dimnames = list(c("Exposed", "Unexposed"),
                         c("Preterm", "Term")))
# View output
oldr_strata
View(oldr_strata)

# a) The  PI  asks  you  to  calculate  and  interpret  the  appropriate  crude  relative  measure  of association. 

# Add values cell-wise from the stratfied tables. 
crude_table <- oldr_strata + youngr_strata

# View output.
crude_table
View(crude_table)

# Calculate crude OR as "a*d / b*c" from crude_table.
crude_or = (a * d) / (b * c)

# "The odds of preterm delivery are 
# among women exposed to chemical 
# compared with those who were not.
crude_or 

## b) The PI asks you to calculate and interpret the Mantel-Haenszel adjusted odds ratio. 

# Sum the total population from table values. 
youngr_pop <- sum(20, 60, 6, 36)
oldr_pop <-  sum(30, 40, 4, 54)

# MH_OR = Σ(ad/Ti) / Σ(bc/Ti)
mh_adj_or <- ((( "a * d" ) / youngr_pop) + (("a * d") / oldr_pop)) / #divided by
  ((("b * c") / youngr_pop) + (("b * c") / oldr_pop))

mh_adj_or

# Round the output 3 places. 
round((mh_adj_or), 3)

## c) You decide to also calculate and interpret the age-stratified measures of associations

# Age Stratafied Measures of association. 
youngr_or <- ("a * d" / ("b * c")
youngr_or

oldr_or <- ("a * d" / ("b * c")
oldr_or  

# Among women ages 20-30 (younger), women exposed to the chemical have ??? times greater odds of preterm delivery than women not exposed.

# Among women ages 30-40 (older), women exposed to the chemical have ??? times greater odds of preterm delivery than women not exposed.


## d) Do you think that the PI should present the adjusted measure of association?  Explain your answer in one sentence. 
# Is effect measure modification present? Are the stratafied ORs equivalent? 
youngr_or == oldr_or

## e)  Answer the following questions:

# i.	Calculate the Χ2  test of homogeneity. 
### Chi-square test for homogeneity = Σ Wi(lnORi - lnOR)^2 ###

# calculate weights
weight_1 <- (1/"a" + 1/"b" + 1/"c" + 1/"d")^-1
weight_2 <- (1/"a" + 1/"b" + 1/"c" + 1/"d")^-1


# calculate the chi-square statistic. 
chi_squared_hom <- weight_1 * (log(youngr_or) - log(mh_adj_or))^2 + 
  weight_2 * (log(oldr_or) - log(mh_adj_or))^2

# round for legibility
round((chi_squared_hom), 3)

            
?dchisq
# obtain p-value.
pval <- dchisq(4.5, df = 1)
pval


## ii. The p-value for the χ2  test, if you calculated it correctly, would be <0.05. State the null hypothesis for this test, and interpret your finding in relation to this null hypothesis

# We reject the null hypothesis that the individual stratified measures of association and the adjusted measure (ORMH) are homogenous. In so doing, we fail to reject the alternative: Age is an effect measure modifier, i.e. the association between the chemical and preterm delivery differs by age category.

## f) How would you interpret your analysis results in  with respect to what the associations reveal about interacting causal types? Assume that your results are unbiased..

# Even if results are unbiased, we cannot make statements about interaction as a causal concept based on multiplicative interaction – thus this is effect modification only (measure of association modification) We could not say maternal exposure to this chemical during pregnancy *caused* preterm delivery just from the results of this test. 

## g)  Before the investigator started the study, what three criteria should they have considered to assess whether age is a confounder?
            
#Think to the confounder criteria from our lectures with DAG models:

  #1. Age must cause preterm delivery in the source population
  #2. Age must be associated with the exposure in the source population
  #3. Age must not be caused by exposure or disease


#~fin














