resource "local_file" "test" {
    filename = var.file_name[count.index]
    content = var.file_name[count.index]
    #count = 3
    count = length(var.file_name)
}

#count may lead issue while updating, so use for each