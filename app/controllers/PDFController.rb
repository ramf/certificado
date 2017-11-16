require 'generate_pdf'
class TasksController < ApplicationContoller
  include GeneratePdf
  def Action
    generate_pdf( download = true )
  end
end
