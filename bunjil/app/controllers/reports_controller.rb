class ReportsController < ApplicationController
  def create
  	@report=Report.new params[:report]
    @report.user = current_user
    @report.save
  	redirect_to report_path(id: @report.id)
  end 
  def show
    @report=Report.find(params[:id])
  
  end
  def email
    @report=Report.find(params[:id])
    Mailer.send_report(@report).deliver
    flash[:notify] = "email_sent!!"
    render 'app/mailers/send_report'
  end
end
