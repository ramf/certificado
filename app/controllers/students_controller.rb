require 'email_student.rb'

class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy, :export, :send_student]
  #Incluindo a lib para criar a chamada generate_student.rb
  require './lib/generate_student'

  # GET /students
  # GET /students.json
  def index
    @nome_completo = Devise::LDAP::Adapter.get_ldap_param(current_user.username,"cn").first.force_encoding("utf-8")
    @students = Student.all
    @q = Student.ransack(params[:q])
    @students = @q.result.order(:name).page(params[:page]).per(15)
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @nome_completo = Devise::LDAP::Adapter.get_ldap_param(current_user.username,"cn").first.force_encoding("utf-8")
    @student = Student.new
    @texts = Text.all
  end

  # GET /students/1/edit
  def edit
    @nome_completo = Devise::LDAP::Adapter.get_ldap_param(current_user.username,"cn").first.force_encoding("utf-8")
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Certificado para aluno externo criado com sucesso.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Certificado atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Certificado excluído com sucesso.' }
      format.json { head :no_content }
    end
  end

  # Criamos este método que vai chamar nossa lib para gerar o PDF e depois redirecionar o user para o arquivo PDF
  def export

    if @student.text != nil
       GenerateStudent::student(@student.name, @student.description,
       @student.text.description.gsub("{nome}","<b>"+@student.name+"</b>"))
       redirect_to '/student.pdf'
    else
      respond_to do |format|
        format.html { redirect_to student_url, notice: 'Sem texto de Certificado Associoado' }
      end
    end
  end

  def send_student

    if @student != nil
      GenerateStudent::student(@student.name, @student.description,
      @student.text.description.gsub("{nome}","<b>"+@student.name+"</b>"))
      EmailStudent.send_student(@student)
      redirect_to '/students', notice: 'Certificado enviado com sucesso'
    else
      respond_to do |format|
        format.html { redirect_to students_url, notice: 'Sem e-mail associado' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :email, :description, :text_id)
    end
end
