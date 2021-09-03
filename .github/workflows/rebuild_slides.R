# this script is largely adapted from pkgdown::deploy_site_github()
setwd(here::here())

icons::download_fontawesome()

install.packages("RSQLite")

git <- function (..., echo_cmd = TRUE, echo = TRUE, error_on_status = TRUE)  {
  callr::run("git", c(...), echo_cmd = echo_cmd, echo = echo, 
             error_on_status = error_on_status)
}

rebuild_slides <- function() {
  dest_dir <- fs::dir_create(fs::file_temp())
  
  git("remote", "set-branches", "origin", "gh-pages")
  git("fetch", "origin", "gh-pages")
  git("submodule", "init")
  git("submodule", "update")
  git("worktree", "add", "--track", "-B", "gh-pages", dest_dir, "origin/gh-pages")
  
  unlink(dir(dest_dir, full.names = TRUE), TRUE, TRUE)
  
  rmds <- dir(pattern = "(index|\\d{2}-.*)\\.Rmd")
  file.copy(c("libs", "css", "img", "data", rmds), dest_dir, TRUE, TRUE)
  
  setwd(dest_dir)
  
  sapply(rmds, rmarkdown::render)
  unlink(c(rmds, "data"), TRUE, TRUE)
  git("add", "-A", ".")
  git("commit", "--allow-empty", "-m", "rebuilding slides")
  git("push", "--force", "origin", "HEAD:gh-pages")
}

rebuild_slides()
