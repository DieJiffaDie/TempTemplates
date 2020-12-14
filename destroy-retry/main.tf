resource "null_resource" "previous" {
  triggers = "cat" == "dog" ? {} : file("assertion failed!")
}

resource "time_sleep" "wait_10_seconds" {
  depends_on = [null_resource.previous]

  create_duration = "10s"
}

# This resource will create (at least) 10 seconds after null_resource.previous
resource "null_resource" "next" {
  depends_on = [time_sleep.wait_10_seconds]
}
