resource "local_file" "test" {
    filename = "${each.value}.txt"
    content = each.value
    for_each = toset(var.file_name)
}