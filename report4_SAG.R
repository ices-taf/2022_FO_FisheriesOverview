
library(icesTAF)
library(icesFO)
library(sf)
library(ggplot2)
library(dplyr)


##########
#Load data
##########

trends <- read.taf("model/trends.csv")
catch_current <- read.taf("model/catch_current.csv")
catch_trends <- read.taf("model/catch_trends.csv")

clean_status <- read.taf("data/clean_status.csv")

#set year and month for captions:
cap_month = "January"
cap_year <- 2023
# set year for plot claculations
year_cap = "2023"
year = 2023
ecoreg = "FO"

#~~~~~~~~~~~~~~~#
# A. Trends by guild
#~~~~~~~~~~~~~~~#
unique(trends$FisheriesGuild)

# 1. Demersal
#~~~~~~~~~~~
plot_stock_trends(trends, guild="demersal", cap_year, cap_month , return_data = FALSE)
ggplot2::ggsave(paste0(year_cap, "_", ecoreg,"_FO_SAG_Trends_demersal.png"), path = "report/", width = 178, height = 130, units = "mm", dpi = 300)

dat <- plot_stock_trends(trends, guild="demersal", cap_year , cap_month, return_data = TRUE)
write.taf(dat, file =paste0(year_cap, "_", ecoreg, "_FO_SAG_Trends_demersal.csv"), dir = "report")

# 2. Pelagic
#~~~~~~~~~~~
plot_stock_trends(trends, guild="pelagic", cap_year, cap_month , return_data = FALSE)
ggplot2::ggsave(paste0(year_cap, "_", ecoreg, "_FO_SAG_Trends_pelagic.png"), path = "report/", width = 178, height = 130, units = "mm", dpi = 300)

dat <- plot_stock_trends(trends, guild="pelagic", cap_year, cap_month, return_data = TRUE)
write.taf(dat,file =paste0(year_cap, "_", ecoreg, "_FO_SAG_Trends_pelagic.csv"), dir = "report")

# 3. Elasmobranch
#~~~~~~~~~~~
# plot_stock_trends(trends, guild="elasmobranch", cap_year, cap_month ,return_data = FALSE )
# ggplot2::ggsave(paste0(year_cap, "_", ecoreg, "_FO_SAG_Trends_elasmobranch.png"), path = "report/", width = 178, height = 130, units = "mm", dpi = 300)
# 
# dat <- plot_stock_trends(trends, guild="elasmobranch", cap_year , cap_month , return_data = TRUE)
# write.taf(dat, file =paste0(year_cap, "_", ecoreg, "_FO_SAG_Trends_elasmobranch.csv"), dir = "report" )

# 4. Crustacean
#~~~~~~~~~~~
# plot_stock_trends(trends, guild="crustacean", cap_year, cap_month ,return_data = FALSE )
# ggplot2::ggsave(paste0(year_cap, "_", ecoreg, "_FO_SAG_Trends_crustacean.png"), path = "report/", width = 178, height = 130, units = "mm", dpi = 300)
# 
# dat <- plot_stock_trends(trends, guild="crustacean", cap_year , cap_month , return_data = TRUE)
# write.taf(dat, file =paste0(year_cap, "_", ecoreg, "_FO_SAG_Trends_crustacean.csv"), dir = "report" )


#~~~~~~~~~~~~~~~~~~~~~~~~~#
# Ecosystem Overviews plot
#~~~~~~~~~~~~~~~~~~~~~~~~~#
# guild <- read.taf("model/guild.csv")
# 
# # For this EO, they need separate plots with all info
# 
# guild2 <- guild %>% filter(Metric == "F_FMSY")
# plot_guild_trends(guild, cap_year = 2019, cap_month = "October",return_data = FALSE )
# ggplot2::ggsave("2019_BtS_EO_GuildTrends.png", path = "report/", width = 178, height = 130, units = "mm", dpi = 300)
# guild2 <- guild2 %>% filter(FisheriesGuild != "MEAN")
# plot_guild_trends(guild2, cap_year = 2019, cap_month = "November",return_data = FALSE )
# ggplot2::ggsave("2019_BtS_EO_GuildTrends_noMEAN_F.png", path = "report/", width = 178, height = 130, units = "mm", dpi = 300)
# 
# guild2 <- guild %>% filter(Metric == "SSB_MSYBtrigger")
# guild3 <- guild2 %>% dplyr::filter(FisheriesGuild != "MEAN")
# plot_guild_trends(guild3, cap_year = 2019, cap_month = "November",return_data = FALSE )
# ggplot2::ggsave("2019_BtS_EO_GuildTrends_short_noMEAN_SSB.png", path = "report/", width = 178, height = 130, units = "mm", dpi = 300)
# 
# 
# dat <- plot_guild_trends(guild, cap_year = 2019, cap_month = "October",return_data = TRUE)
# write.taf(dat, file ="2019_BtS_EO_GuildTrends.csv", dir = "report", quote = TRUE)
# 
# dat <- trends[,1:2]
# dat <- unique(dat)
# dat <- dat %>% filter(StockKeyLabel != "MEAN")
# dat2 <- sid %>% select(c(StockKeyLabel, StockKeyDescription))
# dat <- left_join(dat,dat2)
# write.taf(dat, file ="2019_BtS_EO_SpeciesGuild_list.csv", dir = "report", quote = TRUE)

#~~~~~~~~~~~~~~~#
# B.Current catches
#~~~~~~~~~~~~~~~#

# 1. Demersal
#~~~~~~~~~~~
bar <- plot_CLD_bar(catch_current, guild = "demersal", caption = TRUE, cap_year, cap_month, return_data = FALSE)

bar_dat <- plot_CLD_bar(catch_current, guild = "demersal", caption = TRUE, cap_year , cap_month , return_data = TRUE)
write.taf(bar_dat, file =paste0(year_cap, "_", ecoreg, "_FO_SAG_Current_demersal.csv"), dir = "report" )

kobe <- plot_kobe(catch_current, guild = "demersal", caption = TRUE, cap_year , cap_month , return_data = FALSE)
#kobe_dat is just like bar_dat with one less variable
#kobe_dat <- plot_kobe(catch_current, guild = "Demersal", caption = T, cap_year , cap_month , return_data = TRUE)

#Check this file name
png(sprintf("report/%s_FO_FO_SAG_Current_demersal.png", year),
    width = 131.32,
    height = 88.9,
    units = "mm",
    res = 300)
p1_plot<-gridExtra::grid.arrange(kobe,
                                 bar, ncol = 2,
                                 respect = TRUE, top = "demersal")
dev.off()

# 2. Pelagic
#~~~~~~~~~~~
bar <- plot_CLD_bar(catch_current, guild = "pelagic", caption = TRUE, cap_year, cap_month , return_data = FALSE)

bar_dat <- plot_CLD_bar(catch_current, guild = "pelagic", caption = TRUE, cap_year , cap_month , return_data = TRUE)
write.taf(bar_dat, file =paste0(year_cap, "_", ecoreg, "_FO_SAG_Current_pelagic.csv"), dir = "report")

catch_current <- unique(catch_current)
kobe <- plot_kobe(catch_current, guild = "pelagic", caption = TRUE, cap_year , cap_month , return_data = FALSE)
#check this file name
png(sprintf("report/%s_FO_FO_SAG_Current_pelagic.png", year),
    width = 131.32,
    height = 88.9,
    units = "mm",
    res = 300)
p1_plot<-gridExtra::grid.arrange(kobe,
                                 bar, ncol = 2,
                                 respect = TRUE, top = "pelagic")
dev.off()


# 3. Benthic
#~~~~~~~~~~~
# catch_current$Status[which(catch_current$StockKeyLabel == "sol.27.20-24")] <- "GREEN"

# bar <- plot_CLD_bar(catch_current, guild = "benthic", caption = TRUE, cap_year , cap_month , return_data = FALSE)
# 
# bar_dat <- plot_CLD_bar(catch_current, guild = "benthic", caption = TRUE, cap_year , cap_month , return_data = TRUE)
# write.taf(bar_dat, file =paste0(year_cap, "_", ecoreg, "_FO_SAG_Current_benthic.csv"), dir = "report" )
# 
# kobe <- plot_kobe(catch_current, guild = "benthic", caption = TRUE, cap_year , cap_month , return_data = FALSE)
# #check this file name
# png(sprintf("report/%s_FO_FO_SAG_Current_benthic.png", year),
#     width = 131.32,
#     height = 88.9,
#     units = "mm",
#     res = 300)
# p1_plot<-gridExtra::grid.arrange(kobe,
#                                  bar, ncol = 2,
#                                  respect = TRUE, top = "benthic")
# dev.off()

# 4. Elasmobranch
#~~~~~~~~~~~
# catch_current$Status[which(catch_current$StockKeyLabel == "sol.27.20-24")] <- "GREEN"

# bar <- plot_CLD_bar(catch_current, guild = "elasmobranch", caption = TRUE, cap_year , cap_month , return_data = FALSE)
# 
# bar_dat <- plot_CLD_bar(catch_current, guild = "elasmobranch", caption = TRUE, cap_year , cap_month , return_data = TRUE)
# write.taf(bar_dat, file =paste0(year_cap, "_", ecoreg, "_FO_SAG_Current_elasmobranch.csv"), dir = "report" )
# 
# kobe <- plot_kobe(catch_current, guild = "elasmobranch", caption = TRUE, cap_year , cap_month , return_data = FALSE)
# #check this file name
# png(sprintf("report/%s_FO_FO_SAG_Current_elasmobranch.png", year),
#     width = 131.32,
#     height = 88.9,
#     units = "mm",
#     res = 300)
# p1_plot<-gridExtra::grid.arrange(kobe,
#                                  bar, ncol = 2,
#                                  respect = TRUE, top = "benthic")
# dev.off()

# 5. Crustacean
#~~~~~~~~~~~
# catch_current$Status[which(catch_current$StockKeyLabel == "sol.27.20-24")] <- "GREEN"

# bar <- plot_CLD_bar(catch_current, guild = "crustacean", caption = TRUE, cap_year , cap_month , return_data = FALSE)
# 
# bar_dat <- plot_CLD_bar(catch_current, guild = "crustacean", caption = TRUE, cap_year , cap_month , return_data = TRUE)
# write.taf(bar_dat, file =paste0(year_cap, "_", ecoreg, "_FO_SAG_Current_crustacean.csv"), dir = "report" )
# 
# kobe <- plot_kobe(catch_current, guild = "crustacean", caption = TRUE, cap_year , cap_month , return_data = FALSE)
# #check this file name
# png(sprintf("report/%s_FO_FO_SAG_Current_crustacean.png", year),
#     width = 131.32,
#     height = 88.9,
#     units = "mm",
#     res = 300)
# p1_plot<-gridExtra::grid.arrange(kobe,
#                                  bar, ncol = 2,
#                                  respect = TRUE, top = "benthic")
# dev.off()



# 6. All
#~~~~~~~~~~~
bar <- plot_CLD_bar(catch_current, guild = "All", caption = TRUE, cap_year , cap_month , return_data = FALSE)

bar_dat <- plot_CLD_bar(catch_current, guild = "All", caption = TRUE, cap_year, cap_month , return_data = TRUE)
write.taf(bar_dat, file =paste0(year_cap, "_", ecoreg, "_FO_SAG_Current_All.csv"), dir = "report" )

kobe <- plot_kobe(catch_current, guild = "All", caption = TRUE, cap_year, cap_month , return_data = FALSE)
#check this file name
png(sprintf("report/%s_FO_FO_SAG_Current_all.png", year),
    width = 131.32,
    height = 88.9,
    units = "mm",
    res = 300)
p1_plot<-gridExtra::grid.arrange(kobe,
                                 bar, ncol = 2,
                                 respect = TRUE, top = "All stocks")
dev.off()


#~~~~~~~~~~~~~~~#
# C. Discards
#~~~~~~~~~~~~~~~#
# discardsA <- plot_discard_trends(catch_trends, year, cap_year, cap_month )
# 
# dat <- plot_discard_trends(catch_trends, year, cap_year , cap_month , return_data = TRUE)
# write.taf(dat, file =paste0(year_cap, "_", ecoreg, "_FO_SAG_Discards_trends.csv"), dir = "report" )
# 
# catch_trends2 <- catch_trends %>% filter(discards > 0)
# discardsB <- plot_discard_current(catch_trends2, year,position_letter = "b)", cap_year , cap_month , caption = FALSE)
# 
# discardsC <- plot_discard_current(catch_trends, year,position_letter = "c)", cap_year , cap_month )
# 
# #Need to change order?
# dat <- plot_discard_current(catch_trends, year, cap_year, cap_month , return_data = TRUE)
# write.taf(dat, file =paste0(year_cap,"_", ecoreg, "_FO_SAG_Discards_current.csv"),dir = "report" )
# 
# cowplot::plot_grid(discardsA, discardsB, discardsC, align = "h",nrow = 1, rel_widths = 1, rel_heights = 1)
# ggplot2::ggsave(paste0(year_cap,"_", ecoreg, "_FO_SAG_Discards.png"),path = "report/", width = 220.32, height = 88.9, units = "mm", dpi = 300)

# review units in x labels in b and c!!


#~~~~~~~~~~~~~~~#
#D. ICES pies
#~~~~~~~~~~~~~~~#

plot_status_prop_pies(clean_status, cap_month, cap_year)
ggplot2::ggsave(paste0(year_cap,"_", ecoreg, "_FO_SAG_ICESpies.png"), path= "report/", width = 178, height = 178, units = "mm", dpi = 300)

dat <- plot_status_prop_pies(clean_status, cap_month, cap_year, return_data = TRUE)
write.taf(dat, file= paste0(year_cap,"_", ecoreg, "_FO_SAG_ICESpies.csv"),dir ="report")

#~~~~~~~~~~~~~~~#
#E. GES pies
#~~~~~~~~~~~~~~~#

plot_GES_pies(clean_status, catch_current, cap_month, cap_year)
ggplot2::ggsave(paste0(year_cap,"_",ecoreg,"_FO_SAG_GESpies.png"),path = "report",width = 178, height = 178, units = "mm",dpi = 300)

dat <- plot_GES_pies(clean_status, catch_current, cap_month, cap_year, return_data = TRUE)
write.taf(dat, file = paste0(year_cap,"_",ecoreg, "_FO_SAG_GESpies.csv"),dir ="report")

#~~~~~~~~~~~~~~~#
#F. ANNEX TABLE
#~~~~~~~~~~~~~~~#


dat <- format_annex_table(clean_status, year)


# write.csv(dat, file = paste0(year_cap,"_", ecoreg, "_FO_SAG_annex_table.csv"))
format_annex_table_html(dat, cap_year, ecoreg_code)


write.taf(dat, file = paste0(year_cap,"_", ecoreg, "_FO_SAG_annex_table.csv"), dir = "report", quote=TRUE)

# This annex table has to be edited by hand,
# For SBL and GES only one values is reported,
# the one in PA for SBL and the one in MSY for GES
