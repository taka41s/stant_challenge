class PalestrasController < ApplicationController
  before_action :set_palestra, only: %i[ show edit update destroy ]

  # GET /palestras or /palestras.json
  def index
    @palestras = Palestra.all
  end

  # GET /palestras/1 or /palestras/1.json
  def show
  end

  # GET /palestras/new
  def new
    @palestra = Palestra.new
  end

  # GET /palestras/1/edit
  def edit
  end

  # POST /palestras or /palestras.json
  def create
    @palestra = Palestra.new(palestra_params)

    respond_to do |format|
      if @palestra.save
        format.html { redirect_to palestra_url(@palestra), notice: "Palestra was successfully created." }
        format.json { render :show, status: :created, location: @palestra }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @palestra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /palestras/1 or /palestras/1.json
  def update
    respond_to do |format|
      if @palestra.update(palestra_params)
        format.html { redirect_to palestras_path, notice: "Palestra was successfully updated." }
        format.json { render :show, status: :ok, location: @palestra }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @palestra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /palestras/1 or /palestras/1.json
  def destroy
    @palestra.destroy

    respond_to do |format|
      format.html { redirect_to palestras_url, notice: "Palestra was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def upload
  end

  def converted_upload_to_json
    parsed_elements = Parser.new(archive_path: params[:document]).make
    json_elements_converted = []

    parsed_elements[:track_a].map{|x| x}.each do |palestra|
      @palestra = Palestra.new(palestra)
      @palestra.track = "Track A"
      @palestra.save
    end

    parsed_elements[:track_b].map{|x| x}.each do |palestra|
      @palestra = Palestra.new(palestra)
      @palestra.track = "Track B"
      @palestra.save
    end

    parsed_elements.each do |parsed|
      json_elements_converted << parsed.to_json
    end

    render json: json_elements_converted
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_palestra
      @palestra = Palestra.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def palestra_params
      params.require(:palestra).permit(:event, :duration, :schedule, :document, :track)
    end
end