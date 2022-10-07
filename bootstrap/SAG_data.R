taf.library(icesFO)

out <- load_sag(2022, "Faroes")

sag_complete <- out
write.taf(out, file = "SAG_complete_BtS.csv", quote = TRUE)


status <- load_sag_status(2022)
write.taf(status, file = "bootstrap/data/SAG_data/SAG_status.csv", quote = TRUE)
