#require 'test_helper'

class AppointmentDecoratorTest < Drape::TestCase

  #require 'spec_helper'

describe AppointmentDecorator do

  let(:appointment_time) { '10:00'  }

  let(:appointment) { FactoryGirl.build(:appointment,
                                 appointment_time: appointment_time) }

  let(:decorator) { appointment.decorate }

  describe '.fixed_time' do

    before do
        appointment.appointment_time = '10:00'
      end

      it 'should return the fixed time' do
        expect(decorator.fixed_time).to eq("#{ appointment_time }")
      end
    end
  end
end
