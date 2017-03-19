class StaticPagesController < ApplicationController
  
  def home
    if logged_in?
      @patients = Patient.all
      @appointment  = current_doctor.appointments.build
      @feed_items = current_doctor.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
