class CasesController < ApplicationController

  # -------- INDEX --------

  def index
    @cases = Case.i_all
  end

  # -------- NEW --------

  def new
    @case = Case.i_new
  end

  # -------- CREATE --------

  def create
    CreateCase.call(properties: case_params, listener: self)
  end

  def create_success
    flash[:success] = 'Case was created'
    redirect_to cases_url
  end

  def create_failure(kase)
    @case = kase
    flash[:error] = 'Case was not created'
      render :new
  end

  private

  def case_params
    params.require(:case).permit(:name)
  end

end