require 'prawn'
require 'gruff'

module GenerateStudent
  PDF_OPTIONS = {
    # Escolhe o Page size como uma folha A4
    :page_size   => "A4",
    # Define o formato do layout como portrait (poderia ser landscape)
    :page_layout => :landscape,
    # Define a margem do documento
    :margin      => [40, 75],
    :background  => "lib/imagens/fundon.jpg"
    #:image => "lib/imagens/fundon.jpg"
  }

  def self.student name, description, text
    # Apenas uma string aleatório para termos um corpo de texto pro contrato
    #lorem_ipsum = ""

    Prawn::Document.new(PDF_OPTIONS) do |pdf|
      # Define a cor do traçado
      pdf.fill_color "666666"
      # Cria um texto com tamanho 30 PDF Points, bold alinha no centro
      #pdf.text "João Pintinho His Name", :size => 32, :style => :bold, :align => :center
      # Move 80 PDF points para baixo o cursor
      pdf.move_down 80
      # Escreve o texto do contrato com o tamanho de 14 PDF points, com o alinhamento justify
      #pdf.text "#{lorem_ipsum}", :size => 12, :align => :justify, :inline_format => true
      # Move mais 30 PDF points para baixo o cursor
      pdf.move_down 50
      # Escreve o texto com os detalhes que o usuário entrou
      #pdf.text "#{details}", :size => 12, :align => :justify, :inline_format => true
      # Move mais 30 PDF points para baixo o cursor
      pdf.move_down 10
      # Adiciona o nome com 12 PDF points, justify e com o formato inline (Observe que o <b></b> funciona para deixar em negrito)
      #pdf.text "O Tribunal de Justiça do Estado do Ceará, CERTIFICA a <b>#{name}</b>, pelo cumprimento da Meta 2 de 2016, estabelecida pelo Conselho Nacional de Justiça."" \"Identificar e julgar, até 31/12/2016, pelo menos 80% dos processos distribuídos até 31/12/2012, no 1º grau, e até 31/12/2013, no 2º grau, e 100% dos processos distribuídos até 31/12/2013, nos Juizados Especiais e Turmas Recursais.\"", :size => 20, :align => :justify, :inline_format => true
      pdf.text text, :size => 20, :align => :justify, :inline_format => true
      # Muda de font para Helvetica
      #pdf.image "lib/imagens/fundon.jpg", :scale => 0.9, :align => :justify, :inline_format => true

      #bg_image = 'lib/imagens/fundon.jpg'
      #pdf.image bg_image, :scale => -0.6, :align => :center

      pdf.font "Helvetica"
      # Inclui um texto com um link clicável (usando a tag link) no bottom da folha do lado esquerdo e coloca uma cor especifica nessa parte (usando a tag color)
      pdf.text "", :size => 10, :inline_format => true, :valign => :bottom, :align => :left
      # Inclui em baixo da folha do lado direito a data e o némero da página usando a tag page
      #pdf.number_pages "Gerado: #{I18n.l Date.today, :format => :long}", :start_count_at => 0, :page_filter => :all, :at => [pdf.bounds.right - 140, 7], :align => :right, :size => 8
      # Gera no nosso PDF e coloca na pasta public com o nome agreement.pdf
      pdf.render_file('public/student.pdf')
    end
  end
end
