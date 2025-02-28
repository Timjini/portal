class FormMailer < ApplicationMailer

  def contact_form_submission(form_data)
    @form_data = form_data
    mail(to: 'info@chambersforsport.com', cc:"hatim.jini@gmail.com" , subject: @form_data[:subject])
  end

end
