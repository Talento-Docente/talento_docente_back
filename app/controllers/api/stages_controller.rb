class Api::StagesController < AuthApplicationController
  # Includes
  include RestHelper

  # Constants
  CLASS_NAME = "Api::FlowsController"
  LOG = LoggerService.new(class_name: CLASS_NAME)

  # Scopes
  before_action :init_search_helper
  before_action :set_element, only: [:show, :update, :destroy]

  def set_order
    _params[:sort_field] = "order_number"
    _params[:sort_order] = "asc"
  end

  def init_search_helper
    prepare_search(
      model: Stage,
      class_name: CLASS_NAME,
      params: params,
      search_params: search_params,
      element_params: element_params,
      services: %w[index show update create destroy],
      current_user: current_user,
      required_parent_model: true,
      parent_model: current_establishment.flows.find(params[:flow_id]),
      excluded: []
    )
  end

  def search_params
    params
      .permit(
        :page,
        :page_size,
        :sort_order,
        :sort_field,
        search_by: [
          :description,
          :name,
          :stage_type,
          :flow_id
        ]
      )
  end

  def element_params
    params
      .permit(
        :id,
        :description,
        :name,
        :stage_type,
        :order_number,
        :flow_id
      )
  end



end
