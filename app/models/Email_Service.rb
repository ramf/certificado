class EmailService
  def self.send_email(from, to, subject, path)
    mail = Mail.new do
      from    'noreply@tjce.com'
      to       '@agreement.email'
      subject  '@agreement.name'
      body template
     # if  File.file?(log_path) then
      #  add_file log_path
     #end
    end
    puts mail.to_s
    mail.delivery_method :smtp, { address: "webmail.tj.ce.gov.br", port: 25, openssl_verify_mode: "none" }
    mail.deliver
  end
end
