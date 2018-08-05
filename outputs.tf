output "user_name" {
  value = "${aws_iam_user.algo-user.name}"
}

output "secrets" {
  value = <<EOF

----------------
Access Key Id: ${aws_iam_access_key.algo-user.id}
Secret Key: ${aws_iam_access_key.algo-user.secret}
----------------
EOF
}