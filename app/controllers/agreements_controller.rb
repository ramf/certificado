require 'email_service.rb'

class AgreementsController < ApplicationController
  # No Before Action nós adicionamos também o export para que ele consiga pegar o agreement correto
  before_action :set_agreement, only: [:show, :edit, :update, :destroy, :export, :send_email]
  # Nós incluimos aqui a lib que vamos criar chamada generate_pdf.rb
  require './lib/generate_pdf'

  # GET /agreements
  # GET /agreements.json
  def index
    @agreements = Agreement.all
    @nome_completo = Devise::LDAP::Adapter.get_ldap_param(current_user.username,"cn").first.force_encoding("utf-8")
    @q = Agreement.ransack(params[:q])
    @agreements = @q.result.order(:client_name, :description).page(params[:page]).per(15)
  end

  # GET /agreements/1
  # GET /agreements/1.json
  def show

  end

  # GET /agreements/new
  def new
    @nome_completo = Devise::LDAP::Adapter.get_ldap_param(current_user.username,"cn").first.force_encoding("utf-8")
    @user = User.new
    authorize @user
    @agreement = Agreement.new
    @texts = Text.all

  end

  # GET /agreements/1/edit
  def edit

    @user = User.new
    authorize @user

    @texts = Text.all
  end

  # POST /agreements
  # POST /agreements.json
  def create
    @agreement = Agreement.new(agreement_params)

    respond_to do |format|
      if @agreement.save
        format.html { redirect_to @agreement, notice: 'Certificado criado com sucesso.' }
        format.json { render :show, status: :created, location: @agreement }
      else
        format.html { render :new }
        format.json { render json: @agreement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agreements/1
  # PATCH/PUT /agreements/1.json
  def update
    @texts = Text.all

    puts params

    respond_to do |format|

      if @agreement.update(agreement_params)
        format.html { redirect_to @agreement, notice: 'Certificado atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @agreement }
      else
        format.html { render :edit }
        format.json { render json: @agreement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agreements/1
  # DELETE /agreements/1.json
  def destroy
    @user = User.new
    authorize @user

    @agreement.destroy
    respond_to do |format|
      format.html { redirect_to agreements_url, notice: 'Certificado excluído com sucesso.' }
      format.json { head :no_content }
    end
  end

  # Criamos este método que vai chamar nossa lib para gerar o PDF e depois redirecionar o user para o arquivo PDF
  def export
    @user = User.new
    authorize @user

    if @agreement.text != nil
       @nome = Devise::LDAP::Adapter.get_ldap_param(@agreement.client_name,"cn").first.force_encoding("utf-8")
       GeneratePdf::agreement(@agreement.client_name, @agreement.description,
       @agreement.text.description.gsub("{nome}","<b>"+@nome+"</b>"))
       redirect_to '/agreement.pdf'
    else
      respond_to do |format|
        format.html { redirect_to agreements_url, notice: 'Sem texto de Certificado Associoado' }
      end
    end
  end

  def send_email
    @user = User.new
    authorize @user
    @texts = Text.all

    puts @agreement.inspect
    if @agreement != nil
      EmailService.send_email(@agreement)
      redirect_to '/agreements', notice: 'Certificado enviado com sucesso'
    else
      respond_to do |format|
        format.html { redirect_to agreements_url, notice: 'Sem e-mail associado' }
      end
    end
  end

  private
    def set_agreement
      @agreement = Agreement.find(params['id'])
    end

    def agreement_params
      puts params.inspect
      params.require(:agreement).permit(:client_name, :description, :price, :text_id, :email, :name)
    end
end
