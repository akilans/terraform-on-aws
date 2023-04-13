
resource "local_file" "pet_name" {
	    content = var.file_data["content"]
	    filename = var.file_data["filename"]
}

resource "random_pet" "my-pet" {
	      prefix = var.pet_prefix
	      separator = "."
	      length = "1"
}

output "animal_name" {
    value = random_pet.my-pet.id
}