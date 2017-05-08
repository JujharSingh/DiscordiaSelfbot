return {
  name = "filwisher/lua-tape",
  version = "0.0.3",
  description = "A testing harness based on substack/tape",
  tags = { "testing", "tests", "harness", "tape", "tap" },
  license = "MIT",
  author = { name = "FilWisher", email = "williamsykesfisher@gmail.com" },
  homepage = "https://github.com/filwisher/lua-tape",
  dependencies = {
    "luvit/deep-equal"
  },
  files = {
    "**.lua",
    "!test*"
  }
}
  
