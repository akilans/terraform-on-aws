variable "file_data" {
    type = map
    default = {
        filename = "hello.txt"
        content = "Hello Akilan"
    }
}

variable "pet_prefix" {
    type = string
    default = "rocky"
}