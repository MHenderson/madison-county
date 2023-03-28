save_plot <- function(p, image_path) {
  agg_png(image_path, res = 300, height = 7, width = 5.35, units = "in")
  print(p)
  dev.off()
}
