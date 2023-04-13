output "os-version" {
  value = data.local_file.os.content
}
# just to read attributes
data "local_file" "os" {
  filename = "/etc/os-release"
}

data "aws_ebs_volume" "gp2_volume" {
  most_recent = true

  filter {
    name   = "volume-type"
    values = ["gp2"]
  }
}

output "volume_id" {
  value = data.aws_ebs_volume.gp2_volume.id
}