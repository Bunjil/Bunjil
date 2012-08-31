class ReportsController < ApplicationController
  def create
	@report=Report.create params[:report]
	redirect_to report_path(id: @report.id)
  end 
  def show
	@report=Report.find(params[:id])
	
  end
end
