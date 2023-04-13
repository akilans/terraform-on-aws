terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.3.0"
    }
  }
}

resource "local_file" "myfile" {
    filename = "akilan.txt"
    content = "Hello Akilan"
}