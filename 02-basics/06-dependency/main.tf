
resource "local_file" "pet_name" {
	    content = "We love pets!"
	    filename = "/root/pets.txt"
        depends_on = [
          random_pet.my-pet
        ]
}


resource "random_pet" "my-pet" {
	      prefix = "Mrs"
	      separator = "."
	      length = "1"
}

resource "tls_private_key" "pvtkey" {
    algorithm = "RSA"
}

resource "tls_private_key" "pvtkey" {
    algorithm = "RSA"
    rsa_bits = "4096"
}

resource "local_file" "key_details" {
  filename = "/root/key.txt"
  content = tls_private_key.pvtkey.private_key_pem
}
