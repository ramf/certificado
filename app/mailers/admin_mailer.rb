class AdminMailer < ApplicationMailer

  def agreement(user)
    @user = user

    attachments['agreement.pdf'] = agreement

    mail(:to => user.email, :subject => "Invoice Recieved")
  end

  private

    # I had troubles trying to get Prawn to generate 'in memory'
    # so just write to, then read, then unlink a tempfile
    def generate_pdf_content
      pdf = Prawn::Document.new
      Tempfile.create do |f|
        pdf.render_file f
        f.flush
        File.read(f)
      end
    end
end
