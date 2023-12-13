output "ip" {
  value = data.http.current_public_ip.response_body
}
