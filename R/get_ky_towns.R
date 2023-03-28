get_ky_towns <- function() {
  ky_landmarks <- landmarks("KY")

  ky_landmarks %>%
    dplyr::filter(FULLNAME %in% c("Berea", "Boonesborough", "Kirksville", "Richmond", "Waco"))
}

