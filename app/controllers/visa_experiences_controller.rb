class VisaExperiencesController < AuthenticationController
  before_action :set_visa_experience, only: %i[show update destroy]
  before_action :authenticate_request

  # GET /visa_experiences
  def index
    visa_experiences = VisaExperience.all
    visa_experiences = apply_filters(visa_experiences)
    visa_experiences = visa_experiences.page(params[:page_number] || 1).per(10)
    render json: { visa_experiences: visa_experiences, pagination_meta: pagination_meta(visa_experiences) }, status: :ok
  end

  # GET /visa_experiences/1
  def show
    render json: @visa_experience
  end

  # POST /visa_experiences
  def create
    @visa_experience = VisaExperience.new(visa_experience_params, user: @current_user)

    if @visa_experience.save
      render json: { data: @visa_experience, message: 'Successfully Created' }, status: :ok
    else
      render json: { data: @visa_experience.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /visa_experiences/1
  def update
    if @visa_experience.update(visa_experience_params)
      render json: @visa_experience
    else
      render json: @visa_experience.errors, status: :unprocessable_entity
    end
  end

  # DELETE /visa_experiences/1
  def destroy
    @visa_experience.destroy!
  end

  private

  def set_visa_experience
    @visa_experience = VisaExperience.find(params[:id])
  end

  def visa_experience_params
    params.permit(:visa_type, :description, :page_number, :current_user, :start_date, :end_date)
  end

  def pagination_meta(collection)
    {
      current_page: collection.current_page,
      total_count: collection.total_count,
      page_size: 10
    }
  end

  def apply_filters(visa_experiences)
    visa_experiences = visa_experiences.where(country: params[:country]) if params[:country].present?
    visa_experiences = visa_experiences.where(visa_type: params[:visa_type]) if params[:visa_type].present?
    visa_experiences = visa_experiences.where(user_id: @current_user.id) if params[:current_user].present?
    visa_experiences
  end
end
