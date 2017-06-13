
# Configure the DNSimple provider
provider "dnsimple" {
  token = "testing"
  account = "test"
}

resource "dnsimple_record" "foobar" {
  domain = "testing.co.uk"
  name   = "testing"
  value  = ${aws_instance.web.o.public_ip}

#Two options for Value
#this option creates A records for every A-record (you need also to iterate the name then

  value = ${element(aws_instance.web.*.public_ip,0)}"
  type   = "A"
  ttl    = 3600

}
