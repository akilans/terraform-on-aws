resource "local_file" "file" {
    filename = var.filename
    file_permission =  var.permission
    content = random_string.string.id

    lifecycle {
      prevent_destroy = true
    }
    
}

resource "random_string" "string" {
    length = var.length
    keepers = {
        length = var.length
    }
  lifecycle {
    create_before_destroy = true
  }
}

