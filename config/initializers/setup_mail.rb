ActionMailer::Base.smtp_settings = {
  :address              => "webmail.tj.ce.gov.br",
  :port                 => 25,
  :openssl_verify_mode  => "none",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
