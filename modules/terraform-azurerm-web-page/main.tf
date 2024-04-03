resource "null_resource" "web_upload" {
  provisioner "local-exec" {
    command = "az storage blob upload-batch -s ${var.index_path} -d '$web' --account-name ${var.storage_account_name} --overwrite"
  }

  triggers = {
    always_run = timestamp()
  }
}