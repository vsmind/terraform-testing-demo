# Check blocks are only available in Terraform v1.5.0 and later.
check "health_check" {
  # zero-to-one scoped data sources
  data "http" "health_check" {
    url = module.web_site_storage.static_web_site_url

    depends_on = [time_sleep.one_minute] # Ensure the site is up before checking
  }

  # one-to-many assertions
  assert {
    condition     = data.http.health_check.status_code == 200
    error_message = "${data.http.health_check.status_code} returned an unhealthy status code"
  }

  assert {
    condition     = strcontains(data.http.health_check.response_body, "CEGALIANS")
    error_message = "The body of the response was not as expected"
  }
}
