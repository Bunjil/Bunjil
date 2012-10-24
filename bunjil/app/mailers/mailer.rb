class Mailer < ActionMailer::Base
  # This is a hash of default values for any email you send, in this case 
  # we are setting the :from header to a value for all messages in this 
  # class, this can be overridden on a per email basis
  default from: "notifications@bunjil.com" # has no effect atm
def send_report(report, to)
  @report = report
  @name = "user"
  @home_url  = "http://bunjil.com/"
  mail(:to => to, :subject => "Area Report")
end
def request_report(to, user, intersection)
  @report = report
  @name = user.username
  @home_url  = "http://bunjil.com/"
  mail(:to => to, :subject => "Report Request")
end

end
