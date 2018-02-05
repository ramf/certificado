require 'email_card.rb'
class CertificatesController < ApplicationController
  before_action :set_certificate, only: [:show, :edit, :update, :destroy, :export, :send_card]
  #Incluindo a lib para criar a chamada generate_certificate.rb
  require './lib/generate_certificate'

  # GET /certificates
  # GET /certificates.json
  def index
    @certificates = Certificate.all
    @nome_completo = Devise::LDAP::Adapter.get_ldap_param(current_user.username,"cn").first.force_encoding("utf-8")
    @q = Certificate.ransack(params[:q] || {"name_cont"=>current_user.username})
    @certificates = @q.result.order(:name).page(params[:page]).per(15)
  end

  # GET /certificates/1
  # GET /certificates/1.json
  def show
    @nome_completo = Devise::LDAP::Adapter.get_ldap_param(current_user.username,"cn").first.force_encoding("utf-8")
  end

  # GET /certificates/new
  def new
    @user = User.new
    authorize @user
    @nome_completo = Devise::LDAP::Adapter.get_ldap_param(current_user.username,"cn").first.force_encoding("utf-8")
    @certificate = Certificate.new
    @texts = Text.all
  end

  # GET /certificates/1/edit
  def edit
    @user = User.new
    authorize @user
  end

  # POST /certificates
  # POST /certificates.json
  def create
    @user = User.new

    @certificate = Certificate.new(certificate_params)
    respond_to do |format|
      if @certificate.save
        format.html { redirect_to @certificate, notice: 'Certificado criado com sucesso.' }
        format.json { render :show, status: :created, location: @certificate }
      else
        format.html { render :new }
        format.json { render json: @certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /certificates/1
  # PATCH/PUT /certificates/1.json
  def update
    respond_to do |format|
      if @certificate.update(certificate_params)
        format.html { redirect_to @certificate, notice: 'Certificado modificado com sucesso.' }
        format.json { render :show, status: :ok, location: @certificate }
      else
        format.html { render :edit }
        format.json { render json: @certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /certificates/1
  # DELETE /certificates/1.json
  def destroy
    @user = User.new
    authorize @user

    @certificate.destroy
    respond_to do |format|
      format.html { redirect_to certificates_url, notice: 'Certificado excluído com sucesso.' }
      format.json { head :no_content }
    end
  end

  def export

    if @certificate.text != nil
      @nome = Devise::LDAP::Adapter.get_ldap_param(@certificate.name,"cn").first.force_encoding("utf-8")
      GenerateCertificate::certificate(@certificate.name, @certificate.description,
      @certificate.text.description.gsub("{nome}","<b>"+@nome+"</b>"))
      redirect_to '/certificate.pdf'
    else
      respond_to do |format|
        format.html { redirect_to certificate_url, notice: 'Sem texto de Certificado Associoado' }
      end
    end
  end

  def send_card
    @user = User.new
    authorize @user
    @texts = Text.all

    if @certificate != nil
      @nome = Devise::LDAP::Adapter.get_ldap_param(@certificate.name,"cn").first.force_encoding("utf-8")
      GenerateCertificate::certificate(@certificate.name, @certificate.description,
      @certificate.text.description.gsub("{nome}","<b>"+@nome+"</b>"))
      EmailCard.send_card(@certificate)
      redirect_to '/certificates', notice: 'Certificado enviado com sucesso'
    else
      respond_to do |format|
        format.html { redirect_to certificates_url, notice: 'Sem e-mail associado' }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_certificate
      @certificate = Certificate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def certificate_params
      params.require(:certificate).permit(:name, :email, :description, :text_id)
    end
end
