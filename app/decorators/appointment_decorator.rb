class AppointmentDecorator < Drape::Decorator

  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def fixed_date
    object.appointment_date.strftime("%A, %e %B, %Y")
  end

  def fixed_time
    object.appointment_time.strftime("%I:%M%p")
  end

end
