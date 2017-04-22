class HospitalsController < ApplicationController

  # GET /hospitals
  # GET /hospitals.json
  def index
    @hospitals = Hospital.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.csv { send_data @hospitals.to_csv, filename: "hospitals-#{Date.today}.csv" }
    end
  end

  def new
    @hospital = Hospital.new
  end

  def show
    @hospital = Hospital.find params[:id]

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "hospital",
               template: "hospitals/show.pdf.erb",
               locals: {:hospital => @hospital}
      end
    end
  end

  def create
    @hospital = Hospital.new(hospital_params)    # Not the final implementation!
    if @hospital.save
      # Handle a successful save
      flash[:success] = "Hospital added to the system!."
      redirect_to hospitals_path
    else
      render 'new'
    end
  end

  private

    def hospital_params
      params.require(:hospital).permit(:hospital_name, :county)
    end
end
