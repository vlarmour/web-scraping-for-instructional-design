library(tidyverse)
library(xml2)
library(rvest)

#titles only all 22 pages
sci_course_titles <- lapply(paste0('https://comminfo.rutgers.edu/academics/courses?courses=&program=All&page=', 0:22),
                            function(url){
                              url %>% read_html() %>% 
                                html_nodes(".panel-title a") %>% 
                                html_text()
                            })

#title, course number, description all 22 pages
sci_courses <- lapply(paste0('https://comminfo.rutgers.edu/academics/courses?courses=&program=All&page=', 0:22),
                      function(url){
                        url %>% read_html() %>%
                          html_nodes(".panel-heading span, #course-num span, .panel-body") %>%
                          html_text()
                      })

## renaming columns with generic names

names(sci_courses) <- c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w")

## this identifies problematic columns
sci_courses <- as.tibble(sci_courses)

## removing problematic columns

sci_courses$u <- NULL
sci_courses$v <- NULL
sci_courses$w <- NULL

## now tibble will work
sci_courses <- as.tibble(sci_courses)

## export 
write_csv(sci_courses, "your_file_path_here")
